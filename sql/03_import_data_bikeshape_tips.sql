-- Импортируйте данные из CSV-файла с преобразованием формата start_time
COPY bikeshare_trips(bikeid, checkout_time, duration_minutes, end_station_id, end_station_name, month, start_station_id, start_station_name, start_time, subscriber_type, trip_id, year)
FROM '/var/lib/postgresql/data/dataset/austin_bikeshare_trips.csv'
DELIMITER ','
CSV HEADER;

-- Преобразование формата start_time
UPDATE bikeshare_trips
SET start_time = TO_TIMESTAMP(start_time, 'YYYY-MM-DD HH24:MI:SS');