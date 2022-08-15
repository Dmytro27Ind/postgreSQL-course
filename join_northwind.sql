-- Active: 1660408859573@@127.0.0.1@5432@northwind
--* INNER JOIN

SELECT product_name, suppliers.company_name, units_in_stock
FROM products
INNER JOIN suppliers ON products.supplier_id = suppliers.supplier_id
ORDER BY units_in_stock DESC;

SELECT category_name, SUM(units_in_stock) AS units
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
GROUP BY category_name
ORDER BY units DESC
LIMIT 5;

SELECT category_name, SUM(units_in_stock * unit_price) AS amount
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
WHERE discontinued != 1
GROUP BY category_name
HAVING SUM(units_in_stock * unit_price) > 5000
ORDER BY amount DESC;