#지금까지 푼 것중 가장 어려운데..?
Use leetcode;
Drop table Person;
Create table If Not Exists Person (Id int, Email varchar(255));
Truncate table Person;
insert into Person (id, email) values ('1', 'john@example.com');
insert into Person (id, email) values ('2', 'bob@example.com');
insert into Person (id, email) values ('3', 'john@example.com');

#중복된 이메일 제거
#단, 아이디 낮은 행을 살릴것
#DELETE 사용할것

#도저히 못풀겠어서 참고함
#https://data-so-hard.tistory.com/78

#group by 쓰려고 select에 email을 넣긴했지만
	#실제 꺼내려던 것은 min(id) 이므로 min_id를 굳이 지정해주고
    #이걸 특정해서 밖으로 꺼냄.
    #그리고 이 꺼내진 정답인 애들(mini.min_id) 제외하고
    #다 지워버린 것임

DELETE FROM Person
WHERE id NOT IN (
	SELECT mini.min_id
    FROM ( SELECT email, min(id) AS min_id
			FROM Person
			GROUP BY email
    ) mini
    ) 