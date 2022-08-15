-- Active: 1660408859573@@127.0.0.1@5432@northwind
--* INNER JOIN (JOIN)

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

SELECT order_id, customer_id, first_name, last_name, title
FROM orders
INNER JOIN employees ON orders.employee_id = employees.employee_id;

SELECT order_date, product_name, ship_country, products.unit_price, quantity, discount
FROM orders
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id;