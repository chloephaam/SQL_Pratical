--Bài tập ex1
with tb_job_count as (
select company_id,  title,
count (job_id) as job_count
from job_listings
group by company_id,  title)
select count (DISTINCT company_id)
from tb_job_count
where job_count >1

--Bài tập ex2
with tb_total_spend_product AS(
select category, product, 
sum (spend) as total_spend
from product_spend
where extract (year from transaction_date) = 2022
group by category, product)
select category, product, total_spend 
from tb_total_spend_product as t1 
WHERE
(select 
count (distinct t2.product)
from tb_total_spend_product as t2
where t1.category=t2.category and t1.total_spend <= t2.total_spend) <=2

--Bài tập ex3
select count (policy_holder_id) as member_count
from (SELECT policy_holder_id, 
count (case_id) as count_call
FROM callers
group by policy_holder_id
having count (case_id) >= 3) as t1

--Bài tập ex4
select p1.page_id
from pages as p1
left join page_likes as p2 
on p1.page_id = p2.page_id
Where p2.page_id is NULL

--Bài tập ex5
select 
extract(month from event_date) as month,
count(distinct user_id) as monthly_active_users
from user_actions
where 
extract(month from event_date) = 7 and extract(year from event_date) = 2022
group by extract(month from event_date)
order by extract(month from event_date)

--Bài tập ex6
select 
extract(year from trans_date)|| '-' || extract(month from trans_date) as month,
country,
count(*) as trans_count,
sum(case when state = 'approved' then 1 else 0 end) as approved_count,
sum(amount) as trans_total_amount,
sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
from transactions
group by month, country


--Bài tập ex7
select s.product_id, s.year as first_year, s.quantity, s.price
from Sales as s
inner join 
(select product_id, 
min(year) AS min_year
from Sales
group by product_id
) as m 
on s.product_id = m.product_id and s.year = m.min_year


--Bài tập ex8
select c.customer_id
from Customer as c 
inner join Product as p
on c.product_key = p.product_key
group by c.customer_id
having count(distinct p.product_key) = (select count(product_key) from Product)

--Bài tập ex9
select employee_id
from Employees
where manager_id not in (select employee_id from employees) and salary < 30000
order by employee_id ASC

--Bài tập ex10
select count(distinct company_id) as duplicate_companies
from job_listings
where (title, description, company_id) in
(select title, description, company_id
from job_listings
group by title, description, company_id
having count(*) > 1)

--Bài tập ex11
with user_rating_count as 
(select u.user_id, u.name,
count(r.movie_id) as rating_count
from users as u
left join movierating as r 
on u.user_id = r.user_id
group by u.user_id, u.name),
movie_avg_rating as 
(select m.movie_id, m.title,
avg(r.rating) as avg_rating
from movies as m
left join movierating as r 
on m.movie_id = r.movie_id
where extract(month from r.created_at) = 2 and extract(year from r.created_at) = 2020
group by m.movie_id, m.title)
(select name as results
from user_rating_count
where rating_count = (select max(rating_count) from user_rating_count)
order by name
limit 1)
union all
(select title as results
from movie_avg_rating
where avg_rating = (select max(avg_rating) from movie_avg_rating)
order by title
limit 1)


--Bài tập ex12
with t1 as(
select requester_id , accepter_id
from RequestAccepted
union all
select accepter_id , requester_id
from RequestAccepted
)
select requester_id as id, count(accepter_id) as num
from t1
group by 1
order by 2 DESC
limit 1  
