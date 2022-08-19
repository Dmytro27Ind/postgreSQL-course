-- Active: 1660002122643@@127.0.0.1@5432@dev
CREATE TABLE student
(
    student_id  SERIAL,
    first_name  VARCHAR,
    last_name   VARCHAR,
    birthday    DATE,
    phone       VARCHAR
);

CREATE TABLE cathedra           --* create table
(
    cathedra_id     SERIAL,
    cathedra_name   VARCHAR,
    dean            VARCHAR
);

ALTER TABLE student
ADD COLUMN middle_name VARCHAR;

ALTER TABLE student
ADD COLUMN rating FLOAT;

ALTER TABLE student
ADD COLUMN enrolled DATE;       --* add column

ALTER TABLE student
DROP COLUMN middle_name;        --* drop column

ALTER TABLE cathedra
RENAME TO chair;                --* rename table

ALTER TABLE chair
RENAME cathedra_id TO chair_id;

ALTER TABLE chair
RENAME cathedra_name TO chair_name;     --* rename column

ALTER TABLE student
ALTER COLUMN first_name SET DATA TYPE VARCHAR(64);      --* change the data type of COLUMN
ALTER TABLE student
ALTER COLUMN last_name SET DATA TYPE VARCHAR(64);
ALTER TABLE student
ALTER COLUMN phone SET DATA TYPE VARCHAR(30);


CREATE TABLE faculty
(
    faculty_id SERIAL,              --* auto inckrement ID
    faculty_name VARCHAR
);

INSERT INTO faculty(faculty_name)           --* insert data in table
VALUES
('faculty 1'),
('faculty 2'),
('faculty 3');

SELECT * FROM faculty;

TRUNCATE TABLE faculty;                         --* restart only table
TRUNCATE TABLE faculty RESTART IDENTITY;        --* restart table and restart identity (auto inckrement like SERIAL)

DROP TABLE faculty;             --* delete table (drop table)

DROP TABLE chair;
CREATE TABLE chair
(
    chair_id    SERIAL  PRIMARY KEY,
    chair_name  VARCHAR,
    dean        VARCHAR
);

INSERT INTO chair
VALUES (1, 'name', 'dean');

SELECT * FROM chair;

-- INSERT INTO chair
-- VALUES (NULL, 'name2', 'dean2');        --* null value in PRIMARY KEY

INSERT INTO chair
VALUES (2, 'name2', 'dean2');


DROP TABLE chair;
CREATE TABLE chair
(
    chair_id    SERIAL  UNIQUE NOT NULL,        --* like PRIMARY KEY, but primary key only to one column for table
    chair_name  VARCHAR,
    dean        VARCHAR
);

SELECT constraint_name                          --* SELECT CONSTRAINT name of column
FROM information_schema.key_column_usage
WHERE table_name = 'chair'
    AND table_schema = 'public'
    AND column_name = 'chair_id';


DROP TABLE chair;
CREATE TABLE chair
(
    chair_id    SERIAL,
    chair_name  VARCHAR,
    dean        VARCHAR,

    CONSTRAINT pk_chair_chair_id PRIMARY KEY(chair_id)          --* add CONSTRAINT
);

ALTER TABLE chair
DROP CONSTRAINT pk_chair_chair_id;          --* drop CONSTRAINT

ALTER TABLE chair
ADD PRIMARY KEY(chair_id);                  --* add PRIMARY KEY

SELECT constraint_name                          --* SELECT CONSTRAINT name of column
FROM information_schema.key_column_usage
WHERE table_name = 'chair'
    AND table_schema = 'public'
    AND column_name = 'chair_id';



DROP TABLE publisher;
DROP TABLE book;
CREATE TABLE publisher
(
    publisher_id int,
    publisher_name VARCHAR(128) NOT NULL,
    address TEXT,

    CONSTRAINT PK_publisher_publisher_id PRIMARY KEY(publisher_id)
);

CREATE TABLE book
(
    book_id int,
    title text NOT NULL,
    isbn VARCHAR(32) NOT NULL,
    publisher_id int,

    CONSTRAINT PK_book_book_id PRIMARY KEY(book_id)
);

ALTER TABLE book        --* add constraint
ADD CONSTRAINT FK_books_publisher FOREIGN KEY(publisher_id) REFERENCES publisher(publisher_id);

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


--* add column with constraint (CHECK)
ALTER TABLE book
ADD COLUMN price DECIMAL CONSTRAINT CHK_book_price CHECK (price >= 0);

INSERT INTO book
VALUES  (6, 'The Diary 6', '012666629404', 1, 10);

SELECT * FROM book;


--* add CHECK and DEFAULT value for COLUMN
CREATE TABLE customer
(
    customer_id SERIAL,
    full_name TEXT,
    status CHAR DEFAULT 'r',

    CONSTRAINT PK_customer_customer_id PRIMARY KEY(customer_id),
    CONSTRAINT CHK_customer_status CHECK (status = 'r' OR status = 'p')
);

INSERT INTO customer (full_name)
VALUES
('name5');

INSERT INTO customer (full_name, status)
VALUES
('name3', 'p');

SELECT * FROM customer;

ALTER TABLE customer
ALTER COLUMN status DROP DEFAULT;

ALTER TABLE customer
ALTER COLUMN status SET DEFAULT 'r';



--* ---------------------------------------------------------------------
--* Использования UPDATE
--* ---------------------------------------------------------------------

SELECT * FROM author;

UPDATE author
SET full_name = 'Elias', rating = 5
WHERE author_id = 1;

--* --------- END ---------- "Использования UPDATE"----------------------


--* ---------------------------------------------------------------------
--* Использования DELETE, TRUNCATE
--* ---------------------------------------------------------------------

DROP TABLE doc_author;
SELECT * FROM author;

DELETE FROM author
WHERE author_id = 2;

DELETE FROM author;     --* delete ALL

TRUNCATE TABLE author;      --* delete ALL (without log)

--* --------- END ---------- "Использования DELETE, TRUNCATE"----------------------


--* ---------------------------------------------------------------------
--* Использования RETURNING (dont work in VS code plugin. Use pgAdmin !!!)
--* ---------------------------------------------------------------------

DROP TABLE book;

CREATE TABLE book
(
	book_id serial,
	title text NOT NULL,
	isbn varchar(32) NOT NULL,
	publisher_id int NOT NULL,

	CONSTRAINT PK_book_book_id PRIMARY KEY(book_id)
);

INSERT INTO book(title, isbn, publisher_id)
VALUES ('title', 'isbn', 3)
RETURNING *;

UPDATE author
SET full_name = 'Walter', rating = 5
WHERE author_id = 1
RETURNING author_id;

DELETE FROM author
WHERE rating = 5
RETURNING *;

--* --------- END ---------- "Использования RETURNING"----------------------