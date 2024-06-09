#푸는데 20분 걸림
# inner join 까먹었었음.
#조인할 때 어떻게해야 조건에 맞는 from 절 세팅을 할지 고민 오래함alter
#전체 데이터베이스 구축하고, 거기서 왼쪽 오른쪽 나눠서 생각함
#한 테이블 복사해서 핸들링하는 문젠데 방법론 다 까먹었음

Use leetcode;

Create table If Not Exists Employee (id int, name varchar(255), salary int, managerId int);
Truncate table Employee;
insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3');
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4');
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', Null);
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', Null);

Select E2.name AS Employee
From Employee E1 Inner Join Employee E2
	ON E1.id = E2.managerId
Where E1.salary < E2.salary
    ;
    
