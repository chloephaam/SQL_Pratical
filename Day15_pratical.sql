--Bài tập ex1
select transaction_date,user_id,count(transaction_date) purchase_count
from
(select *,
rank() over(partition by user_id order by transaction_date desc)
from user_transactions
order by user_id,transaction_date desc) a
where rank = 1
group by user_id,transaction_date
order by transaction_date

--Bài tập ex2


--Bài tập ex3


--Bài tập ex4


--Bài tập ex5


--Bài tập ex6



--Bài tập ex7



--Bài tập ex8
