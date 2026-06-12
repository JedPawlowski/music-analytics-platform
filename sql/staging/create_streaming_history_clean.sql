DROP TABLE IF EXISTS staging.streaming_history_clean;

CREATE TABLE staging.streaming_history_clean AS

SELECT 
    end_time,

    DATE(end_time) AS play_date,

    EXTRACT(YEAR FROM end_time) AS play_year,
    EXTRACT(MONTH FROM end_time) AS play_month,
    EXTRACT(DAY FROM end_time) AS play_day,
    EXTRACT(HOUR FROM end_time) AS play_hour,

    TRIM(artist_name) AS artist_name,
    TRIM(track_name) AS track_name,

    ms_played,

    ROUND(ms_played / 1000.0, 2) AS seconds_played,
    ROUND(ms_played / 60000.0, 2) AS minutes_played,

    source_file,
    ingestion_ts

FROM raw.streaming_history;
