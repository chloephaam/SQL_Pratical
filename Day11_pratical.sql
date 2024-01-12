--Bài tập ex1
select t2.continent as continent,
floor(avg(t1.population))
from city as t1
left join country as t2
on t1.CountryCode=t2.Code
where continent is not NULL
group by t2.continent

--Bài tập ex2
select
count(distinct t2.email_id) / count(distinct t1.email_id) AS confirm_rate
from emails as t1
left join texts as t2 
on t1.email_id = t2.email_id
where t2.signup_action = 'Confirmed'

--Bài tập ex3
select t2.age_bucket, 
round(100.0 * sum(case
    when t1.activity_type = 'send' then t1.time_spent alse 0 
end)/ Ssum(t1.time_spent), 2) as send_perc, 
round(100.0 * sum(case 
    when t1.activity_type = 'open' then t1.time_spent else 0 
end)/ sum(t1.time_spent), 2) AS open_perc
from activities as t1
inner join age_breakdown AS t2 
on t1.user_id = t2.user_id 
where t1.activity_type in ('send', 'open') 
group by t2.age_bucket

--Bài tập ex4
select count(distinct t1.customer_id) AS supercloud_customers
from customer_contracts as t1
left join products as t2 
on t1.product_id = t2.product_id
group by t1.customer_id
having count(distinct t2.product_category) = (select count(distinct product_category) from products)

--Bài tập ex5


--Bài tập ex6

--Bài tập ex7
