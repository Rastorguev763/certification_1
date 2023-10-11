SELECT
  start_station_name,
  ROUND(AVG(duration_minutes)::numeric, 2) AS avg_duration_started
FROM bikeshare_trips
WHERE year = 2016
  AND start_station_id IS NOT NULL
GROUP BY start_station_name
ORDER BY avg_duration_started DESC
LIMIT 10;
