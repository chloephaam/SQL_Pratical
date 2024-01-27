-- 1. Doanh thu theo từng ProductLine, Year  và DealSize?

select
  s.productline as productline,
  extract(year from s.orderdate) as year_id,
  s.dealsize as dealsize,
  sum(s.sales::numeric) as revenue
from
  sales_dataset_rfm_prj_clean s
group by s.productline, extract(year from s.orderdate), s.dealsize
order by s.productline, year_id, s.dealsize

-- 2. Đâu là tháng có bán tốt nhất mỗi năm?

with monthlyrevenue as (
  select
    extract(year from orderdate) as year_id,
    extract(month from orderdate) as month_id,
    sum(sales::numeric) as revenue,
    count(distinct ordernumber) as order_number,
    row_number() over (partition by extract(year from orderdate) order by sum(sales::numeric) desc) as rn
  from
    sales_dataset_rfm_prj_clean
  group by extract(year from orderdate), extract(month from orderdate)
)
select
  year_id,
  month_id,
  revenue,
  order_number
from
  monthlyrevenue
where
  rn = 1

-- 3. Product line nào được bán nhiều ở tháng 11?

with novemberrevenue as (
  select
    productline,
    extract(month from orderdate) as month_id,
    sum(sales::numeric) as revenue,
    count(distinct ordernumber) as order_number,
    row_number() over (partition by extract(month from orderdate) order by sum(sales::numeric) desc) as rn
  from
    sales_dataset_rfm_prj_clean
  where extract(month from orderdate) = 11
  group by productline, extract(month from orderdate)
)
select
  month_id,
  productline,
  revenue,
  order_number
from
  novemberrevenue
where
  rn = 1
  
 -- 4. Đâu là sản phẩm có doanh thu tốt nhất ở UK mỗi năm?
  
with uktopproductperyear as (
  select
    productcode,
    extract(year from orderdate) as year_id,
    sum(sales::numeric) as revenue,
    rank() over (partition by extract(year from orderdate) order by sum(sales::numeric) desc) as ranking
  from
    sales_dataset_rfm_prj_clean
  where country = 'UK'
  group by productcode, extract(year from orderdate)
)
select
  year_id,
  productcode,
  revenue,
  ranking
from
  uktopproductperyear
where
  ranking = 1
  
-- 5. Ai là khách hàng tốt nhất, phân tích dựa vào RFM 
  
with customer_rfm as (
    select a.customer_id,
           current_date - max(order_date) as r,
           count(distinct order_id) as f,
           sum(sales) as m
    from customer as a
           join sales as b on a.customer_id = b.customer_id
    group by a.customer_id
),
rfm_score as (
    select customer_id,
           ntile(5) over (order by r desc) as r_score,
           ntile(5) over (order by f) as f_score,
           ntile(5) over (order by m) as m_score
    from customer_rfm
),
rfm_final as (
    select customer_id,
           cast(r_score as varchar) || cast(f_score as varchar) || cast(m_score as varchar) as rfm_score
    from rfm_score
)
select c.customer_id,
       d.segment,
       c.rfm_score
from rfm_final as c
           join public.segment_score as d on c.rfm_score = d.scores
where d.segment = 'Champions'
order by c.rfm_score



