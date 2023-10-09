CREATE TABLE bikeshare_stations (
    latitude NUMERIC(9, 5),
    location POINT,
    longitude NUMERIC(9, 5),
    name VARCHAR(255),
    station_id INTEGER PRIMARY KEY,
    status VARCHAR(50)
);
