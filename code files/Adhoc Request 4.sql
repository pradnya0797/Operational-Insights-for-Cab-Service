/*Business Request - 4: Identify Cities with Highest and Lowest Total New Passengers
Generate a report that calculates the total new passengers for each city and ranks them based on this value. Identify the top 3 cities with the highest number of new passengers as well as the bottom 3 cities with the lowest number of new passengers, categorising them as "Top 3" or "Bottom 3" accordingly.
Fields
city_name
total_new_passengers
city_category ("Top 3" or "Bottom 3")*/


WITH newpassengers AS (
  SELECT 
    city_name, 
    SUM(new_passengers) AS total_new_passengers 
  FROM 
    dim_city c 
    JOIN fact_passenger_summary p ON c.city_id = p.city_id 
  GROUP BY 
    city_name
), 
rankedcities AS(
  SELECT 
    city_name, 
    total_new_passengers, 
    RANK() OVER (
      ORDER BY 
        total_new_passengers DESC
    ) AS rank_desc, 
    RANK() OVER (
      ORDER BY 
        total_new_passengers ASC
    ) AS rank_asc 
  FROM 
    newpassengers
) 
SELECT 
  city_name, 
  total_new_passengers, 
  CASE WHEN rank_desc <= 3 THEN 'Top 3' WHEN rank_asc <= 3 THEN 'Bottom 3' ELSE NULL END AS city_category 
FROM 
  RankedCities 
WHERE 
  rank_desc <= 3 
  OR rank_asc <= 3 
ORDER BY 
  total_new_passengers DESC, 
  city_category DESC;
