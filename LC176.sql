-- Null 조건 생각하느라  IFNULL 쓰려했는데 잘안된. 근데 이거 없얻도 되는거였음
-- 

Use leetcode;

Drop table Employee;
Create table Employee (id int, salary int);
Truncate table Employee;
insert into Employee (id, salary) values ('1', '100');
insert into Employee (id, salary) values ('2', '200');
insert into Employee (id, salary) values ('3', '300');

-- 풀이1: LIMIT OFFSET 기능
select
(select distinct Salary 
from Employee order by salary desc 
limit 1 offset 1) 
as SecondHighestSalary;
-- (offset 1이니까 1번째 다음행인 2행에서
-- limit 1, 즉 1개만큼의 행을 출력. 곧 2~2행을 출력)
-- limit 1,1 과 동일함 (출발점이 1)
-- 참고링크: https://inpa.tistory.com/entry/MYSQL-%F0%9F%93%9A-LIMIT-OFFSET


-- 풀이3 IFNULL까지 가세
SELECT
    IFNULL(
      (SELECT DISTINCT Salary
       FROM Employee
       ORDER BY Salary DESC
        LIMIT 1 OFFSET 1),
    NULL) AS SecondHighestSalary;

-- 풀이3: 서브쿼리 where문에서 활용
SELECT  MAX(SALARY) AS SecondHighestSalary 
FROM EMPLOYEE 
WHERE SALARY <>(SELECT MAX(SALARY) FROM EMPLOYEE); 


-- 풀이3: 내꺼
SELECT Max(salary) AS SecondHighestSalary
FROM (
SELECT salary FROM Employee
EXCEPT
SELECT MAX(salary) FROM Employee) E1;