INSERT INTO compras (id_cliente,id_produto) SELECT clientes.id,produtos.id FROM clientes,produtos WHERE clientes.nome='Chico Buarque de Holanda' AND produtos.nome='Violão Lava ME 2';
