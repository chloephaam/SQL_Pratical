--Bài tập ex1
with new_tb as 
(select extract(year from transaction_date), product_id, spend as curr_year_spend, 
lag(spend) over(partition by product_id  order by extract(year from transaction_date)) as prev_year_spend
from user_transactions)
select * , round((curr_year_spend - prev_year_spend)/prev_year_spend * 100, 2)   
from new_tb

--Bài tập ex2
select card_name, issued_amount
from(
select card_name, issued_amount,
dense_rank() over(partition by card_name order by issue_year, issue_month) as rank
from monthly_cards_issued
) as a
where rank=1
order by issued_amount desc

--Bài tập ex3
with tb_user_id as
(select user_id, spend, transaction_date,
row_number() over(partition by user_id order by user_id,transaction_date) as row_num
from transactions)
select user_id, spend, transaction_date from tb_user_id
where row_num = 3

--Bài tập ex4
select transaction_date,user_id,count(transaction_date) purchase_count
from
(select *,
rank() over(partition by user_id order by transaction_date desc)
from user_transactions
order by user_id,transaction_date desc) a
where rank = 1
group by user_id,transaction_date
order by transaction_date

--Bài tập ex5


--Bài tập ex6



--Bài tập ex7



--Bài tập ex8
