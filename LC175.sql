#스키마 복붙하는 시간 합쳐서 5분컷 추정


Use leetcode;
Create table If Not Exists Person (personId int, firstName varchar(255), lastName varchar(255));
Create table If Not Exists Address (addressId int, personId int, city varchar(255), state varchar(255));
Truncate table Person;
insert into Person (personId, lastName, firstName) values ('1', 'Wang', 'Allen');
insert into Person (personId, lastName, firstName) values ('2', 'Alice', 'Bob');
Truncate table Address;
insert into Address (addressId, personId, city, state) values ('1', '2', 'New York City', 'New York');
insert into Address (addressId, personId, city, state) values ('2', '3', 'Leetcode', 'California');

Select * From Person;

Select firstName, lastName, city, state
From Person P Left Outer Join Address A ON
	P.personId = A.personId;

#다른 코드
select firstname, lastname, city, state from person
left join address using(personid)
