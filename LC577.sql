#20분 정도 걸림
#문제 자체는 쉬웠는데 left join 오랜만에 쓰려니 헷갈림
	#처음엔 INNER JOIN 써버려서 데이터 몇개 날라갔었음
#WHERE 절에서 IS NULL 처음 써봄. = 는 안되는것 배움
#다른 사람 풀이로 
	#left join 에서 USING이랑
    #IFNULL 사용하는 것 알게됨
		#IF 사용법!! 숙지필요.
#FROM절에서 그냥 갖다대서 복붙하는거
	#계쏙 and 써야되는걸로 헷갈림
    # ,(콤마) 써야된다!!!
   
Use leetcode;
Create table If Not Exists Employee (empId int, name varchar(255), supervisor int, salary int);
Create table If Not Exists Bonus (empId int, bonus int);
Truncate table Employee;
insert into Employee (empId, name, supervisor, salary) values ('3', 'Brad', Null, '4000');
insert into Employee (empId, name, supervisor, salary) values ('1', 'John', '3', '1000');
insert into Employee (empId, name, supervisor, salary) values ('2', 'Dan', '3', '2000');
insert into Employee (empId, name, supervisor, salary) values ('4', 'Thomas', '3', '4000');
Truncate table Bonus;
insert into Bonus (empId, bonus) values ('2', '500');
insert into Bonus (empId, bonus) values ('4', '2000');

#방법1. 다른사람 답
SELECT name, bonus
FROM Employee LEFT JOIN Bonus
	USING(empId)
WHERE IFNULL(bonus, 0) <1000;

#방법2. 내가 푼 답
SELECT name, bonus
FROM Employee E LEFT JOIN Bonus B
	ON E.empId = B.empId
WHERE bonus < 1000 or bonus IS NULL;

-- SELECT *
-- FROM Employee E LEFT JOIN Bonus B
-- 	ON E.empId = B.empId;


