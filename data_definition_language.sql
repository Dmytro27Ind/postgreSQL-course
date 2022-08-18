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

