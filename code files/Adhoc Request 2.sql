/*Business Request - 2: Monthly City-Level Trips Target Performance Report
Generate a report that evaluates the target performance for trips at the monthly and city level. For each city and month, compare the actual total trips with the target trips and categorise the performance as follows:
If actual trips are greater than target trips, mark it as "Above Target".
If actual trips are less than or equal to target trips, mark it as "Below Target".
Additionally, calculate the % difference between actual and target trips to quantify the performance gap.
Fields:
City_name
month_name
actual_trips
target_trips
performance_status
%_difference
*/


WITH actualtrips AS (
  SELECT 
    city_id, 
    monthname(date) AS month_name, 
    COUNT(trip_id) AS actual_trips 
  FROM 
    trips_db.fact_trips 
  GROUP BY 
    city_id, 
    month_name
), 
targettrips AS(
  SELECT 
    city_id, 
    monthname(month) AS month_name, 
    total_target_trips AS target_trips 
  FROM 
    targets_db.monthly_target_trips
) 
SELECT 
  c.city_name, 
  a.month_name, 
  actual_trips, 
  target_trips, 
  CASE WHEN actual_trips > target_trips THEN "Above Target" ELSE "Below Target" END AS performance_status, 
  CONCAT(
    ROUND(
      (actual_trips - target_trips)* 100 / target_trips, 
      2
    ), 
    '%'
  ) AS pct_differnce 
FROM 
  dim_city C 
  JOIN actualtrips a ON c.city_id = a.city_id 
  JOIN targettrips t ON a.city_id = t.city_id 
  and a.month_name = t.month_name;
