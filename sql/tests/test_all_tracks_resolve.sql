SELECT
    COUNT(*)
FROM marts.fact_streaming fs
LEFT JOIN marts.dim_tracks dt
    ON fs.track_id = dt.track_id
WHERE dt.track_id IS NULL;