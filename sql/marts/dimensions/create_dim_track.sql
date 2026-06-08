CREATE TABLE marts.dim_track AS

SELECT
    ROW_NUMBER() OVER (ORDER BY artist_name, track_name) AS track_id,
    artist_name,
    track_name

FROM (
    SELECT DISTINCT 
        artist_name,
        track_name
    FROM staging.streaming_history_clean
    WHERE artist_name IS NOT NULL
      AND track_name IS NOT NULL
) tracks;