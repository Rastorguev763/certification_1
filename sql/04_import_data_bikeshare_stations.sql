COPY bikeshare_stations(latitude, location, longitude, name, station_id, status)
FROM '/var/lib/postgresql/data_files/dataset/austin_bikeshare_stations.csv'
DELIMITER ','
CSV HEADER;

-- UPDATE bikeshare_stations
-- SET location = REPLACE(REPLACE(location, '(', ''), ')', '');

