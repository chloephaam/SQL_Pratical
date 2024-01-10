
SELECT
Sum (CASE
  when device_type = 'laptop' then 1 else 0
end) as laptop_views,
Sum (CASE
  when device_type = 'laptop' or device_type = 'tablet' then 1 else 0
end) as 	mobile_views
FROM viewership;
