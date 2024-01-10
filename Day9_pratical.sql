--Bài tập ex1
SELECT
Sum (CASE
  when device_type = 'laptop' then 1 else 0
end) as laptop_views,
Sum (CASE
  when device_type = 'laptop' or device_type = 'tablet' then 1 else 0
end) as 	mobile_views
FROM viewership;

--Bài tập ex2


--Bài tập ex3


--Bài tập ex4


--Bài tập ex5
