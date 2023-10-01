const express = require('express');
const mysql2 = require('mysql2');
require('dotenv').config();

const app = express();
app.listen(80);

let con = mysql2.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB
});

con.connect(function (err) {
  if (err) {
    console.log(err);
    throw err;
  }
  console.log("Connection with mysql established");
});

app.get('/imoveis', function (req, res) {
  let sql = `SELECT id_venda, data_pagamento, valor_pagamento, id_imovel, descricao_imovel, descricao_tipo
    FROM pagamento INNER JOIN venda ON pagamento.venda_id = venda.id_venda
    INNER JOIN imovel ON venda.imovel_id = id_imovel
    INNER JOIN tipoimovel ON imovel.tipo_imovel`;
  con.query(sql, function (err, result) {
    if (err) {
      res.status(500);
      res.send(JSON.stringify(err));
    } else {
      res.send(JSON.stringify(result));
    }
  })
});

//a) Implementar função que retorne uma lista com o id de cada imóvel e sua respectiva soma de todos
//os pagamentos 
app.get('/sum_by_id', function (req, res) {
  let sql = `SELECT id_imovel, valor_pagamento
  FROM pagamento INNER JOIN venda ON pagamento.venda_id = venda.id_venda
  INNER JOIN imovel ON venda.imovel_id = id_imovel`;
  con.query(sql, function (err, result) {
    if (err) {
      res.status(500);
      res.send(JSON.stringify(err));
    } else {
      let sumById = new Map();
      result.forEach(record => {
        if (sumById.get(record['id_imovel']) === undefined) {
          sumById.set(record['id_imovel'], {
            properties: record['id_imovel'],
            value: record['valor_pagamento']
          });
        } else {
          sumById.get(record['id_imovel']).value += record['valor_pagamento']
        }
      });
      let arraySumById = Array.from(sumById.values());
      res.send(JSON.stringify(arraySumById));
    }
  })
});
//Implementar uma lista com cada mês e ano e total de vendas
app.get('/total_payments_per_month_year', function (req, res) {
  let sql = `SELECT valor_pagamento, year(data_pagamento) as year, month(data_pagamento) as month
  FROM pagamento INNER JOIN venda ON pagamento.venda_id = venda.id_venda
  INNER JOIN imovel ON venda.imovel_id = id_imovel`;
  con.query(sql, function (err, result) {
    if (err) {
      res.status(500);
      res.send(JSON.stringify(err));
    } else {
      let totalPerMonth = new Map()

      result.forEach(record => {
        let periodKey = record['month'] + "_" + record['year'];
        if (totalPerMonth.get(periodKey) === undefined) {
          totalPerMonth.set(periodKey, {
            month: record['month'],
            year: record['year'],
            value: record['valor_pagamento']
          });
        } else {
          totalPerMonth.get(periodKey).value += record['valor_pagamento'];
        }
      });
      let arrayTotalPerMonth = Array.from(totalPerMonth.values());
      res.send(JSON.stringify(arrayTotalPerMonth));
    }
  });
});
// implementar função que retorne uma lista com cada tipo de imóvel registrado e seu respetivo percentual
app.get('/rating', function (req, res) {
  let sql = `SELECT id_venda, descricao_tipo
  FROM tipoimovel INNER JOIN imovel ON tipoimovel.id_tipoImovel = imovel.tipo_imovel
  INNER JOIN venda ON venda.imovel_id = id_imovel;`;
  con.query(sql, function (err, result) {
    if (err) {
      res.status(500);
      res.send(JSON.stringify(err));
    } else {
      let totalPerRating = new Map()
      let totalElements = result.length;
      result.forEach(record => {
        let ratingKey = record['descricao_tipo'];
        if (totalPerRating.get(ratingKey) === undefined) {
          totalPerRating.set(ratingKey, {
            value: 1,
            rating: ratingKey,
          });
        } else {
          totalPerRating.get(ratingKey).value++;
        }
      });
      let arrayTotalPerRating = Array.from(totalPerRating.values());
      arrayTotalPerRating = arrayTotalPerRating.map(el => {
        el.proportion = (el.value / totalElements * 100).toFixed(2);
        return el
      });
      res.send(JSON.stringify(arrayTotalPerRating));
    }
  })
});
