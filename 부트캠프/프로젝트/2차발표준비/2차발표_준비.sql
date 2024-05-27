-- 2 seller, customer 수(TOP10)
-- 2-1. 지역별 단순 전체 수

#각 주별 customer 수
SELECT customer_state, COUNT(customer_id) numbers
FROM olist_customers_dataset
GROUP BY customer_state;

#각 주별 seller 수
SELECT seller_state, COUNT(seller_id) numbers
FROM olist_sellers_dataset
GROUP BY seller_state;


-- 2-2. 5파운드 미만 customer 수
SELECT  customer_state, COUNT(C.customer_id)
FROM olist_customers_dataset C
	JOIN olist_orders_dataset O ON C.customer_id = O.customer_id
	JOIN olist_order_items_dataset I ON O.order_id = I.order_id
    JOIN olist_products_dataset P ON I.product_id = P.product_id
WHERE product_weight_g <= 2267
GROUP BY customer_state
ORDER BY COUNT(C.customer_id) DESC;


-- 2-3. 5파운드 미만 seller수
#order_items_dataset에서 order_id, order_item_id를 제거하고 seller로 묶기

CREATE VIEW new_order_items AS
SELECT product_id, seller_id
FROM olist_order_items_dataset;

SELECT seller_state, COUNT(DISTINCT I.seller_id) AS seller_count
FROM olist_sellers_dataset S 
    JOIN new_order_items I ON I.seller_id = S.seller_id
    JOIN olist_products_dataset P ON I.product_id = P.product_id
WHERE product_weight_g <= 2267
GROUP BY seller_state
ORDER BY seller_count DESC;


-- 3 판매량(seller거주지 기준)
-- 3-1. 주별 전체 판매량
SELECT seller_state, COUNT(*)
FROM olist_order_payments_dataset P
JOIN olist_order_items_dataset O ON P.order_id = O.order_id
JOIN olist_sellers_dataset S ON O.seller_id = S.seller_id
GROUP BY S.seller_state;

-- 3-2. 5파운드 미만 상품 판매량
SELECT seller_state, COUNT(O.order_id)
FROM olist_orders_dataset O
JOIN olist_order_items_dataset I ON O.order_id = I.order_id
JOIN olist_sellers_dataset S ON I.seller_id = S.seller_id
JOIN olist_products_dataset P ON I.product_id = P.product_id
WHERE product_weight_g <= 2267
GROUP BY seller_state;

