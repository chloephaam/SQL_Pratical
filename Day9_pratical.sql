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
select x, y, z, 
case 
    when x + y > z and x + z > y and y + z > x then 'Yes' else 'No'
end as  triangle
from triangle;

--Bài tập ex3
SELECT 
ROUND((Sum(case 
  when call_category = 'n/a' or call_category IS NULL then 1 else 0
end)/ count(case_id))*100,1) as call_percentage
FROM callers;

--Bài tập ex4
select name
from Customer
where coalesce(referee_id,0)!=2

--Bài tập ex5
