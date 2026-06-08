SELECT
    (SELECT COUNT(*) FROM staging.streaming_history_clean) AS staging_rows,
    (SELECT COUNT(*) FROM marts.fact_streaming) AS fact_rows;


SELECT
    COUNT(*) AS missing_artist_ids
FROM marts.fact_streaming
WHERE artist_id IS NULL;


SELECT
    COUNT(*) AS missing_track_ids
FROM marts.fact_streaming
WHERE track_id IS NULL;


SELECT
    artist_name,
    COUNT(*) AS artists_count
FROM marts.dim_artist
GROUP BY artist_name
HAVING COUNT(*) > 1;


SELECT
    artist_name,
    track_name,
    COUNT(*) AS tracks_count
FROM marts.dim_track
GROUP BY artist_name, track_name
HAVING COUNT(*) > 1;