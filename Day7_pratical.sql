--Bài tập ex1
select Name from STUDENTS
where Marks > 75
order by Right (Name,3), ID;

--Bài tập ex2
select user_id,
Upper(substring (name from 1 for 1)) || lower(substring (name,2)) as name
from Users
order by user_id

--Bài tập ex3
SELECT manufacturer,
'$' || Round (sum (total_sales)/1000000) || ' ' || 'million' as total_sales
FROM pharmacy_sales
GROUP BY manufacturer
Order by total_sales DESC, manufacturer

--Bài tập ex4


--Bài tập ex5


--Bài tập ex6


--Bài tập ex7


--Bài tập ex8


--Bài tập ex9


--Bài tập ex10

