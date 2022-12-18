SELECT * FROM clientes WHERE id NOT IN (SELECT id_cliente FROM compras);
-- porém ele não mostra o resultado correto, ele mostra um item a mais do que deveria