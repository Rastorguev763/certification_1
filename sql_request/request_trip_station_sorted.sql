SELECT
  year,
  start_station_id AS station_id,
  COUNT(CASE WHEN start_station_id IS NOT NULL THEN 1 ELSE NULL END) AS trips_started,
  COUNT(CASE WHEN end_station_id IS NOT NULL THEN 1 ELSE NULL END) AS trips_ended,
  COUNT(CASE WHEN start_station_id IS NOT NULL OR end_station_id IS NOT NULL THEN 1 ELSE NULL END) AS total_trips,
  ROUND(AVG(CASE WHEN start_station_id IS NOT NULL THEN duration_minutes ELSE NULL END)::numeric, 2) AS avg_duration_started,
  ROUND(AVG(CASE WHEN end_station_id IS NOT NULL THEN duration_minutes ELSE NULL END)::numeric, 2) AS avg_duration_ended
FROM bikeshare_trips
WHERE year BETWEEN 2013 AND 2017
      AND start_station_id IS NOT NULL  -- Исключение строк с NULL в start_station_id
GROUP BY year, station_id
ORDER BY year, avg_duration_started DESC, station_id;
