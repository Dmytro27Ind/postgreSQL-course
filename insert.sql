-- Active: 1660002122643@@127.0.0.1@5432@dev
INSERT INTO author
VALUES (10, 'Joh Silver', 4.5);

SELECT * FROM author;

INSERT INTO author (author_id, full_name)
VALUES (11, 'Bob Gray');

INSERT INTO author (author_id, full_name)
VALUES  (12, 'Name 1'),
        (13, 'Name 2'),
        (14, 'Name 3');


--* Вставка выборки с одной таблицы в новую таблицу (тут же создается).
--* Если таблицп уже существует будет ошибка
SELECT *
INTO best_authors
FROM author
WHERE rating >= 4.5;

--* при условии что таблица best_authors существует. Ошибки не будет в отличие от прошлого
INSERT INTO best_authors
SELECT *
FROM author
WHERE rating < 4.5;

SELECT * FROM best_authors;