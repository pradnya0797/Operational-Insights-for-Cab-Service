/*Business Request - 3: City-Level Repeat Passenger Trip Frequency Report
Generate a report that shows the percentage distribution of repeat passengers by the number of trips they have taken in each city.
Calculate the percentage of repeat passengers who took 2 trips, 3 trips, and so on, up to 10 trips.
Each column should represent a trip count category, displaying the percentage of repeat passengers who fall into that category out of the
total repeat passengers for that city.
This report will help identify cities with high repeat trip frequency, which can indicate strong customer loyalty or frequent usage patterns.
Fields: city_name, 2-Trips, 3-Trips, 4-Trips, 5-Trips, 6-Trips, 7-Trips, 8-Trips, 9-Trips, 10-Trips */


WITH tripfrequency AS (
  SELECT 
    city_id, 
    SUM(repeat_passenger_count) AS total_repeat_passenger_count 
  FROM 
    dim_repeat_trip_distribution 
  GROUP BY 
    city_id
) 
SELECT 
  c.city_name, 
  CONCAT(
    ROUND(
      100.0 * SUM(
        CASE WHEN r.trip_count = '2-Trips' THEN repeat_passenger_count ELSE 0 END
      ) / total_repeat_passenger_count, 
      2
    ), 
    '%'
  ) AS "2-Trips", 
  CONCAT(
    ROUND(
      100.0 * SUM(
        CASE WHEN r.trip_count = '3-Trips' THEN repeat_passenger_count ELSE 0 END
      ) / total_repeat_passenger_count, 
      2
    ), 
    '%'
  ) AS "3-Trips", 
  CONCAT(
    ROUND(
      100.0 * SUM(
        CASE WHEN r.trip_count = '4-Trips' THEN repeat_passenger_count ELSE 0 END
      ) / total_repeat_passenger_count, 
      2
    ), 
    '%'
  ) AS "4-Trips", 
  CONCAT(
    ROUND(
      100.0 * SUM(
        CASE WHEN r.trip_count = '5-Trips' THEN repeat_passenger_count ELSE 0 END
      ) / total_repeat_passenger_count, 
      2
    ), 
    '%'
  ) AS "5-Trips", 
  CONCAT(
    ROUND(
      100.0 * SUM(
        CASE WHEN r.trip_count = '6-Trips' THEN repeat_passenger_count ELSE 0 END
      ) / total_repeat_passenger_count, 
      2
    ), 
    '%'
  ) AS "6-Trips", 
  CONCAT(
    ROUND(
      100.0 * SUM(
        CASE WHEN r.trip_count = '7-Trips' THEN repeat_passenger_count ELSE 0 END
      ) / total_repeat_passenger_count, 
      2
    ), 
    '%'
  ) AS "7-Trips", 
  CONCAT(
    ROUND(
      100.0 * SUM(
        CASE WHEN r.trip_count = '8-Trips' THEN repeat_passenger_count ELSE 0 END
      ) / total_repeat_passenger_count, 
      2
    ), 
    '%'
  ) AS "8-Trips", 
  CONCAT(
    ROUND(
      100.0 * SUM(
        CASE WHEN r.trip_count = '9-Trips' THEN repeat_passenger_count ELSE 0 END
      ) / total_repeat_passenger_count, 
      2
    ), 
    '%'
  ) AS "9-Trips", 
  CONCAT(
    ROUND(
      100.0 * SUM(
        CASE WHEN r.trip_count = '10-Trips' THEN repeat_passenger_count ELSE 0 END
      ) / total_repeat_passenger_count, 
      2
    ), 
    '%'
  ) AS "10-Trips" 
FROM 
  dim_repeat_trip_distribution r 
  JOIN tripfrequency t ON r.city_id = t.city_id 
  JOIN dim_city c ON c.city_id = t.city_id 
GROUP BY 
  t.city_id 
ORDER BY 
  t.city_id;
