CREATE DATABASE star_practice;
SHOW databases;
DROP database IF EXISTS dave;

USE star_practice;
CREATE TABLE subway (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    
    
)






















create database dave;
use dave;

create database customer_db;

DROP TABLE customer;
C


create table customer(
no INT UNSIGNED NOT NULL AUTO_INCREMENT,
name CHAR(20) NOT NULL,
age TINYINT,
phone VARCHAR(20),
email VARCHAR(30) NOT NULL,
address VARCHAR(50),
PRIMARY KEY(no)
);

DROP TABLE IF EXISTS customer;

ALTER TABLE customer;


CREATE TABLE mytable (
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
name VARCHAR (50) NOT NULL,
modelnumber VARCHAR(15) NOT NULL,
series VARCHAR(30) NOT NULL,
PRIMARY KEY(id));

SHOW TABLES;

ALTER TABLE mytable MODIFY COLUMN name VARCHAR(20) NOT NULL;
ALTER TABLE mytable CHANGE COLUMN modelnumber model_num VARCHAR(10) NOT NULL;

DESC mytable;


-- 연습문제1-- 
ALTER TABLE mytable
MODIFY COLUMN name VARCHAR(20) NOT NULL;
ALTER TABLE mytable
CHANGE COLUMN modelnumber model_num VARCHAR(10) NOT NULL;
ALTER TABLE mytable
CHANGE COLUMN series model_type VARCHAR(10) NOT NULL;
CREATE TABLE mytable (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    model_num VARCHAR(10) NOT NULL,
    model_type VARCHAR(10) NOT NULL,
    PRIMARY KEY(id)
);



ALTER TABLE mytable MODIFY COLUMN model_type VARCHAR(20) NOT NULL;
ALTER TABLE mytable DROP COLUMN series;
ALTER TABLE mytable CHANGE COLUMN id model_type VARCHAR(20);
ALTER TABLE mytable CHANGE COLUMN model_num model_num VARCHAR(20);


INSERT INTO mytable (name, model_num, model_type) VALUES("i7", "i7-14700K", "Raptor Lake");
INSERT INTO mytable (name, model_num, model_type) VALUES("i5", "i5-14600K", "Raptor Lake");
INSERT INTO mytable (name, model_num, model_type) 
VALUES("i3", "i3-14100", "Raptor Lake");
INSERT INTO mytable (name, model_num, model_type) 
VALUES("i7", "i7-14700", "Raptor Lake");
INSERT INTO mytable (name, model_num, model_type) 
VALUES("i5", "i5-12400", "Raptor Lake");


SELECT * FROM mytable;

SELECT * FROM mytable WHERE model_num LIKE '13400%';
SELECT * FROM mytable WHERE name LIKE '%i7%';
SELECT * FROM mytable WHERE model_type LIKE '%Raptor Lake%';

UPDATE mytable SET name = 'i8' WHERE name = 'i7';
DELETE FROM mytable WHERE name = 'i5';


