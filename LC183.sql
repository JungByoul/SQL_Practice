-- 10분컷함. IS를 시도해본게 큰듯.
-- 이런 풀이도 있음.
-- 풀이1
select name as customers from customers
where id not in (select customerid from orders)
-- 풀이2는 내가 푼거


Use leetcode;

Create table If Not Exists Customers (id int, name varchar(255));
Create table If Not Exists Orders (id int, customerId int);
Truncate table Customers;
insert into Customers (id, name) values ('1', 'Joe');
insert into Customers (id, name) values ('2', 'Henry');
insert into Customers (id, name) values ('3', 'Sam');
insert into Customers (id, name) values ('4', 'Max');
Truncate table Orders;
insert into Orders (id, customerId) values ('1', '3');
insert into Orders (id, customerId) values ('2', '1');

Select C.name Customers
From Customers C Left Outer Join Orders O 
	ON C.id = O.customerId
Where O.customerId is NULL;
