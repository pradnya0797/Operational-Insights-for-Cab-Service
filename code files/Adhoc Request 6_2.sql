/*Business Request - 6: Repeat Passenger Rate Analysis
Generate a report that calculates two metrics:
2. City-wide Repeat Passenger Rate: Calculate the overall repeat passenger rate for each city, considering all passengers across months.
These metrics will provide insights into monthly repeat trends as well as the overall repeat behaviour for each city.
Fields:
• city_name
month
total_passengers
repeat_passengers
monthly_repeat_passenger_rate (%): Repeat passenger rate at the city and month level
city_repeat_passenger_rate (%): Overall repeat passenger rate for each city, aggregated across months*/


SELECT 
  city_name, 
  SUM(total_passengers) AS 'total_passengers', 
  SUM(repeat_passengers) AS 'repeat_passengers', 
  CONCAT(
    ROUND(
      SUM(repeat_passengers)* 100 / SUM(total_passengers), 
      2
    ), 
    '%'
  ) as 'city_repeat_passenger_rate' 
FROM 
  fact_passenger_summary p 
  JOIN dim_city c ON c.city_id = p.city_id 
GROUP BY 
  c.city_id;

