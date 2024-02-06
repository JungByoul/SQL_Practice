
-- 연습문제37 (실전)
-- 2006-02-14 날짜를 기준으로 최근 30일 동안 영화를 대여하지 않은 고객을 찾으세요.



SELECT DISTINCT R.customer_id
FROM rental R
	JOIN customer C ON R.customer_id=R.customer_id
WHERE rental_date < '2006-01-14';

-- 정답
SELECT C.customer_id, C.first_name, C.last_name
FROM customer C
LEFT JOIN rental R ON R.customer_id = C.customer_id AND
	TIMESTAMPDIFF(DAY, R.rental_date, '2006-02-14') <= 30
WHERE R.rental_id IS NULL;


-- 연습문제38 (실전)
-- 가장 최근에 영화를 반납한 상위 10명의 고객 이름과 그들이 대여한 영화의 이름,
-- 그리고 대여 기간을 출력해 주세요. 고객 이름은 customer_name, 영화 이름은
-- movie_title, 대여 기간은 rental_duration으로 출력해주세요.

SELECT 
	CONCAT(C.first_name, C.last_name) customer_name,
    F.title movie_title,
    TIMESTAMPDIFF(hour, rental_date, return_date) rental_duration
FROM rental R 
	JOIN customer C ON R.customer_id = C.customer_id
	JOIN inventory I ON I.inventory_id = R.inventory_id
    JOIN film F ON I.film_id = F.film_id
ORDER BY return_date DESC
LIMIT 10;
    
-- 정답
SELECT
	CONCAT(C.first_name, ', ', C.last_name) customer_name,
    F.title movie_title,
    TIMESTAMPDIFF(DAY, R.rental_date, R.return_date) rental_duration
FROM rental R
JOIN customer C ON C.customer_id = R.customer_id
JOIN inventory I ON I.inventory_id = R.inventory_id
JOIN film F ON F.film_id = I.inventory_id
ORDER BY R.return_date DESC
LIMIT 10;


-- 연습문제39 (실전)
-- 각 직원의 매출을 찾고, 각 직원의 매출이 회사 전체 매출 중
-- 어느 정도 비율을 차지하는지 찾으세요. 결과는 직원 ID, 직원
-- 이름, 각 직원의 매출, 회사 전체 매출에 대한 비율(%)로 보여
-- 주세요.

SELECT
	S.staff_id,
    S.first_name, S.last_name,
    SUM(P.amount),
    (SUM(P.amount) / (SELECT SUM(amount) FROM payment)) * 100 AS revenue_rate
FROM payment P
JOIN staff S ON S.staff_id = P.staff_id
GROUP BY S.staff_id;


-- 각 고객에 대해 자신이 대여한 평균 영화 길
-- '이('length ')보다 긴 영화들의 제목
-- (title')을 찾아주세요. - 상관서브쿼리 활용

SELECT C.first_name, C.last_name, F.title
FROM customer C
JOIN rental R ON C.customer_id = R.customer_id
JOIN inventory I ON I.inventory_id = R.inventory_id
JOIN film F ON F.film_id = I.film_id
WHERE F.length > (
	SELECT AVG(FIL.length)
    FROM film FIL 
    JOIN inventory INV ON FIL.film_id = INV.film_id
    JOIN rental REN ON INV.inventory_id = REN.inventory_id
    WHERE REN.customer_id = C.customer_id
);

-- 연습문제36 (실전)
-- 각 고객이 어떤 영화 카테고리를 가장 자주 대여하는지 알고
-- 싶습니다.
--  각 고객별로 가장 많이 대여한 영화 카테고리와 해
-- 당 카테고리에서의 총 대여 횟수, 그리고 해당 고객 이름을 조
-- 회하는 SQL 쿼리를 작성해주세요. 자주 대여하는 카테고리
-- 에 동률이 있을 경우 모두 보여주세요.

SELECT Ca.name
FROM category Ca JOIN film_category Fc ON CA.category_id = Fc.category_id
	JOIN film F ON Fc.film_id = F.film_id
    JOIN inventory I ON F.film_id = I.film_id
    JOIN rental R ON I.inventory_id = R.inventory_id
    JOIN customer C ON R.customer_id = C.customer_id
GROUP BY C.customer_id;

-- 정답
SELECT
	CU.first_name, CU.last_name,
    CA.name, COUNT(*) rental_count
FROM customer CU
JOIN rental R ON R.customer_id = CU.customer_id
JOIN inventory I ON I.inventory_id = R.inventory_id
JOIN film_category FC ON FC.film_id = I.film_id
JOIN category CA ON CA.category_id = FC.category_id
GROUP BY CU.customer_id, CA.name
HAVING rental_count = (
	SELECT COUNT(*)
    FROM rental R2
    JOIN inventory I2 ON I2.inventory_id = R2.inventory_id
    JOIN film_category FC2 ON FC2.film_id = I2.film_id
    WHERE R2.customer_id = CU.customer_id
    GROUP BY FC2.category_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);





