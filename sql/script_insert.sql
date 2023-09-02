SELECT * FROM tipoimovel;
SELECT * FROM imovel;
SELECT * FROM venda;
SELECT * FROM pagamento;

INSERT INTO tipoimovel (descricao_tipo) VALUES ("apartamento"), ("casa"), ("terreno"), ("galpão");

INSERT INTO imovel (tipo_imovel, descricao_imovel) 
VALUES 
(1, "Apartamanento, 52m², vista para o mar"),
(1, "Apartamanento, 63m², vista para a montanha"),
(1, "Apartamento, 120m², com banheira"),
(2, "Casa, 100m², amplo espaço nos fundos"),
(2, "Casa, 80m², com piscina e jardim"),
(3, "Terreno, 1000m², polo industrial"),
(3, "Terreno, 200m², 10m de frente 20m de fundos"),
(4, "Galpão, 1000m², com 3 salas de escritorio"),
(4, "Galpão, 1000m², polo industrial");

INSERT INTO venda (imovel_id) VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9);

INSERT INTO pagamento (data_pagamento, valor_pagamento, venda_id) 
VALUES ("2023-01-10", 1000.00, 1), ("2023-02-10", 1000.00, 1),
 ("2023-03-10", 1000.00, 1), ("2023-04-10", 1000.00, 1),
 ("2023-05-10", 1000.00, 1),("2023-06-10", 1000.00, 1),
 ("2023-03-10", 1350.00, 2), ("2023-04-10", 1350.00, 2),
 ("2023-04-10", 10000.00, 3), ("2023-05-10", 10000.00, 3),
 ("2023-05-10", 10000.00, 3), ("2023-06-10", 10000.00, 3),
 ("2023-04-10", 3500.00, 4),("2023-05-10", 3500.00, 4),
 ("2023-04-10", 3000.00, 5),("2023-05-10", 3000.00, 5),
 ("2023-02-10", 20000.00, 6),("2023-03-10", 20000.00, 6),
 ("2023-07-10", 10000.00, 3), ("2023-08-10", 10000.00, 3),
 ("2023-02-10", 150000.00, 8),("2023-03-10", 200000.00, 9),
 ("2023-02-10", 75000.00, 7),("2023-03-10", 10000.00, 7),
  ("2023-01-10", 5000.00, 2), ("2023-02-10", 5000.00, 2),
  ("2023-01-20", 1000.00, 1), ("2023-02-20", 1000.00, 1),
  ("2023-01-20", 1000.00, 3), ("2023-02-20", 1000.00, 3);


SELECT id_venda, data_pagamento, valor_pagamento, id_imovel, descricao_imovel, descricao_tipo
FROM pagamento INNER JOIN venda ON pagamento.venda_id = venda.id_venda
INNER JOIN imovel ON venda.imovel_id = id_imovel
INNER JOIN tipoimovel ON imovel.tipo_imovel;