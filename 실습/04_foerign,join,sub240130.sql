-- 04_MYSQL_INDEX_FOREIGN_HAVING_JOIN_SUBQUERY_FUNCODING[TEST].pdf
#중급 sql
#24.01.30.화

#2. GROUP BY와 HAVING절
SELECT provider FROM items
GROUP BY provider HAVING COUNT(*) >= 100;

-- HAVING 절은 집계함수를 가지고 조건비교를 할 때 사용한다.
SELECT provider, COUNT(*)
FROM items
WHERE provider !=' 스마일배송'
GROUP BY provider
HAVING COUNT(*) > 100
ORDER BY COUNT(*) DESC;

#3. join
#일반인과 분석가를 나누는 기준. 매우 중요

#inner join은 두 테이블의 공통된 컬럼에서 동일한 값들만 합치는 것임
SELECT * FROM ranking INNER JOIN ranking ON ranking.iterm_code = item.item_code --  on 옆에가 조인 조건
WHERE ranking.main_category = 'ALL';

SELECT * FROM ranking a
JOIN items b ON b.itemcode = a.itemcode
WHERE a.category;

-- 연습문제. 전체 베스트상품(ALL 메인 카테고리)에서 판매자별 베스트상품 갯수 출력해보기
SELECT * FROM ranking;

#모르겠다!
SELECT COUNT(*)
FROM ranking;
-- INNER JOIN ranking ON;
SELECT provider, COUNT(*) FROM items
JOIN ranking ON items.item_code = ranking.item_code
WHERE main_category = 'ALL'
GROUP BY provider;


-- 연습문제
-- 메인 카테고리가 패션의류인 서브 카테고리 포함, 
-- 패션의류 전체 베스트상품에서 판매자별 베스트 상품 갯수가 5이상인 
-- 판매자와 베스트상품 갯수 출력해보기

#내 답안
SELECT i.provider, COUNT(*)
FROM items i INNER JOIN ranking r ON i.num = r.num
GROUP BY i.provider
HAVING COUNT(*) >= 5;

#실제 답
SELECT PROVIDER, COUNT(*) FROM items I
JOIN ranking R ON R.item_code = I.item_code
WHERE main_category = '패션의류'
GROUP BY provider HAVING COUNT(*) >= 5;

-- 연습문제
-- 메인 카테고리가 신발/잡화인 서브 카테고리 포함, 전체 베스트상품에서 판매자별 베스트상품 갯
-- 수가 10이상인 판매자와 베스트상품 갯수를 베스트상품 갯수 순으로 출력해보기
SELECT * FROM ranking LIMIT 10;
SELECT * FROM items LIMIT 10;

-- 내풀이. 풀다가 시간오바
SELECT 
FROM ranking R INNER JOIN items I ON R.item_code = I.item_code
GROUP BY I.provider
HAVING COUNT(*) >= 10
ORDER BY;

-- 정답
SELECT provider, COUNT(*) total FROM items I
JOIN ranking R ON R.item_code = I.item_code
WHERE main_category = '신발/잡화'
GROUP BY provider HAVING total >= 10
ORDER BY total;

-- 연습문제
-- 메인 카테고리가 화장품/헤어인 서브 카테고리 포함, 전체 베스트상품의 평균, 최대, 최소 할인 가격 출력해보기
SELECT AVG(dis_price), MAX(dis_price), MIN(dis_price)
FROM items I
INNER JOIN Ranking R ON I.item_code = R.item_code
WHERE main_category = '화장품/헤어';
-- 제시간 안에 정답 맞음.





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


