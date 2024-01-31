


-- 1. film 테이블에서 영화 제목( title )의 길이가 15자인 영화들을 찾아주세요.
-- 2. actor 테이블에서 첫 번째 이름( first_name )이 소문자로 'john'인 배우들의 전체 이름을 대문자로 출력해주세요.

SELECT title
FROM film
WHERE LENGTH(title) = 15;

SELECT 
	UPPER(CONCAT(first_name, ', ', last_name))
FROM actor
WHERE LOWER(first_name) = 'john';


-- 3. film 테이블에서 description 의 3번째 글자부터 6글자가 'Action'인 영화의 제목을 찾아주세요.
SELECT 
	title
FROM film
WHERE SUBSTRING(description, 3, 6) = 'Action';


-- 4. rental 테이블에서 대여 시작 날짜( rental_date )가 2006년 1월 1일 이후인 모든 대여에 대해, 예상 반납 날짜를
-- 대여 날짜로부터 5일 뒤로 설정하여, 출력해주세요.
SELECT 
    rental_date, 
    DATE_ADD(rental_date, INTERVAL 5 DAY)
FROM 
    rental
WHERE YEAR(rental_date) = '2006'
LIMIT 5;




SELECT 
	ABS(amount)
FROM payment
WHERE amount <= 5;

SELECT 
	SQRT(length)
FROM film
WHERE length >= 120;

-- 기본 연습문제
-- 1. film 테이블에서 평균 영화 길이( length )보다 긴 영화들의 제목( title )을 찾아주세요.
USE sakila;

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 2. rental 테이블에서 고객별 평균 대여 횟수보다 많은 대여를 한 고객들의 이름( first_name , last_name )을 찾아주세요
#어렵다,, 못풀음
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > (
		SELECT AVG(rental_count)
        FROM (
			SELECT COUNT(*) AS rental_count
            FROM rental
            GROUP BY customer_id
        ) AS rental_counts
    )
);

select * from rental limit 20;
select * from customer limit 20;

-- 3. 가장 많은 영화를 대여한 고객의 이름( first_name . last_name )을 찾아주세요.
-- 못풀음
SELECT customer_id
FROM rental
GROUP BY customer_id
LIMIT 10;
-- WHERE customer_id IN (SELECT FROM customer)

-- 정답1
SELECT first_name, last_name
FROM customer
WHERE customer_id = (
	SELECT customer_id
    FROM (
		SELECT customer_id, COUNT(*) AS rental_count
		FROM rental
        GROUP BY customer_id
    ) AS rental_counts
    ORDER BY rental_count DESC
    LIMIT 1
);
-- 정답2
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM rental
    GROUP BY customer_id
	HAVING COUNT(*) = (
		SELECT MAX(rental_count)
		FROM (
			SELECT customer_id, COUNT(*) as rental_count
			FROM rental
			GROUP BY customer_id
			) AS rental_counts
		)
	);

-- 4. 각 고객에 대해 자신이 대여한 평균 영화 길이( length )보다 긴 영화들의 제목( title A찾아주세요.


-- 1. rental 과 inventory 테이블을 JOIN하고, film 테이블에 있는 replacement_cost 가 $20 이상인 영화
-- 를 대여한 고객의 이름을 찾으세요. 고객 이름은 소문자로 출력해주세요.
SELECT LOWER(first_name)
FROM customer
WHERE customer_id IN (
	SELECT customer_id 
    FROM rental INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
    WHERE film_id IN (
		SELECT film_id
        FROM film
        WHERE replacement_cost >= 20
    )
);




