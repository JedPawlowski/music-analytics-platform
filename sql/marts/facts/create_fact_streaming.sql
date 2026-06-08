CREATE TABLE marts.fact_streaming AS

SELECT

    ROW_NUMBER() OVER (ORDER BY sh.end_time) AS streaming_event_id,

    da.artist_id,

    dt.track_id,

    sh.end_time,
    sh.play_date,
    sh.play_year,
    sh.play_month,
    sh.play_day,
    sh.play_hour,
    sh.ms_played,
    sh.seconds_played,
    sh.minutes_played,
    sh.source_file,
    sh.ingestion_ts

FROM staging.streaming_history_clean sh

LEFT JOIN marts.dim_artist da
    ON sh.artist_name = da.artist_name

LEFT JOIN marts.dim_track dt
    ON sh.artist_name = dt.artist_name
    AND sh.track_name = dt.track_name;