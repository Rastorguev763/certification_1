CREATE TABLE bikeshare_trips (
    bikeid DOUBLE PRECISION,
    checkout_time TIME,
    duration_minutes INTEGER,
    end_station_id DOUBLE PRECISION,
    end_station_name TEXT,
    month DOUBLE PRECISION,
    start_station_id DOUBLE PRECISION,
    start_station_name TEXT,
    start_time timestamp,
    subscriber_type TEXT,
    trip_id DOUBLE PRECISION,
    year DOUBLE PRECISION
);