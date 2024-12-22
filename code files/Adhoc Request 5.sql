/*Business Request - 5: Identify Month with Highest Revenue for Each City
Generate a report that identifies the month with the highest revenue for each city. For each city, 
display the month_name, the revenue amount for that month, and the percentage contribution of that
month's revenue to the city's total revenue.
Fields
city_name
highest_revenue_month
revenue
percentage_contribution (%) */


with cte as (
  SELECT 
    city_id, 
    monthname(date) as month_name, 
    sum(fare_amount) as revenue, 
    dense_rank() over(
      partition by city_id 
      order by 
        sum(fare_amount) desc
    ) as rnk 
  FROM 
    fact_trips 
  group by 
    city_id, 
    month_name
), 
rev as (
  SELECT 
    city_id, 
    sum(fare_amount) as total_revenue 
  FROM 
    fact_trips 
  group by 
    city_id
), 
total as (
  select 
    c.city_id, 
    month_name as highest_revenue_month, 
    revenue, 
    total_revenue 
  from 
    cte c 
    join rev r on c.city_id = r.city_id 
  where 
    rnk = 1
) 
select 
  city_name, 
  highest_revenue_month, 
  revenue, 
  CONCAT(
    ROUND(100 * revenue / total_revenue, 2), 
    '%'
  ) as pct_contribution 
from 
  total t 
  join dim_city d ON t.city_id = d.city_id 
ORDER BY 
  revenue DESC;
