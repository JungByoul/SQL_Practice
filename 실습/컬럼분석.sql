SELECT * FROM olist_customers_dataset;
#고객 고유 id
#(고객 거주)도시 이름, 도시 약칭
#customer_zip_code_prefix?
SELECT * FROM olist_geolocation_dataset;
#위도, 경도
#도시 이름, 도시 약칭
#geolocation_zip_code_prefix?

SELECT review_score FROM olist_order_reviews_dataset;

SELECT * FROM olist_order_items_dataset 
ORDER BY order_item_id1
LIMIT 10;
#고유 주문id
#상품 id, 판매자 id, 가격
#최종선적일(latest shipping date): 선적이 허용되는 최종일.(5월 선적이면 신용장에는 'not later than May 31')
#freight_value: 운임비용

SELECT * FROM olist_order_payments_dataset
ORDER BY payment_sequential DESC
LIMIT 10;

SELECT * FROM olist_order_reviews_dataset;

SELECT * FROM olist_products_dataset;
SELECT COUNT(product_photos_qty) FROM olist_products_dataset;

SELECT COUNT(review_comment_title) FROM olist_order_reviews_dataset;

SELECT COUNT(*)
FROM (
SELECT COUNT(*) FROM olist_products_dataset
GROUP BY product_category_name
) as subquery;

SELECT * FROM olist_sellers_dataset;

SELECT COUNT(*) FROM product_category_name_translation;

SELECT * FROM olist_orders_dataset;
