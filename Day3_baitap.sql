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

--Bài tập ex6

--Bài tập ex7

--Bài tập ex8

--Bài tập ex9

--Bài tập ex10

--Bài tập ex11

--Bài tập ex12

--Bài tập ex13

--Bài tập ex14

--Bài tập ex15