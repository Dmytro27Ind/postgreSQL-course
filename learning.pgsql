--* Создание и удаление базы данных
CREATE DATABASE dev;
-- DROP DATABASE dev;
-- DROP DATABASE dev WITH (FORCE);

--* Создание и удаление таблиц в базе данных
DROP TABLE IF EXISTS EMP;
CREATE TABLE EMP(
    emp_id      INTEGER,
    emp_name    varchar(50),
    emp_address  TEXT
);
-- DROP TABLE EMP;

--* Добавление данных в таблицу
INSERT INTO EMP(emp_id, emp_name, emp_address)
VALUES (1, 'Dima', 'Jedlikova 5');

INSERT INTO EMP(emp_id, emp_name, emp_address)
VALUES  (2, 'Artem', 'Jedlikova 13'),
        (3, 'Sasha', 'Jedlikova 7');

--* Выборка всех данных из таблицы
SELECT * FROM EMP;


--* Один ко многим
--* У одного издательства может быть несколько изданных книг
DROP TABLE IF EXISTS publisher;
DROP TABLE IF EXISTS book;

CREATE TABLE publisher(
    publisher_id    integer         PRIMARY KEY,
    org_name        varchar(128)    NOT NULL,
    address         text            NOT NULL
);

CREATE TABLE book(
    book_id         integer         PRIMARY KEY,
    title           text            NOT NULL,
    isbn            varchar(32)     NOT NULL,
    fk_publisher_id integer         REFERENCES publisher(publisher_id) NOT NULL  --* А можно как в базе данных northwind
                                                        --* сначала создать все таблицы, а только потом прописывать
                                                        --* REFERENCES и PRIMARY KEY через ALTER TABLE database_name ADD CONSTRAINT...
);

INSERT INTO book
VALUES  (1, 'The Diary of a Young Girl', '012457329404', 1),
        (2, 'Pride and Prejudice', '97346092345', 1),
        (3, 'To Kill a Mockingbird', '012498710445', 2),
        (4, 'The Book of Gutsy Women', '190947356022', 2),
        (5, 'War and Peace', '1973094767234', 2);

INSERT INTO publisher
VALUES  (1, 'Everyman''s Libary', 'NY'),
        (2, 'Oxford University Press', 'NY'),
        (3, 'Grand Central Publishing', 'Washington'),
        (4, 'Simon & Schuster', 'Chicago');

SELECT * FROM book;
SELECT * FROM publisher;

--* Если после создания таблицы её нужно изменить
-- ALTER TABLE book
--     ADD COLUMN fk_publisher_id integer;
-- ALERT TABLE book
--     ADD CONSTRAINT fk_book_publisher
--     FOREIGN KEY(fk_publisher_id)
--     REFERENCES publisher(publisher_id)


--* Один к одному
--* Например у человека может быть олин паспорт
--* Чтобы поддержать связь 1 к 1 можно добавить UNIQUE чтобы гарантировать отсутствие дубликатов
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS passport;

CREATE TABLE person(
    person_id   int         PRIMARY KEY,
    first_name  varchar(30) NOT NULL,
    last_name   varchar(30) NOT NULL
);

CREATE TABLE passport(
    passport_id         int PRIMARY KEY,                        --* primary key
    serial_number       int NOT NULL,
    fk_passport_person  int REFERENCES person(person_id) UNIQUE --* foreign key
);
ALTER TABLE passport
ADD COLUMN registration text NOT NULL

INSERT INTO person
VALUES  (1, 'John', 'Snow'),
        (2, 'Ned', 'Stark'),
        (3, 'Rob', 'Baratheon');

INSERT INTO passport
VALUES  (1, 123456, 1, 'Winterfell'),
        (2, 789012, 2, 'Winterfell'),
        (3, 345678, 3, 'King''s Landing');

--* будет ошибка потому что fk_passport_person -> UNIQUE
-- INSERT INTO passport
-- VALUES  (4, 901234, 1, 'King''s Landing');


--* Многие ко многим
--* Эта связь делается с помощью дополнительной таблицы
--* В этой таблице используется составной ключ (composite key)
DROP TABLE IF EXISTS doc_author;
DROP TABLE IF EXISTS doc;
DROP TABLE IF EXISTS author;

CREATE TABLE doc(
    doc_id      int     PRIMARY KEY,
    title       text    NOT NULL,
    isbn        text    NOT NULL
);

CREATE TABLE author(
    author_id   int     PRIMARY KEY,
    full_name   text    NOT NULL,
    rating      real
);

CREATE TABLE doc_author(
    doc_id      int REFERENCES doc(doc_id),
    author_id   int REFERENCES author(author_id),

    CONSTRAINT doc_author_pkey PRIMARY KEY (doc_id, author_id)     --* composite key
);

INSERT INTO doc
VALUES  (1, 'Book for Dummies', '123456'),
        (2, 'Book for Smart Guys', '7890123'),
        (3, 'Book for Happy People', '4567890'),
        (4, 'Book for Unhappy People', '1234567');

INSERT INTO author
VALUES  (1, 'Bob', 4.5),
        (2, 'Alice', 4.0),
        (3, 'John', 4.7);

INSERT INTO doc_author
VALUES
(1, 1),
(2, 1),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(4, 3);