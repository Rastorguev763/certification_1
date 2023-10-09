CREATE TABLE bikeshare_trips (
    bikeid INTEGER,
    checkout_time TIME,
    duration_minutes INTEGER,
    end_station_id INTEGER,
    end_station_name VARCHAR(255),
    month INTEGER,
    start_station_id INTEGER,
    start_station_name VARCHAR(255),
    start_time TIMESTAMP,
    subscriber_type VARCHAR(255),
    trip_id INTEGER,
    year INTEGER
);
