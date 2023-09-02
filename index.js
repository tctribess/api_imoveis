const express = require('express');
const mysql2 = require('mysql2');
require('dotenv').config();

const app = express();
app.listen(80);

let con = mysql2.createConnection({
  host : process.env.DB_HOST,
  user : process.env.DB_USER,
  password : process.env.DB_PASS,
  database : process.env.DB
  });

  con.connect(function(err) {
    if (err){
      console.log(err);
      throw err;
    }
    console.log("Connection with mysql established");
  });

  app.get('/imoveis', function (req, res) {
    let sql =`SELECT id_venda, data_pagamento, valor_pagamento, id_imovel, descricao_imovel, descricao_tipo
    FROM pagamento INNER JOIN venda ON pagamento.venda_id = venda.id_venda
    INNER JOIN imovel ON venda.imovel_id = id_imovel
    INNER JOIN tipoimovel ON imovel.tipo_imovel`;
    con.query(sql, function (err, result) {
      if (err){ 
        res.status(500);
        res.send(JSON.stringify(err));
      }else{
        res.send(JSON.stringify(result));
      }})});
