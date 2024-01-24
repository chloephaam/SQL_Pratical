1
SELECT
  FORMAT_DATE('%Y-%m', o.Created_at) AS month_year,
  COUNT(DISTINCT o.user_id) AS total_users,
  COUNT(DISTINCT o.order_id) AS total_orders
FROM bigquery-public-data.thelook_ecommerce.orders o
WHERE o.Created_at BETWEEN TIMESTAMP('2019-01-01') AND TIMESTAMP('2022-04-30')
  AND o.status NOT IN ('Cancelled', 'Returned')
GROUP BY month_year
ORDER BY month_year;
