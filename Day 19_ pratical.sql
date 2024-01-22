--- Yêu cầu 1- Chuyển đổi kiểu dữ liệu cho các trường

alter table public.sales_dataset_rfm_prj
alter column ordernumber type int using ordernumber::integer

alter table public.sales_dataset_rfm_prj
alter column quantityordered type int using quantityordered::integer

alter table public.sales_dataset_rfm_prj
alter column priceeach type decimal(10, 2) using priceeach::decimal(10, 2)

alter table public.sales_dataset_rfm_prj
alter column orderlinenumber type int using orderlinenumber::integer
  
alter table public.sales_dataset_rfm_prj
alter column sales type decimal(10, 2) using sales::decimal(10, 2)

alter table public.sales_dataset_rfm_prj
alter column orderdate type date using orderdate::date

--- Yêu cầu 2- Check NULL/BLANK (‘’)  ở các trường: ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE.

select *
from public.sales_dataset_rfm_prj
where
  (ordernumber is null or ordernumber = 0) or
  (quantityordered is null or quantityordered = 0) or
  (orderlinenumber is null or orderlinenumber = 0) or
  (sales is null or sales = 0) OR
  (orderdate is null )

--- Yêu cầu 3- Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ CONTACTFULLNAME/ cập nhật dữ liệu
  
alter table public.sales_dataset_rfm_prj
add column contactlastname varchar,
add column contactfirstname varchar;

update public.sales_dataset_rfm_prj
set 
  contactlastname = initcap(split_part(contactfullname, ' ', 2)),
  contactfirstname = initcap(split_part(contactfullname, ' ', 1))

--- Yêu cầu 4- Thêm cột qtr_id, month_id, year_id và cập nhật dữ liệu
alter table public.sales_dataset_rfm_prj
add column qtr_id int,
add column month_id int,
add column year_id Iint;

update public.sales_dataset_rfm_prj
set 
  qtr_id = extract(quater from orderdate),
  month_id = extract(month from orderdate),
  year_id = extract(year from orderdate)

---Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED và hãy chọn cách xử lý cho bản ghi đó (2 cách)

-- Cách 1 z-score 
with z_scores as 
(select quantityordered,
(quantityordered - avg(quantityordered) over ()) / STDDEV(quantityordered) over () as z_score
from sales_dataset_rfm_prj)
select *
from z_scores
where z_score < -3 or z_score > 3;

update sales_dataset_rfm_prj
set quantityordered = 
case 
    when (quantityordered - subquery.avg_quantity) / subquery.std_dev_quantity < -3 then subquery.avg_quantity - 3 * subquery.std_dev_quantity
    when (quantityordered - subquery.avg_quantity) / subquery.std_dev_quantity > 3 then subquery.avg_quantity + 3 * subquery.std_dev_quantity
    else quantityordered
end
from (
select
    avg(quantityordered) as avg_quantity,
    STDDEV(quantityordered) as std_dev_quantity
from sales_dataset_rfm_prj
) as subquery



--cách 2
with ranked_data as (
  select
    quantityordered,
    percent_rank() over (order by quantityordered) as percent_rank
  from sales_dataset_rfm_prj
),
stats as (
  select
    min(quantityordered) as q1,
    max(quantityordered) as q3
  from ranked_data
  where percent_rank between 0.25 and 0.75
)
delete from sales_dataset_rfm_prj
using stats
where sales_dataset_rfm_prj.quantityordered < stats.q1 - 1.5 * (stats.q3 - stats.q1)
   or sales_dataset_rfm_prj.quantityordered > stats.q3 + 1.5 * (stats.q3 - stats.q1)

--- tao bang moi sales_dataset_rfm_prj_clean

create table sales_dataset_rfm_prj_clean as
select
  case when trim(ordernumber::text) = '' then null else ordernumber::integer 
  end as ordernumber,
  case when trim(quantityordered::text) = '' then null else quantityordered::integer 
  end as quantityordered,
  case when trim(priceeach::text) = '' then null else priceeach::decimal(10, 2) 
  end as priceeach,
  case when trim(orderlinenumber::text) = '' then null else orderlinenumber::integer 
  end as orderlinenumber,
  case when trim(sales::text) = '' then null else sales::decimal(10, 2) 
  end as sales,
  orderdate,
  status,
  productline,
  case when trim(msrp::text) = '' then null else msrp::decimal(10, 2) end as msrp,
  productcode,
  customername,
  phone,
  addressline1,
  addressline2,
  city,
  state,
  postalcode,
  country,
  territory,
  contactfullname,
  dealsize,
  initcap(split_part(contactfullname, ' ', 2)) as contactlastname,
  initcap(split_part(contactfullname, ' ', 1)) as contactfirstname,
  extract(quarter from orderdate) as qtr_id,
  extract(month from orderdate) as month_id,
  extract(year from orderdate) as year_id
from sales_dataset_rfm_prj
where not 
  (trim(coalesce(ordernumber::text, '')) = '' or
  trim(coalesce(quantityordered::text, '')) = '' or
  trim(coalesce(priceeach::text, '')) = '' or
  trim(coalesce(orderlinenumber::text, '')) = '' or
  trim(coalesce(sales::text, '')) = '' or
  orderdate is null or trim(coalesce(orderdate::text, '')) = '')

select * from public.sales_dataset_rfm_prj_clean


