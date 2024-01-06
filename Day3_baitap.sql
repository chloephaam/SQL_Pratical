--Bài tập ex1
SELECT NAME FROM CITY
WHERE POPULATION > 120000 AND COUNTRYCODE = 'USA';

--Bài tập ex2
SELECT * FROM CITY
WHERE COUNTRYCODE = 'JPN';

--Bài tập ex3
SELECT CITY, STATE FROM STATION
WHERE LAT_N > 0 AND LONG_W > 0;

--Bài tập ex4
SELECT DISTINCT CITY FROM STATION
WHERE (CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%')
AND LAT_N > 0 AND LONG_W > 0;

--Bài tập ex5
SELECT DISTINCT CITY FROM STATION
WHERE CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u'
AND LAT_N > 0 AND LONG_W > 0;

--Bài tập ex6
SELECT DISTINCT CITY FROM STATION
WHERE (CITY NOT LIKE 'A%' AND CITY NOT LIKE 'E%' AND CITY NOT LIKE 'I%' AND CITY NOT LIKE 'O%' AND CITY NOT LIKE 'U%')
AND LAT_N > 0 AND LONG_W >0;

--Bài tập ex7
SELECT name FROM Employee
ORDER BY name ASC;

--Bài tập ex8
SELECT name FROM Employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id ASC;

--Bài tập ex9


--Bài tập ex10
SELECT name from Customer
WHERE referee_id <> 2 OR referee_id IS null;

--Bài tập ex11
SELECT name, population, area FROM World
WHERE area >= 3000000 OR population >= 25000000;

--Bài tập ex12
SELECT DISTINCT author_id as id from Views
WHERE viewer_id = author_id
ORDER BY id ASC;

--Bài tập ex13

--Bài tập ex14

--Bài tập ex15
