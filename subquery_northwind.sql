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

SELECT company_name, contact_name
FROM customers
WHERE EXISTS (  SELECT customer_id FROM orders
                WHERE customer_id = customers.customer_id
                AND order_date BETWEEN '1997-06-01' AND '1997-06-04');

SELECT company_name, contact_name
FROM customers
JOIN orders USING(customer_id)
WHERE order_date BETWEEN '1997-06-01' AND '1997-06-04';


--* ---------------------------------------------------------------------
--* ANY, ALL
--* ---------------------------------------------------------------------

SELECT company_name, SUM(quantity) as quantity
FROM customers
JOIN orders USING(customer_id)
JOIN order_details USING(order_id)
WHERE quantity > 40
GROUP BY company_name
ORDER BY quantity;

SELECT DISTINCT company_name
FROM customers
JOIN orders USING(customer_id)
JOIN order_details USING(order_id)
WHERE quantity > 40;

SELECT customer_id
FROM orders
JOIN order_details USING(order_id)
WHERE quantity > 40;

SELECT DISTINCT company_name
FROM customers
WHERE customer_id IN (  SELECT customer_id
                        FROM orders
                        JOIN order_details USING(order_id)
                        WHERE quantity > 40);

SELECT DISTINCT company_name
FROM customers
WHERE customer_id = ANY(
    SELECT customer_id
    FROM orders
    JOIN order_details USING(order_id)
    WHERE quantity > 40
);

SELECT AVG(quantity)
FROM order_details;

SELECT product_name, quantity
FROM products
JOIN order_details USING(product_id)
WHERE quantity > (
    SELECT AVG(quantity)
    FROM order_details
)
ORDER BY quantity;

SELECT AVG(quantity) AS quantity
FROM order_details
GROUP BY product_id
ORDER BY quantity DESC;

SELECT product_name, quantity
FROM products
JOIN order_details USING(product_id)
WHERE quantity > ALL(
    SELECT AVG(quantity) AS quantity
    FROM order_details
    GROUP BY product_id
)
ORDER BY quantity;