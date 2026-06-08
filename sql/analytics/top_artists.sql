SELECT
da.artist_name,
COUNT(*) AS total_streams,
ROUND(SUM(fs.ms_played), 2) AS total_ms_played

FROM marts.fact_streaming fs

JOIN marts.dim_artist da
    ON fs.artist_id = da.artist_id
GROUP BY da.artist_name
ORDER BY total_ms_played DESC
LIMIT 10;