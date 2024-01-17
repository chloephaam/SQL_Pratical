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
with new_tb as 
(select user_id, tweet_date, tweet_count,
avg(tweet_count) over (partition by user_id order by tweet_date rows between 2 preceding and current row) as rolling_avg_3d
from tweets)
select user_id, tweet_date,
round(rolling_avg_3d, 2) as rolling_avg_3d
from tnew_tb;

--Bài tập ex6
with new_tb as 
(select *
from transactions t1, transactions t2 
where
extract(minute from (t1.transaction_timestamp - t2.transaction_timestamp)) < 10 and
extract(minute from (t1.transaction_timestamp - t2.transaction_timestamp)) > 0 and
        t1.merchant_id = t2.merchant_id and
        t1.credit_card_id = t2.credit_card_id and
        t1.amount = t2.amount)
select count(*) as payment_count
from new_tb;

--Bài tập ex7
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
order by category asc, total_spend DESC


--Bài tập ex8
with top_artists as 
(select artist_name, count(*) as no_appearance
 from artists as a
 join songs as s 
 on s.artist_id=a.artist_id
 join global_song_rank as g 
 on g.song_id=s.song_id
 where g.rank < 11
 group by artist_name)
select artist_name, artist_rank
from 
(select artist_name, dense_rank() over(order by no_appearance desc) as artist_rank
 from top_artists) as top
where artist_rank < 6;
