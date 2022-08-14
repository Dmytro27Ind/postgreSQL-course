-- Active: 1660408859573@@127.0.0.1@5432@northwind

SELECT *
FROM products;

SELECT product_name
FROM products;

SELECT product_id, product_name, unit_price
FROM products;

--* использование арифметических операций (*)
SELECT product_id, product_name, unit_price * units_in_stock AS amount_price
FROM products;

--* использование арифметических операций (-)
--* В данном случае узнаем сколько дней была доставка заказа
SELECT order_id, shipped_date - order_date
FROM orders;

SELECT *
FROM employees;

SELECT country
FROM employees;

--* Вывод только уникальных значений стран
SELECT DISTINCT country
FROM employees;

--* Вывод только уникальных значений городов
SELECT DISTINCT city
FROM employees;

SELECT DISTINCT city
FROM customers;

SELECT city, country
FROM employees;

--* Вывод только уникальных комбинаций значений городов и стран
SELECT DISTINCT city, country
FROM employees;

SELECT *
FROM orders;

--* функция COUNT() возвращает количество записей. В данном случае количество всех записей в таблице
SELECT COUNT(*)
FROM orders;

--* функция COUNT() возвращает количество записей. В данном случае количество всех записей с атрибутом страна
--* в данном случае это тоже самое что и COUNT(*), так как у каждой записи есть страна
SELECT COUNT(country)
FROM employees;

--* функция COUNT() возвращает количество записей. В данном случае количество уникальных стран
SELECT COUNT(DISTINCT country)
FROM employees;

--* -------------------------------------------------------------------------------------
--* "Использования фильтра WHERE condition"
--* -------------------------------------------------------------------------------------

SELECT company_name, contact_name, phone, country
FROM customers
WHERE country = 'USA';

SELECT *
FROM products
WHERE unit_price > 20;

SELECT COUNT (*)
FROM products
WHERE unit_price > 20;

SELECT *
FROM products
WHERE discontinued = 1;

SELECT *
FROM customers
WHERE city != 'Berlin';         --*     "!=" тоже самое что и "<>"

SELECT *
FROM orders
WHERE order_date > '1998-03-01';         --* work with date

--* -------- END -------- "Использования фильтра WHERE condition" -----------------------



--* -------------------------------------------------------------------------------------
--* "Использования AND и OR"
--* -------------------------------------------------------------------------------------

SELECT *
FROM products
WHERE unit_price > 25 AND units_in_stock > 40;

SELECT *
FROM customers
WHERE city = 'Berlin' OR city = 'London' OR city = 'San Francisco';

SELECT *
FROM orders
WHERE shipped_date > '1998-04-30' AND (freight < 75 OR freight > 150);

--* ------------- END -------------- "Использования AND и OR" ---------------------------


--* -------------------------------------------------------------------------------------
--* "Использования BETWEEN"
--* -------------------------------------------------------------------------------------

SELECT COUNT(*)
FROM orders
WHERE freight BETWEEN 20 AND 40;            --* тоже самое что и    freight >= 20 AND freight <= 40

SELECT *
FROM orders
WHERE order_date BETWEEN '1998-03-30' AND '1998-04-03';

--* ------------- END -------------- "Использования BETWEEN" ---------------------------


--* -------------------------------------------------------------------------------------
--* "Использования IN и NOT"
--* -------------------------------------------------------------------------------------

SELECT *
FROM customers
WHERE country IN ('Mexico', 'Germany', 'USA', 'Canada');        --* country = 'Mexico' OR country = 'Germany'
                                                                --* OR country = 'USA' OR country = 'Canada'

SELECT *
FROM products
WHERE category_id IN (1, 3, 5, 7);

SELECT *
FROM customers
WHERE country NOT IN ('Mexico', 'Germany', 'USA', 'Canada');        --* country != 'Mexico' AND country != 'Germany'
                                                                    --* AND country != 'USA' AND country != 'Canada'

--* ------------- END -------------- "Использования IN и NOT" ---------------------------


--* -------------------------------------------------------------------------------------
--* "Использования ORDER BY, ASC, DESC"
--* -------------------------------------------------------------------------------------

SELECT DISTINCT country
FROM customers
ORDER BY country;

SELECT DISTINCT country
FROM customers
ORDER BY country ASC;       --* ASC - по возрастанию (тоже что и прошлый запрос)

SELECT DISTINCT country
FROM customers
ORDER BY country DESC;       --* DESC - по убыванию

SELECT DISTINCT country, city
FROM customers
ORDER BY country DESC, city DESC;

SELECT DISTINCT country, city
FROM customers
ORDER BY country DESC, city ASC;

--* ------------- END -------------- "Использования ORDER BY" ---------------------------


--* -------------------------------------------------------------------------------------
--* "Использования MIN, MAX, AVG, SUM"
--* -------------------------------------------------------------------------------------

SELECT ship_city, order_date
FROM orders
WHERE ship_city = 'London'
ORDER BY order_date;

SELECT MIN(order_date)
FROM orders
WHERE ship_city = 'London';

SELECT MAX(order_date)
FROM orders
WHERE ship_city = 'London';

SELECT AVG(unit_price)
FROM products
WHERE discontinued != 1;

SELECT SUM(units_in_stock)
FROM products
WHERE discontinued != 1;

--* ----------- END ------------ "Использования MIN, MAX, AVG, SUM" ---------------------


--* -------------------------------------------------------------------------------------
--* "Использования LIKE     (Pattern Matching)"
--* % - placeholder
--* -------------------------------------------------------------------------------------

SELECT last_name, first_name
FROM employees
WHERE first_name LIKE '%n';

SELECT last_name, first_name
FROM employees
WHERE last_name LIKE 'B%';

SELECT last_name, first_name
FROM employees
WHERE last_name LIKE 'Buch%';

SELECT last_name, first_name
FROM employees
WHERE last_name LIKE '_uch%';

--* -------- END --------- "Использования LIKE     (Pattern Matching)" ------------------


--* -------------------------------------------------------------------------------------
--* "Использования LIMIT"
--* -------------------------------------------------------------------------------------

SELECT product_name, unit_price
FROM products
LIMIT 10;

SELECT product_name, unit_price
FROM products
WHERE discontinued != 1
ORDER BY unit_price DESC
LIMIT 10;

--* --------------- END ----------------- "Использования LIMIT" -------------------------


--* -------------------------------------------------------------------------------------
--* "Использования NULL, IS NULL, IS NOT NULL"
--* -------------------------------------------------------------------------------------

SELECT ship_city, ship_region, ship_country
FROM orders
WHERE ship_region IS NULL;

SELECT ship_city, ship_region, ship_country
FROM orders
WHERE ship_region IS NOT NULL;

--* -------- END ---------- "Использования NULL, IS NULL, IS NOT NULL" ------------------


--* -------------------------------------------------------------------------------------
--* "Использования GROUP BY"
--* -------------------------------------------------------------------------------------

SELECT *
FROM orders
WHERE freight > 50;

SELECT ship_country
FROM orders
WHERE freight > 50;

SELECT COUNT(*)
FROM orders
WHERE freight > 50;


--* ERROR without GROUP BY
-- SELECT ship_country, COUNT(*)
-- FROM orders
-- WHERE freight > 50;

SELECT ship_country, COUNT(*)
FROM orders
WHERE freight > 50
GROUP BY ship_country
ORDER BY COUNT(*) DESC;

SELECT ship_country, COUNT(*) AS amount, COUNT(DISTINCT ship_city)
FROM orders
WHERE freight > 50
GROUP BY ship_country
ORDER BY amount ASC;

SELECT ship_country, ship_city
FROM orders
WHERE ship_country = 'Italy' AND freight > 50;

SELECT category_id, SUM(units_in_stock)
FROM products
GROUP BY category_id
ORDER BY SUM(units_in_stock) DESC
LIMIT 5;

--* -------------- END ---------------- "Использования GROUP BY" ------------------------