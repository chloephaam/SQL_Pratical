--1
select
format_date('%Y-%m', o.created_at) as month_year,
count(distinct o.user_id) as total_users,
count(distinct o.order_id) as total_orders
from bigquery-public-data.thelook_ecommerce.orders o
where o.created_at between timestamp('2019-01-01') and timestamp('2022-04-30')
and o.status not in ('Cancelled', 'Returned')
group by month_year
order by month_year

/*Tổng số lượng người dùng và đơn hàng có xu hướng tăng qua từng tháng, đặc biệt là từ tháng 6 năm 2021 đến tháng 3 năm 2022.
Tổng số lượng người dùng và đơn hàng tăng có thể  kết quả của chiến lược tiếp thị, mở rộng danh mục sản phẩm hoặc cải thiện trải nghiệm người dùng.
Tháng 3 năm 2022 là thời điểm có nhiều đơn hàng nhất- 1535 đơn hàng*/

--2
select
format_date('%Y-%m', o.created_at) as month_year,
count(distinct o.user_id) as distinct_users,
round(sum(oi.sale_price) / count(distinct oi.order_id), 2) as average_order_value
from bigquery-public-data.thelook_ecommerce.orders o
inner join bigquery-public-data.thelook_ecommerce.order_items oi
on o.order_id = oi.order_id
where o.created_at between timestamp('2019-01-01') and timestamp('2022-04-30')
and o.status not in ('Cancelled', 'Returned')
group by month_year
order by month_year

--3
with youngest_customers as (
select first_name, last_name, gender, age,
'youngest' as tag
from bigquery-public-data.thelook_ecommerce.users
where age is not null
order by age asc)
  
, oldest_customers as (
select first_name, last_name, gender, age, 'oldest' as tag
from bigquery-public-data.thelook_ecommerce.users 
where age is not null
order by age desc)

select tag,
count(*) as customer_count
from
(select * from youngest_customers
union all
select * from oldest_customers)
group by
  tag;

--4
with ranked_products as (
select format_date('%Y-%m', o.created_at) as month_year,
oi.product_id,
p.name as product_name,
sum(oi.sale_price * o.num_of_item) as sales,
sum(p.cost * o.num_of_item) as cost,
sum(oi.sale_price * o.num_of_item) - sum(p.cost * o.num_of_item) as profit,
dense_rank() over (partition by format_date('%Y-%m', o.created_at) order by sum(oi.sale_price * o.num_of_item - p.cost * o.num_of_item) desc) as rank_per_month
from bigquery-public-data.thelook_ecommerce.orders o
inner join bigquery-public-data.thelook_ecommerce.order_items oi
on o.order_id = oi.order_id
inner join bigquery-public-data.thelook_ecommerce.products p
on oi.product_id = p.id
where
o.created_at between timestamp('2019-01-01') and timestamp('2022-04-30')
and o.status not in ('Cancelled', 'Returned')
group by
month_year, oi.product_id, product_name)
select month_year, product_id, product_name, sales, cost, profit, rank_per_month
from ranked_products
where rank_per_month <= 5
limit 5


---5
with revenue_by_category as (
select date_trunc(date(o.created_at), month) as month_start,
p.category as product_category,
sum(oi.sale_price * o.num_of_item) as revenue
from bigquery-public-data.thelook_ecommerce.orders o
inner join bigquery-public-data.thelook_ecommerce.order_items oi
on o.order_id = oi.order_id
inner join bigquery-public-data.thelook_ecommerce.products p
on oi.product_id = p.id
where date(o.created_at) >= date_sub(date '2022-04-15', interval 3 month)
and oi.status not in ('cancelled', 'Returned')
group by month_start, product_category)

select format_date('%Y-%m-%d', month_start) as dates,
product_category,
sum(revenue) as revenue
from revenue_by_category
group by dates, product_category
order by dates, product_category

