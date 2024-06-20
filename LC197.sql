USE leetcode;

Create table If Not Exists Weather (id int, recordDate date, temperature int);
Truncate table Weather;
insert into Weather (id, recordDate, temperature) values ('1', '2015-01-01', '10');
insert into Weather (id, recordDate, temperature) values ('2', '2015-01-02', '25');
insert into Weather (id, recordDate, temperature) values ('3', '2015-01-03', '20');
insert into Weather (id, recordDate, temperature) values ('4', '2015-01-04', '30');

SELECT * FROM Weather;

#다른 풀이들에비해 매우 빠르게 시행됨. 굿

#W2에 Yesterday데이터를 만들긴 했지만
#W2는 오늘 데이터고, W1의 recordDate가 진짜 어제 값인것임.
SELECT W2.id AS id
FROM Weather W1,
	 (SELECT id, recordDate, DATE_SUB(recordDAte, INTERVAL 1 DAY) Yesterday, temperature FROM Weather) AS W2
WHERE W1.recordDate = W2.Yesterday and W1.temperature < W2.temperature
;

#다른 풀이1
#DATEDIFF(A, B) 를 활용한 매우 간결하면서 핵심적인 풀이
	#내꺼랑 의도는 같은데 내가 조금 더 어렴게감.
    #그래도 DATE_SUB 써보는 좋은 기회였음.
SELECT *
FROM Weather w1, Weather w2
WHERE DATEDIFF(w1.recordDate, w2.recordDate) = 1 AND w1.temperature > w2.temperature;

#다른 풀이2
#나랑 원리는 동일한데 그냥 Weather 복붙만해서 간단하고
	#subdate 함수를 사용함. 내가 사용한 DATE_SUB와 기능은 동일
SELECT w2.id from Weather w1, Weather w2
WHERE w2.temperature > w1.temperature AND
subdate(w2.recordDate, 1) = w1.recordDate;

#다른 풀이3
#위에랑 의도 모두 같지만
#datediff를 사용하여 하루 차이를 계산함.
SELECT w2.id from Weather w1 JOIN Weather w2
ON w2.temperature > w1.temperature AND
datediff(w2.recordDate,w1.recordDate) = 1;
