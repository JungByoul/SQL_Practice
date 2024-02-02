

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




-- 연습문제23 (실전)
-- 각 카테고리의 평균 영화 러닝타임이 전체 평균 러닝타임보다 큰 카테고리들
-- 의 카테고리명과 해당 카테고리의 평균 러닝타임을 출력하세요


