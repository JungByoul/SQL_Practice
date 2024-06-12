#결국 GPT에게 물어봄
#문제풀이 많이해댜할듯. 1시간 반은 걸림 이 쉬웠던 문제를..

Use leetcode;

Create table If Not Exists Person182(
	id int,
    email varchar(15),
    Primary Key(id) 
    );
Truncate table Person182;
Insert Into Person182 (id, email) values ('1', 'a@b.com');
Insert Into Person182 (id, email) values ('2', 'c@d.cpm');
Insert Into Person182 (id, email) values ('3', 'a@b.com');


Select email Email
From Person182
Group By email
Having Count(email) >1;


# Please upvote, if you like my solution
# 1
SELECT email from Person
group by email
having count(email) > 1;

# 2.
SELECT DISTINCT(p1.email) from Person p1, Person p2
where p1.id <> p2.id AND p1.email = p2.email;

#3. 
SELECT DISTINCT(p1.email) from 
Person p1 JOIN Person p2 ON
p1.email = p2.email AND p1.id <> p2.id;
# feel free to ask anything, if have any doubts

-- Select email Email
-- From Person182
-- Where email > (
-- 	Select Distinct email
--     From Person182
-- );

-- Select Distinct A.email Email
-- From Person182 A Inner Join Person182 B
-- 	ON A.id = B.id;

-- Select email
-- From (
-- 	Select email From Person182
-- 	) nPerson182
-- Except
-- Select Distinct email
-- From (
-- 	Select email From Person182
--     ) nPerson182;

-- EXCEPT 연산자는 집합 연산자로서 중복을 제거하고 결과를 반환합니다. 따라서 EXCEPT 연산을 수행할 때, 각 이메일의 개수와 관계없이 전체 결과 셋에서 중복되지 않은 이메일만 남기게 됩니다.

-- 당신의 예에서:

-- EXCEPT 위의 쿼리에서 a, c, a가 있습니다.
-- EXCEPT 아래의 쿼리에서 a, c가 있습니다.
-- 이 경우, EXCEPT는 다음과 같이 동작합니다:

-- 첫 번째 쿼리의 결과: a, c, a
-- 두 번째 쿼리의 결과: a, c
-- EXCEPT 연산 후: a, c가 첫 번째 쿼리와 두 번째 쿼리에 모두 존재하므로 제거됩니다.
-- 이로 인해 결과적으로 빈 결과 셋이 반환됩니다.








