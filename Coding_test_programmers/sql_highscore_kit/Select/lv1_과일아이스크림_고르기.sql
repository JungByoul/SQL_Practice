# 20m 46s 소요

# -- 코드를 입력하세요
# 가게의 상반기 주문 정보를 담은 FIRST_HALF 테이블
#     pk = FLAVOR
# SHIPMENT_ID, FLAVOR, TOTAL_ORDER
# 출하 번호, 아이스크림 맛, 상반기 아이스크림 총주문량


#  아이스크림 성분에 대한 정보를 담은 ICECREAM_INFO 테이블
#         pk = FLAVOR
# FLAVOR, INGREDITENT_TYPE 은 각각 
# 아이스크림 맛, 아이스크림의 성분 타입
# # -- 문제 정리
# WHERE
# FIRST_HALF.TOTAL_ORDER > 3000
#     AND ICECREAM_INFO.INGREDITENT_TYPE = fruit_based

# SELECT FLAVOR(2개 테이블에 둘다 pk로 존재)

# ORDER BY FIRST_HALF.TOTAL_ORDER ASC

# --풀기 전략
# 1 flavor가 두 테이블에서 pk 이면서 공통 컬럼이니까, 이걸로 그냥 inner 조인
#     1-0 아래 1-1, 1-2는 패스해도 됨. 프로그래머스에서는 여기 예시 테이블은 진짜 그냥 예시임.
#           내가 불러오는 데이터랑 동일한건 절대 아님
    # 1-1 실수나옴. inner 조인 쓰면 fh의 flavor가 생략이됨. 왜? II테이블의 flavor는
    #     fh 테이블 flavor 의 외래키니까.
    # 1-2 따라서
# 2 조인한 테이블에 문제 정리에 써둔 조건이랑 내용들 그대로 적용


# # --문제 풀기
SELECT FH.FLAVOR # FLAVOR 를 무조건 FH로 해야하는가? II는 안되나?
FROM FIRST_HALF AS FH JOIN ICECREAM_INFO AS II
    ON FH.FLAVOR = II.FLAVOR
WHERE  FH.TOTAL_ORDER > 3000 AND II.INGREDIENT_TYPE = 'fruit_based'
ORDER BY FH.TOTAL_ORDER DESC;


