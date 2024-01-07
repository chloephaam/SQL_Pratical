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
ROUND (SUM (item_count*(order_occurrences))/ SUM(order_occurrences)) as MEAN_ORDER
FROM items_per_order;

--Bài tập ex5


--Bài tập ex6


--Bài tập ex7


--Bài tập ex8


--Bài tập ex9


--Bài tập ex10


--Bài tập ex11


--Bài tập ex12
