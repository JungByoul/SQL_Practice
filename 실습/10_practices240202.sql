

-- 연습문제18 (실전)
-- 가장 렌탈비용을 많이 지불한 상위 10명에게 선물을 배송하고자 합니다
-- 가장 렌탈비용을 많이 지불한 상위 10명의 주소(address)와 이메일, 그리고
--  각 고객당 총 지불 비용을 출력해주세요

-- 풀다가 시간오바
-- SELECT C.customer_id, C.address_id, P.amount
-- FROM customer C JOIN payment P ON C.customer_id = P.customer_id
-- WHERE 
-- GROUP BY
-- ORDER BY
-- LIMIT 10

-- 정답
SELECT 
	A.address,
    C.email,
	SUM(P.amount)
FROM payment P
JOIN customer C ON C.customer_id = P.customer_id
JOIN address A ON A.address_id = C.address_id
GROUP BY C.customer_id
ORDER BY SUM(P.amount)
LIMIT 10;


-- 연습문제 19 (실전)
-- actor 테이블의 배우 이름을 first name 과 last name 을 대문자로 Actor
-- Name 항목으로 출력해주세요

SELECT CONCAT(UPPER(first_name), UPPER(last_name)) ActorName
FROM actor;

-- 정답
SELECT
	UPPER(CONCAT(first_name, ', ', last_name)) AS 'Actor Name'
FROM actor;


-- 연습문제 20 (실전)
-- 언어가 영어인 영화 중, 영화 타이틀이 K 와 Q 로 시작하는 영화의 타이틀만
-- 출력해주세요 (서브쿼리를 사용해보세요)

SELECT title 
FROM film
WHERE language_id IN (
	SELECT language_id FROM language WHERE name = 'English'
	) AND
    title like 'K%' OR 
    title like 'Q%';

-- 정답
SELECT title
FROM film
WHERE language_id IN (
	SELECT language_id FROM language
    WHERE name = 'English'
) AND (title LIKE 'K%' OR title LIKE 'Q%');

-- 연습문제 21 (실전)
-- Alone Trip 에 나오는 배우 이름을 모두 출력하세요 (배우 이름은
-- actor_name 항목으로 출력해주세요. 서브쿼리를 사용해보세요)

SELECT CONCAT(first_name, last_name) 'actor_name'
FROM actor A
	JOIN film_actor FA ON A.actor_id = FA.actor_id
	JOIN film F ON FA.film_id = F.film_id
WHERE F.title like 'Alone Trip';


-- 정답
SELECT
	CONCAT(first_name, ', ', last_name) actor_name
FROM actor WHERE actor_id IN (
	SELECT actor_id FROM film_actor
    WHERE film_id IN (
		SELECT film_id FROM film
        WHERE title = 'Alone Trip'
	)
);

-- 연습문제 22(실전)
-- 2005년 8월에 각 스태프 멤버가 올린 매출을 스태프 멤버는 Staff Member
-- 항목으로, 매출은 Total Amount 항목으로 출력해주세요.
select * from payment;

SELECT CONCAT(first_name, last_name) 'Staff Member', SUM(amount) 'Total Amount'
FROM payment P
JOIN staff S ON P.staff_id = S.staff_id
WHERE YEAR(payment_date) = 2005 AND MONTH(payment_date) = 08
GROUP BY P.staff_id;

-- 정답
SELECT
CONCAT (S. first_name, ' ' S.last_name) AS 'Staff Member',
SUM(P.amount) AS 'Total Amount'
FROM payment P
JOIN staff S ON S.staff_id = P.staff_id
WHERE
EXTRACT(YEAR FROM P.payment_date) = 2005 AND
EXTRACT(MONTH FROM P.payment_date) = 8
GROUP BY S.staff_id;


-- 연습문제23 (실전)
-- 각 카테고리의 평균 영화 러닝타임이 
-- 전체 평균 러닝타임보다 큰 카테고리들
-- 의 카테고리명과
--  해당 카테고리의 평균 러닝타임을 출력하세요

-- 풀다 시간 초과
-- SELECT 
-- FROM film F
-- 	JOIN film_category Fc IN F.film_id = Fc.film_id
-- 	JOIN IN category C IN Fc.category_id = C.category_id
-- WHERE > AVG(length)
-- GROUP BY Fc.catogry_id;

-- 정답. 단계를 나눠서 풀고 합쳐보자
SELECT C.name, AVG(F.length)
FROM film F
JOIN film_category FC ON F.film_id = FC.film_id
JOIN category C ON C.category_id = FC.category_id
GROUP BY C.name
HAVING AVG(F.length) > (
	SELECT AVG(length) FROM film
);


-- 연습문제24 (실전)
-- 각 카테고리별 평균 영화 대여 시간 (영화 대여 및 반납 시간의 차이, hour 단
-- 위) 과 해당 카테고리명을 출력하세요
-- 못풀겠음

-- SELECT
-- FROM cateogry -> cateogry_id, name
-- film_category -> category_id, film_id
-- film -> film_id, 
-- rental -> _id, rental_date, return_date
-- WHERE;

select * from film;

-- 정답
-- SELECT 
-- 	C.name,
-- 	AVG(TIMESTAMPDIFF(HOUR, R.rental_date, R.return_date))
-- FROM rental R
-- JOIN inventory I ON I.inventory_id = R.inventory_id
-- JOIN film_category F ON F.film_id = I.film_id
-- JOIN category C ON C.category_id = F.category_id
-- GROUP BY C.name

연습문제25 (실전)
새로운 임원이 부임했습니다. 총 매출액 상위 5개 장르의 매출액을 수시로
확인하고자 합니다.
Total Sales (각 장르별 총 매출액) 과 Genre (각 장르 이름) 으로 해당 데이
터를 수시로 확인할 수 있는 view 를 top5_genres 로 만들고, 현재까지의
상위 5 장르의 매출액을 출력해주세요

-- join부터 개어려운데ㅋㅋ

CREATE VIEW top5_genres AS
SELECT
FROM category C
film_category FC-> category_id, film_id
inventory-> film_id
film F-> film_id, 
rental-> rental_id, 
payment-> amount rental_id
WHERE;

SELECT * FROM top5_genres LIMIT 5;

-- 정답
CREATE OR REPLACE VIEW top5_genres AS
	SELECT
		C.name AS 'Genre',
		SUM(P.amount) AS 'Total Sales'
	FROM payment P
	JOIN rental R ON R.rental_id = P.rental_id
	JOIN inventory I ON I.inventory_id = R.inventory_id
	JOIN film_category F ON F.film_id = I.film_id
	JOIN category C ON C.category_id = F.category_id
	GROUP BY C.name
    ORDER BY SUM(P.amount) DESC
    LIMIT 5;


-- 연습문제27 (실전)
-- 2005년 5월에 가장 많이 대여된 영화 3개를 찾으세요. 영화 제목과 대여 횟
-- 수를 보여주세요.

SELECT title, COUNT(*) cnt
FROM rental R JOIN
	inventory I  ON  R.inventory_id = I.inventory_id
    JOIN film F ON  I.film_id = F.film_id
GROUP BY title
ORDER BY cnt DESC
LIMIT 3;

-- 답안. 연도 조건 충족 못함
SELECT
	F.title,
    COUNT(*) rental_count
FROM film F
JOIN inventory I ON I.film_id = F.film_id
JOIN rental R ON R.inventory_id = I.inventory_id
WHERE 
	YEAR(rental_date) = 2005 AND
    MONTH(rental_date) = 5
GROUP BY F.title
ORDER BY rental_count DESC
LIMIT 3;


-- | 연습문제28 (실전)
-- | 대여된 적이 없는 영화를 찾으세요.

SELECT *
FROM film F INNER
	JOIN inventory I ON F.film_id = I.film_id
UNION
SELECT *
FROM inventory I INNER
    JOIN rental R ON I.inventory_id = R.inventory_id;

-- 정답
SELECT F.title
FROM film F
LEFT JOIN inventory I ON I.film_id = F.film_id 
LEFT JOIN rental R ON R.inventory_id = I.inventory_id
GROUP BY F.title
HAVING COUNT(R.rental_id) = 0;


-- 연습문제29 (실전)
-- 각 고객의 총 지출 금액의 평균 보다
--  총 지출 금액이 더 큰 고객 리스트를 찾으세요.
--  그들의 이름과 그들이 지출한 총 금액을 보여주세요.
-- 각 고객의 총 지출 금액 계산 방법:
-- - 고객 A 5번 렌트, 총 100$
-- - 고객 B 3번 렌트, 총 80$
-- - 고객당 평균 지출: 90$

SELECT C. COUNT(RETNAL_ID)
FROM payment P JOIN customer C
	ON P.customer_id = C.customer_id
GROUP BY P.customer_id
HAVING
;

-- 정답
SELECT 
	C.first_name, C.last_name, SUM(amount)
FROM payment P
JOIN customer C ON C.customer_id = P.customer_id
GROUP BY C.customer_id
HAVING SUM(amount) > (
	SELECT
		AVG(sum_amount)
	FROM (
		SELECT SUM(amount) AS sum_amount
		FROM payment
		GROUP BY customer_id
	) AS amount_per_customer
);


-- 연습문제30 (실전)/. 가장 많은 결제를 처리한 직원이 누구인지 찾으세요.
-- 디버깅 못함;;
SELECT S.staff_id, first_name, last_name, COUNT(*)
FROM staff S JOIN
	payment P ON S.staff_id = P.staff_id
GROUP BY S.staff_id
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT *
FROM staff S JOIN
	payment P ON S.staff_id = P.staff_id;

-- 정답 아 잘 풀었는데, 이전것 ; 표시 안해놔서 계속 에러;;;;
SELECT 
	S.first_name, S.last_name,
	COUNT(*) payment_count
FROM staff S
JOIN payment P ON S.staff_id = P.staff_id
GROUP BY S.staff_id
ORDER BY payment_count DESC
LIMIT 1;


-- 연습문제31 (실전)
-- '액션' 카테고리에서
--  높은 영화 영상 등급을 받은 순으로,
--  상위 5개의 영화를
-- | 보여주세요. (높은 영화 영상 등급 순으로의 정렬은 ORDER BY rating DESC 으로 처리 가능)
#맞춤
SELECT F.title
FROM category C 
	JOIN film_category FC ON C.category_id = FC.category_id
	JOIN film F ON F.film_id = FC.film_id
WHERE C.name ='Action'
ORDER BY rating DESC
LIMIT 5;

-- 연습문제32 (실전)
-- 각 영화 영상등급의 영화별 대여 기간(film.rental_duration)의 평균을 찾
-- 으세요.
#맞춤
SELECT rating, AVG(rental_duration)
FROM film F
GROUP BY rating;






