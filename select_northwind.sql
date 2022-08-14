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