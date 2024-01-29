-- 04_MYSQL_INDEX_FOREIGN_HAVING_JOIN_SUBQUERY_FUNCODING[TEST].pdf
#중급 sql

DROP DATABASE IF EXISTS sqlDB;
CREATE DATABASE sqlDB;

USE sqlDB;
DROP TABLE IF EXISTS userTbl;
CREATE TABLE userTbl (
    userID CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) UNIQUE NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3),
    mobile2 CHAR(8),
    height SMALLINT,
    mDate  DATE,
    UNIQUE INDEX idx_userTbl_name (name),
    INDEX idx_userTbl_addr (addr)
);

DROP TABLE IF EXISTS buyTbl;
CREATE TABLE buyTbl (
    num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userID CHAR(8) NOT NULL,
    prodName CHAR(4),
    groupName CHAR(4),
    price  INT NOT NULL,
    amount  SMALLINT NOT NULL,
    FOREIGN KEY (userID) REFERENCES userTbl(userID)
);
INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8');
INSERT INTO buyTbl (userID, prodName, groupName, price, amount) VALUES('LSG', '운동화', '의류', 30, 2);


