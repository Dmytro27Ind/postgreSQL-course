-- Active: 1660408859573@@127.0.0.1@5432@northwind

SELECT DISTINCT country
FROM customers;

SELECT company_name
FROM suppliers
WHERE country IN ('Argentina', 'Spain', '... and other');

SELECT DISTINCT company_name
FROM suppliers
WHERE country IN   (SELECT DISTINCT country
                    FROM customers);

SELECT DISTINCT suppliers.company_name
FROM suppliers
INNER JOIN customers USING(country);

SELECT DISTINCT suppliers.company_name
FROM suppliers
JOIN customers ON suppliers.country = customers.country;

SELECT category_name, SUM(units_in_stock) AS units_in_stock
FROM categories
LEFT JOIN products USING(category_id)
GROUP BY category_name
ORDER BY units_in_stock DESC
LIMIT (SELECT MIN(product_id) FROM products) + 4;

SELECT category_name, SUM(units_in_stock) AS units_in_stock
FROM categories
LEFT JOIN products USING(category_id)
GROUP BY category_name
ORDER BY units_in_stock DESC
LIMIT (SELECT MIN(product_id) + 4 FROM products);

SELECT AVG(units_in_stock)
FROM products;

SELECT product_name, units_in_stock
FROM products
WHERE units_in_stock > (SELECT AVG(units_in_stock)
                        FROM products)
ORDER BY units_in_stock;


--* ---------------------------------------------------------------------
--* WHERE EXISTS, WHERE NOT EXISTS
--* ---------------------------------------------------------------------

SELECT company_name, contact_name
FROM customers
WHERE EXISTS (  SELECT customer_id FROM orders
                WHERE customer_id = customers.customer_id
                AND freight BETWEEN 50 AND 100);

SELECT company_name, contact_name
FROM customers
WHERE NOT EXISTS (  SELECT customer_id FROM orders
                WHERE customer_id = customers.customer_id
                AND order_date BETWEEN '1995-02-01' AND '1995-02-15');