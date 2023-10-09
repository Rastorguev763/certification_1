COPY bikeshare_stations(latitude, location, longitude, name, station_id, status)
FROM '/var/lib/postgresql/data/dataset/austin_bikeshare_stations.csv'
DELIMITER ','
CSV HEADER;
