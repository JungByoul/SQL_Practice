# 7m 51s 소요

# --테이블 정보
# DOCTOR 테이블.
#     DR_NAME, DR_ID, LCNS_NO, HIRE_YMD, MCDP_CD, TLNO는 각각 
#     의사이름, 의사ID, 면허번호, 고용일자,     진료과코드,  전화번호

# --문제 정리
# 기준은 의사. 어떤 의사?
# WHERE
#     MCDP_CD = ('CS' OR 'GS')
# SELECT DR_NAME, DR_ID, MCDP_CD, HIRE_YMD
# ORDER BY HIRE_YMD DESC, DR_NAME ASC

# --문제 전략
# --1 그냥 문제 정리한대로 ㄱㄱ
# --2 날짜만 date_format 으로 정리

-- 코드를 입력하세요
SELECT DR_NAME, DR_ID, MCDP_CD, DATE_FORMAT(HIRE_YMD, '%Y-%m-%d') HIRE_YMD
FROM DOCTOR
WHERE MCDP_CD = 'CS' OR MCDP_CD ='GS'
ORDER BY HIRE_YMD DESC, DR_NAME ASC;

-- 오답노트
# MCDP_CD = ('CS' OR 'GS') 이딴 코드는 없다!!
#     대신 IN 사용하자!!
        # MCDP_CD IN ('CS', 'GS')