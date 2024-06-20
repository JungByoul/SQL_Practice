USE leetcode;

Create table If Not Exists Weather (id int, recordDate date, temperature int);
Truncate table Weather;
insert into Weather (id, recordDate, temperature) values ('1', '2015-01-01', '10');
insert into Weather (id, recordDate, temperature) values ('2', '2015-01-02', '25');
insert into Weather (id, recordDate, temperature) values ('3', '2015-01-03', '20');
insert into Weather (id, recordDate, temperature) values ('4', '2015-01-04', '30');

SELECT * FROM Weather;

SELECT *
FROM Weather W1,
	 (SELECT id, recordDate, DATE_SUB(recordDAte, INTERVAL 1 DAY) Yesterday, temperature FROM Weather) AS W2

;