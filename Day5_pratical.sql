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


--Bài tập ex8


--Bài tập ex9


--Bài tập ex10


--Bài tập ex11


--Bài tập ex12
