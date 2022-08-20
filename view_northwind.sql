-- Active: 1660408859573@@127.0.0.1@5432@northwind

CREATE VIEW products_suppliers_categories AS
SELECT product_name, quantity_per_unit, unit_price, units_in_stock,
company_name, contact_name, phone,
category_name, description
FROM products
JOIN suppliers USING(supplier_id)
JOIN categories USING(category_id);

SELECT *
FROM products_suppliers_categories;

SELECT *
FROM products_suppliers_categories
WHERE unit_price > 20;

DROP VIEW IF EXISTS products_suppliers_categories;



SELECT * FROM orders;

CREATE VIEW heavy_orders AS
SELECT *
FROM orders
WHERE freight > 50;

SELECT *
FROM heavy_orders
ORDER BY freight;

CREATE OR REPLACE VIEW heavy_orders AS
SELECT *
FROM orders
WHERE freight > 100;


SELECT MAX(order_id)
FROM orders;

--* insert можно делать в view КОГДА представление сделано с одной таблицы
INSERT INTO heavy_orders
VALUES (11078, 'VINET', 5, '2019-12-10', '2019-12-15', '2019-12-14', 1, 120,
		'Hanari Carnes', 'Rua do Paco', 'Bern', NULL, 3012, 'Switzerland');

SELECT *
FROM heavy_orders
ORDER BY order_id DESC;


CREATE OR REPLACE VIEW heavy_orders AS
SELECT *
FROM orders
WHERE freight > 100
WITH LOCAL CHECK OPTION;        --* налаживает на вью проверку в данном случае чтобы в будущем нельзя было вставить
                                --* данные в которых freight <= 100

CREATE OR REPLACE VIEW heavy_orders AS
SELECT *
FROM orders
WHERE freight > 100
WITH CASCADE CHECK OPTION;        --* налаживает на вью проверку в данном случае чтобы в будущем нельзя было вставить
                                  --* данные в которых freight <= 100
                                  --* CASCADE - если наше вью оснвано на других вью и мы хотим чтобы использовало их CHECK