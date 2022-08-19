-- Active: 1660002122643@@127.0.0.1@5432@dev
CREATE SEQUENCE seq1;

SELECT nextval('seq1');
SELECT currval('seq1');
SELECT lastval();                       --* last value of any sequence in session

SELECT setval('seq1', 16, true);        --* now set value (with true)
SELECT currval('seq1');
SELECT nextval('seq1');

SELECT setval('seq1', 16, false);       --* in next time set value (with false)
SELECT currval('seq1');
SELECT nextval('seq1');


CREATE SEQUENCE IF NOT EXISTS seq2 INCREMENT 16;
SELECT nextval('seq2');


CREATE SEQUENCE IF NOT EXISTS seq3
INCREMENT 16
MINVALUE 0
MAXVALUE 128
START WITH 0;

SELECT nextval('seq3');


--* rename squence
ALTER SEQUENCE seq3 RENAME TO seq4;
ALTER SEQUENCE seq4 RESTART with 16;            --* reset sequence

SELECT nextval('seq4');

DROP SEQUENCE seq4;


--* -----------------------------------------------------------
--* SEQUENCEs and TABLE
--* -----------------------------------------------------------

DROP TABLE IF EXISTS book;

CREATE TABLE public.book
(
    book_id int NOT NULL,
    title text NOT NULL,
    isbn varchar(32) NOT NULL,
    publisher_id int NOT NULL,

	CONSTRAINT PK_book_book_id PRIMARY KEY(book_id)
);

SELECT * FROM book;

CREATE SEQUENCE IF NOT EXISTS book_book_id_seq
START WITH 1 OWNED BY book.book_id;

--* doesn't work
-- INSERT INTO book (title, isbn, publisher_id)
-- VALUES ('title', 'isbn', 1);

--* we need to set default
ALTER TABLE book
ALTER COLUMN book_id SET DEFAULT nextval('book_book_id_seq');

-- *now should work
INSERT INTO book (title, isbn, publisher_id)
VALUES ('title', 'isbn', 1);

--* -----------------------------------------------------------


DROP TABLE IF EXISTS book;

CREATE TABLE public.book
(
    --* ЗАПРЕЩАЕМ пользователю вставлять данные в эту колонку вручную, чтобы не рассинхронизировать последовательность.
    --* с обычным SERIAL мы все ещё можем вручную вставить ID тем самым сбив счетчик
    book_id int GENERATED ALWAYS AS IDENTITY NOT NULL,
    title text NOT NULL,
    isbn varchar(32) NOT NULL,
    publisher_id int NOT NULL,

	CONSTRAINT PK_book_book_id PRIMARY KEY(book_id)
);

--* ошибка так как пытаемся вручную вставить значение в столбей
-- INSERT INTO book
-- VALUES ('4', 'title', 'isbn', 1);

DROP TABLE IF EXISTS book;

CREATE TABLE public.book
(
    --* ЗАПРЕЩАЕМ пользователю вставлять данные в эту колонку вручную
    --* + добавляем параметры самого инкремента
    book_id int GENERATED ALWAYS AS IDENTITY (START WITH 10 INCREMENT BY 2) NOT NULL,
    title text NOT NULL,
    isbn varchar(32) NOT NULL,
    publisher_id int NOT NULL,

	CONSTRAINT PK_book_book_id PRIMARY KEY(book_id)
);

INSERT INTO book (title, isbn, publisher_id)
VALUES ('title', 'isbn', 1);

SELECT * FROM book;