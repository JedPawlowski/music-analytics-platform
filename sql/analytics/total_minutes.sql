SELECT

    dd.day_name,
    COUNT(*) AS total_streams,
    ROUND(SUM(fs.minutes_played), 2) AS total_minutes

FROM marts.fact_streaming_v2 fs

LEFT JOIN marts.dim_date dd
    ON fs.date_id = dd.date_id

GROUP BY dd.day_name

ORDER BY total_minutes DESC;