--Bài tập ex1
SELECT distinct CITY
FROM STATION
WHERE ID % 2 = 0
AND LAT_N > 0 AND LONG_W > 0;

--Bài tập ex2
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) 
FROM STATION;

--Bài tập ex3


--Bài tập ex4
SELECT
ROUND (CAST(SUM (item_count*(order_occurrences))/ SUM(order_occurrences) AS DECIMAL),1) as MEAN_ORDER
FROM items_per_order;

--Bài tập ex5
SELECT candidate_id FROM candidates
WHERE skill in ('Python', 'Tableau', 'PostgreSQL')
GROUP BY (candidate_id)
HAVING COUNT(skill) = 3
ORDER BY candidate_id;

--Bài tập ex6
Select user_id,
DATE (MAX (post_date)) - DATE (MIN (post_date)) as day_between
from posts
WHERE post_date >= '01-01-2021' AND post_date < '01-01-2022'
GROUP by user_id
Having COUNT (post_id) > 1

--Bài tập ex7
SELECT card_name,
MAX(issued_amount) - MIN(issued_amount) as difference
FROM monthly_cards_issued
GROUP BY card_name
order by difference DESC

--Bài tập ex8
SELECT manufacturer,
Count (drug) as drug_count,
ABS(sum(total_sales - cogs)) as total_loss
FROM pharmacy_sales
WHERE total_sales < cogs
GROUP BY manufacturer
order by total_loss DESC

--Bài tập ex9
SELECT * FROM Cinema
WHERE id % 2 <>0
AND description not like '%boring%'
order by rating desc

--Bài tập ex10
SELECT teacher_id, 
COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;

--Bài tập ex11
SELECT user_id, 
COUNT (follower_id) as followers_count
from Followers
Group by user_id
Order by user_id ASC

--Bài tập ex12
Select class
from Courses
Group by Class
Having count (student) >= 5
