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

#3-1 inner join.
#은 두 테이블의 공통된 컬럼에서 동일한 값들만 합치는 것임
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

#3-2. OUTER JOIN

-- 연습문제: sakila 데이터베이스에서 address 테이블에는 address_id 가 있지만, customer 테이블에는 없는 데이터의 갯수 출력하기
USE sakila;
-- 내 답안
SELECT COUNT(C.address_id IS Null)
FROM address A LEFT OUTER JOIN customer C ON A.address_id = C.address_id;

-- 실제 답안
SELECT COUNT(*)
FROM address A LEFT OUTER JOIN customer C
ON A.address_id = C.address_id
WHERE customer_id IS NULL;


#4.서브쿼리
#조인과 서브쿼리 둘다 두 테이블에서 처리할 일이 있을 때 쓰임
#성능 향상을 위해서도 조인 대신 서브쿼리 쓸 수도 있음
#select from where 모두에서 쓰일 수 있음

USE bestproducts;

-- 연습문제
-- 메인 카테고리별로 할인 가격이 10만원 이상인 상품이 몇개 있는지를 출력해보기 (JOIN 활용 SQL 과 서브쿼리 활용 SQL 모두 작성해보기)

#join 활용 버전
SELECT main_category, COUNT(*)
FROM items I
INNER JOIN ranking R ON I.item_code=R.item_code
WHERE dis_price >= 100000
GROUP BY main_category;

#서브쿼리 활용 버전
SELECT main_category, COUNT(*)
FROM ranking
WHERE item_code IN (SELECT item_code FROM items WHERE dis_price >= 100000)
#이부분이 중요. 아이템 코드로 연결해주는 것임. 이 아이템 코드를 쓰는게 아니더라도ㅇㅇ
GROUP BY main_category;


-- 연습문제
-- 'items' 테이블에서 'dis_price'가 200000 이상인 아이템들 중,
--  각 'sub_category'별 아이템 수 출력해보기 (JOIN 활용 SQL 과 서브쿼리 활용 SQL 모두 작성해보기)

#join 활용 버전
SELECT sub_category, COUNT(*)
FROM items I INNER JOIN ranking R ON I.item_code = R.item_code
WHERE dis_price >= 200000
GROUP BY sub_category;
#서브쿼리 활용 버전
SELECT sub_category, COUNT(*)
FROM ranking
WHERE item_code IN (SELECT item_code FROM items WHERE dis_price >= 200000)
GROUP BY sub_category;

-- 아래 첫번째 문제 풀기전에 짚어야할 문법사항.
-- :group by를 두개 쓸 수 있다!

#파이널 연습문제
-- 연습문제
-- 메인 카테고리, 서브 카테고리에 대해, 평균할인가격과 평균할인율을 출력해보기
SELECT 
	main_category, sub_category,
    AVG(I.dis_price), AVG(I.discount_percent)
FROM ranking R INNER JOIN items I ON R.item_code = I.item_code
GROUP BY main_category, sub_category;
-- 'INNER' 생략 가능

--  연습문제
-- 판매자별, 베스트상품 갯수, 평균할인가격, 평균할인율을, 베스트상품 갯수가 높은 순으로 출력해보기
SELECT provider, COUNT(*) cnt, AVG(dis_price) price, AVG(discount_percent) perc
FROM items
GROUP BY provider
ORDER BY cnt desc;

-- 정답
SELECT 
	provider, COUNT(*) product_count,
	AVG(dis_price), AVG(discount_percent) 
FROM items I
JOIN ranking R ON R.item_code = I.item_code
GROUP BY provider
ORDER BY product_count DESC;

-- 연습문제
-- 각 메인 카테고리별로(서브카테고리포함) 베스트 상품 갯수가 20개 이상인 판매자의 판매자별 평
-- 균할인가격, 평균할인율, 베스트 상품 갯수 출력해보기
SELECT R.main_category, R.sub_category, AVG(I.dis_price), AVG(I.discount_percent), COUNT(*)
FROM ranking R INNER JOIN items I ON I.item_code = R.item_code
WHERE COUNT(*) >= 20
GROUP BY R.main_category, R.sub_category;
-- 에러나서 못풀음

-- 정답: 아아 where가 아니라 having 절을 써야지;;
SELECT
	main_category, provider,
	AVG(dis_price), AVG(discount_percent), COUNT(*)
FROM items I JOIN ranking R ON R.item_code = I.item_code
GROUP BY main_category, provider
HAVING COUNT(*) >= 20;

-- 연습문제
-- 'items' 테이블에서 'dis_price'가 50000 이상인 상품들 중, 각 'main_category'별 평균
-- 'dis_price'와 'discount_percent' 출력해보기
SELECT 
	main_category,
	AVG(dis_price), AVG(discount_percent)
FROM items I
	JOIN ranking R ON I.item_code = R.item_code
WHERE dis_price >= 50000
GROUP BY main_category;
#진짜 오래걸림..; 아직 HAVING이랑 WHERE 헷갈리는듯


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


