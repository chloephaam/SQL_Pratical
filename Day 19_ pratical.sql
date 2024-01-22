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

--- Yêu cầu 3- Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ CONTACTFULLNAME . 
