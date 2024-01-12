--Bài tập ex1
select t2.continent as continent,
floor(avg(t1.population))
from city as t1
left join country as t2
on t1.CountryCode=t2.Code
where continent is not NULL
group by t2.continent

--Bài tập ex2
SELECT
COUNT(DISTINCT t2.email_id) / COUNT(DISTINCT t1.email_id) AS confirm_rate
FROM emails as t1
LEFT JOIN texts as t2 
ON t1.email_id = t2.email_id
WHERE t2.signup_action = 'Confirmed';

--Bài tập ex3


--Bài tập ex4

--Bài tập ex5


--Bài tập ex6

--Bài tập ex7
