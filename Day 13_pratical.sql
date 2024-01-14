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


--Bài tập ex4


--Bài tập ex5


--Bài tập ex6


--Bài tập ex7


--Bài tập ex8


--Bài tập ex9


--Bài tập ex10


--Bài tập ex11


--Bài tập ex12

