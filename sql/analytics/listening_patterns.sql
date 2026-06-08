SELECT

    play_hour,
    COUNT(*) AS total_streams,
    ROUND(SUM(minutes_played), 2) AS total_minutes

FROM marts.fact_streaming

GROUP BY play_hour

ORDER BY total_minutes DESC;


SELECT

    dd.day_name,
    dd.day_type,
    COUNT(*) AS total_streams,
    ROUND(SUM(fs.minutes_played), 2) AS total_minutes

FROM marts.fact_streaming fs

LEFT JOIN marts.dim_date dd
    ON fs.date_id = dd.date_id

GROUP BY dd.weekday_number, dd.day_name, dd.day_type

ORDER BY dd.weekday_number;


SELECT

    dt.artist_name,
    dt.track_name,
    COUNT(*) AS total_streams,
    ROUND(SUM(fs.minutes_played), 2) AS total_minutes

FROM marts.fact_streaming fs

JOIN marts.dim_track dt
    ON fs.track_id = dt.track_id

GROUP BY dt.artist_name, dt.track_name

ORDER BY total_streams DESC;