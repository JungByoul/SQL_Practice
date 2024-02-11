#파블로 항공의 전략기획실 해외사업팀 소속.
#폭발적인 브라질 이커머스 시장의 성장과 함께
#Olist의 드론 배송 사업을 위한 MOU 체결.
#사업 타당성 조사를 위해 드론 배송 적합지를 분석

#0.전처리 단계에서 동남부만 살리고 나머지 제거
#0-1. 배송 지연 날짜가 n일 이상 미뤄진 주문만 추리기
#1.지도시각화로 판매자와 구매자 위치 좌표에 점찍기
#2.판매자-구매자 위치의 중앙값 위치 점찍기
#3. 
#4. 드론 배송센터(드론 배송센터 출발-> 판매자 주소에서 물건 수령-> 구매자 주소 이동-> 배송센터 도착)

SELECT * FROM olist_orders_dataset
LIMIT 100000;
#배송날짜


SELECT product_category_name_english, AVG(product_weight_g)/1000 avg_weight_kg 
FROM olist_products_dataset PRO 
JOIN product_category_name_translation TRA 
ON PRO.product_category_name = TRA.product_category_name 
WHERE product_category_name_english IS NOT NULL GROUP BY product_category_name_english 
HAVING avg_weight_kg <= 2.26 
ORDER BY avg_weight_kg DESC;

olist_products_dataset;
product_category_name_translation;

SELECT * FROM olist_products_dataset;

SELECT DISTINCT P.product_id, product_category_name, product_weight_g, IT.order_id, seller_id, C.customer_id,customer_city
FROM olist_products_dataset P
	JOIN olist_order_items_dataset IT ON P.product_id = IT.product_id
    JOIN olist_orders_dataset O ON IT.order_id = O.order_id
    JOIN olist_customers_dataset C ON O.customer_id = C.customer_id
    -- JOIN olist_geolocation_dataset G ON C.customer_zip_code_prefix = G.geolocation_zip_code_prefix
WHERE product_weight_g < 2267 #5 파운드 =2267.96g
LIMIT 10000;



SELECT COUNT(IT.order_id) cnt,
	P.product_category_name, 
	C.customer_city
FROM 
    olist_products_dataset P
    JOIN olist_order_items_dataset IT ON P.product_id = IT.product_id
    JOIN olist_orders_dataset O ON IT.order_id = O.order_id
    JOIN olist_customers_dataset C ON O.customer_id = C.customer_id
WHERE 
    P.product_weight_g < 2267
GROUP BY
    P.product_category_name;



SELECT 
    S.seller_city,
    P.product_category_name,
    COUNT(IT.order_id) AS count
FROM 
    olist_products_dataset P
    JOIN olist_order_items_dataset IT ON P.product_id = IT.product_id
    JOIN olist_sellers_dataset S ON IT.seller_id = S.seller_id
WHERE 
    P.product_weight_g < 2267
GROUP BY 
    S.seller_city,
    P.product_category_name;

SELECT 
	DISTINCT geolocation_state
FROM olist_geolocation_dataset
LIMIT 1500; 




