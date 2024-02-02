USE sakila;

SELECT category_id, name 
FROM category
WHERE name IN ("Comedy", "Sports", "Family")




SELECT category_id
FROM film_category
WHERE film_id = 2;
SELECT category_id, COUNT(*)
FROM film_category
GROUP BY category_id;
SELECT name, COUNT(*)
FROM category C
JOIN film_category FC 
ON C.category_id = FC.category_id
WHERE name = "Comedy";
SELECT COUNT(*)
FROM film_category
WHERE category_id IN (
	SELECT category_id FROM category
    WHERE name = "Comedy"
)
SELECT name, COUNT(*)
FROM film_category FC
JOIN category C
ON C.category_id = FC.category_id
WHERE name IN ("Comedy", "Sports", "Family")
GROUP BY name;
SELECT name
FROM film_category F
JOIN category C ON F.category_id = C.category_id
GROUP BY name
HAVING COUNT(*) >= 70;
SELECT name, COUNT(*)
FROM category C
JOIN film_category FC ON C.category_id = FC.category_id
JOIN inventory I ON FC.film_id = I.film_id
JOIN rental R ON I.inventory_id = R.inventory_id
GROUP BY name;


SELECT name, COUNT(*)
FROM category C
JOIN film_category FC ON C.category_id = FC.category_id
JOIN inventory I ON FC.film_id = I.film_id
JOIN rental R ON I.inventory_id = R.inventory_id
WHERE name IN ("Comedy", "Sports", "Family")
GROUP BY name
 
Dave Lee님이 모두에게 (2024년 2월 1일, 오전 11:29)
SELECT COUNT(*) FROM rental
WHERE inventory_id IN (
	SELECT inventory_id FROM inventory
    WHERE film_id IN (
		SELECT film_id FROM film_category
        WHERE category_id IN (
			SELECT category_id FROM category
            WHERE name = "Comedy"
        )
    )



프로젝트 목적
• 최근 활성화되고 있는 웹/앱 비지니스 이해를 위해, 최근 비지니스의 주요 요소를 모두 가지고 있는 E-Commerce 시장에 대한 이해 증진 및 데이터 분석
 역량 강화
0 E-commerce 데이터를 기반으로 데이터 분석 실습
• 해당 데이터를 기반으로 최대한 얻어낼 수 있는 정보를 분석하여, 현업에서 자주 진행하는 벤치마킹과 데이터 탐색에 대한 이해
• 스타트업 스타일의 업무 스타일을 직접 체험하며, 업무 스타일에 적응하기

데이터 세트에 대한 소개
현업의 가장 큰 어려움: 데이터가 없다!
데이터는 언제나 없고, 한계가 있으므로, 이 상태에서도 최대한의 인사이트를 추출하는 것이 우리의 역할!
• Olist E-Commerce 데이터셋 (운영 측면): Olist, 브라질의 대표적인 온라인 상점에서 수집한 주문, 제품, 고객 등에 대한 데이터로 구성.
• 장점: 안정된 데이터셋, 가장 SQL 스럽게 구성된 데이터로 여러 테이블로 구성, 트랜드 분석 가능한 데이터량
0 단점: 운영적 측면의 데이터셋
• Marketing Funnel by Olist (마케팅 측면): 고객의 마케팅 퍼널 정보를 담고 있으며. 리드 단계부터 고객 변화까지의 과정을 분석 가능.
• 장점: 마케팅과 같은 배경지식까지 정리해볼 수 있는 매력적인 데이터셋
• 단점: 트랜드 분석이 다소 한계가 있는 데이터량
• Olist E-Commerce 데이터셋과 JOIN 하여, 이 부분을 극복시도해볼 수 있으나, 데이터량 자체의 한계는 있음
• 추가: eCommerce Events History in Cosmetics Shop (고객행동 측면): 실험적 데이터 세트로, 이커머스 사이트에서 고객행동을 로깅한 데이터.
• 장점: 방대한 데이터량
• 단점: 하나의 테이블로 구성되어 있어서, 다양한 트랜드가 나올 수 있을지는 이번에 확인해봐야 함

• 추가: eCommerce Events History in Cosmetics Shop (고객행동 측면): 실험적 데이터 세트로, 이커머스 사이트에서 고객행동을 로깅한 데이터.
•  장점: 방대한 데이터량 
• 단점: 하나의 테이블로 구성되어 있어서, 다양한 트랜드가 나올 수 있을지는 이번에 확인해봐야 함
 프로젝트 진행 방법
• 프로젝트 시간에는 각자 지금까지 진행한 작업을 모두가 이해할 수 있는 자료로 만들어서, 발표함 (발표 시간 20분 및 질문답변 포함 최대 30분)
• 타팀이 발표하면, 관련 발표에 대해 의견이나, 질문이 있을 경우, 질문/답변을 진행함
• 강사 포함 모두의 의견을 청취하고, 스스로 판단하여 프로젝트 개선


데이터는 SQL 기반으로 제공되지만, SQL 외 파이썬등 사용할 수 있는 모든 기술을 사용해도 됨
팀원 구성
• 팀원들은 최대 4인 1조로 구성하여, 함께 업무 분담부터, 목표 설정, 발표까지 모두 직접 결정
•  분석 담당, 발표 담당과 같이 완전히 업무를 분리하지 말고, 둘 다 돌아가며 진행해야 함
• 발표도 발표 담당을 두지 않고, 모두 진행해야 함
• 타팀 발표를 참고하여, 자신의 최종 결과를 최대한 완벽한 분석으로, 완벽한 발표 자료 작성 및 발표를 목표로 함
유의할 점
이미 결론이 있는 분석이 아니므로, 모두 논의하며, 만들어간다고 생각해야 함
. 타팀의 분석화 자신의 팀의 분석을 비교하여, 실수나 개선점이 있으면 흡수하여, 개선하기 • 목표는 최대한 완벽하고, 깊은 분석이며, 스스로 목표를 설정하고, 작업을 분담하여, 짧은 시간에 좋은 결과를 내고자 해야 함
• 타 팀에서 자신의 팀의 분석 스크립트나 설명을 요구할 경우, 온전히 모두 오픈하고, 논의
• 오픈 데이터는 한계가 있고, 정보도 부족하므로, 스스로 관련 정보를 찾아야 함
• 모든 분석은 모두가 accept 할만한 근거를 제시해야 하며, 타 팀의 분석이 잘못되었다면, 이 부분도 바로 의견을 내야 함
 프로젝트 평가 기준 (원칙)
| Crica) 한 부정 정가 기준에 조금이라도 부향되는 케이스는 반드시 풍수해주세요
