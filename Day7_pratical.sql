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
SELECT product_id,
Round(Avg (stars),2) as avg_stars,
extract(month from submit_date) as mth
FROM reviews
Group by mth, product_id
order by mth, product_id

--Bài tập ex5
SELECT sender_id,
count (message_id) as total_msg
FROM messages
where (extract(month from sent_date) = 08)
group by sender_id
order by (total_msg) DESC
limit 2

--Bài tập ex6

select tweet_id
from Tweets
where length (content) > 15

--Bài tập ex7
select activity_date as day,
count (distinct user_id) as active_users
from Activity
where (activity_date <= '2019-07-27' and activity_date > '2019-06-27')
group by (activity_date)

--Bài tập ex8
select id, joining_date,
count (id)
from employees
where (joining_date >= '2022-01-01' and joining_date <= '2022-07-01') 
group by id, joining_date

--Bài tập ex9
select position ('a' in first_name) 
from worker
where first_name ='Amitah'

--Bài tập ex10
select 
substring (title,(length (winery)+2), 4)
from winemag_p2
where country = 'Macedonia'
