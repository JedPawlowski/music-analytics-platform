SELECT

    COUNT(DISTINCT session_id) AS total_sessions

FROM marts.session_metrics;


SELECT

    AVG(total_minutes_played) AS avg_session_length

FROM marts.session_metrics;


SELECT *

FROM marts.session_metrics

ORDER BY total_minutes_played DESC
LIMIT 1;


SELECT

    AVG(tracks_played) as avg_tracks_per_session

FROM marts.session_metrics;


SELECT *

FROM marts.session_metrics

ORDER BY total_minutes_played DESC
LIMIT 10;


SELECT *

FROM marts.session_metrics

ORDER BY tracks_played DESC
LIMIT 10;


SELECT

    dd.day_name,
    ROUND(AVG(sm.total_minutes_played), 2) AS avg_session_length

FROM marts.session_metrics sm
LEFT JOIN marts.dim_date dd
    ON DATE(sm.session_start_date) = dd.date_id

WHERE dd.day_type = 'Weekday'

GROUP BY dd.day_name
ORDER BY avg_session_length DESC
LIMIT 1;


SELECT

EXTRACT(HOUR FROM session_start_time) AS session_start_hour,
COUNT(*) AS total_sessions

FROM marts.session_metrics;

GROUP BY session_start_hour
ORDER BY total_sessions DESC
LIMIT 1;

