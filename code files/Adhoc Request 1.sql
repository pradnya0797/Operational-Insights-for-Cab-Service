/* Business Request - 1: City-Level Fare and Trip Summary Report
Generate a report that displays the total trips, average fare per km, average fare per trip, and the percentage contribution of each city's trips to the overall trips. This report will help in assessing trip volume, pricing efficiency, and each city's contribution to the overall trip count.
Fields:
city_name
total_trips
avg_fare_per_km
avg_fare_per_trip
%_contribution_to_total_trips  */


SELECT 
  city_name, 
  COUNT(trip_id) AS total_trips, 
  ROUND(
    (
      SUM(fare_amount)/ SUM(distance_travelled_km)
    ), 
    2
  ) AS avg_fare_km, 
  ROUND(
    (
      SUM(fare_amount)/ COUNT(trip_id)
    ), 
    2
  ) AS avg_fare_trip, 
  CONCAT(
    ROUND(
      (
        COUNT(trip_id) * 100.0
      ) / (
        SELECT 
          COUNT(*) 
        FROM 
          fact_trips
      ), 
      2
    ), 
    '%'
  ) AS pct_contribution_to_total_trips 
FROM 
  dim_city c 
  JOIN fact_trips t ON c.city_id = t.city_id 
GROUP BY 
  c.city_name 
ORDER BY 
  total_trips DESC;
