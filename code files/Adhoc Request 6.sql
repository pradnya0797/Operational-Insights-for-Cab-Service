/*Business Request - 6: Repeat Passenger Rate Analysis
Generate a report that calculates two metrics:
1. Monthly Repeat Passenger Rate: Calculate the repeat passenger rate for each city and month by comparing the number of 
repeat passengers to the total passengers.
Fields:
• city_name
month
total_passengers
repeat_passengers
monthly_repeat_passenger_rate (%): Repeat passenger rate at the city and month level
city_repeat_passenger_rate (%): Overall repeat passenger rate for each city, aggregated across months*/


SELECT 
  city_name, 
  monthname(month) AS 'month', 
  total_passengers, 
  repeat_passengers, 
  CONCAT(
    ROUND(
      repeat_passengers * 100 / total_passengers, 
      2
    ), 
    '%'
  ) as monthly_repeat_passenger_rate 
FROM 
  fact_passenger_summary p 
  JOIN dim_city c ON c.city_id = p.city_id 
ORDER BY 
  city_name;
