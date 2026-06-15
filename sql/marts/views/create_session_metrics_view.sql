CREATE VIEW marts.session_metrics AS

WITH events AS (

    SELECT

        end_time,
        minutes_played,

        CASE
            WHEN LAG(end_time) OVER(ORDER BY end_time) IS NULL THEN 1
            WHEN end_time - LAG(end_time) OVER(ORDER BY end_time) > INTERVAL '30 minutes' THEN 1
            ELSE 0
        END AS new_session_flag

    FROM marts.fact_streaming
),

sessions AS (

    SELECT

        end_time,
        minutes_played,
        SUM(new_session_flag) OVER(ORDER BY end_time) AS session_id

    FROM events
)


SELECT 

    session_id,

    MIN(end_time) AS session_start_time,
    EXTRACT(HOUR FROM MIN(end_time)) AS session_start_hour,
    MAX(end_time) AS session_end_time,

    COUNT(*) AS tracks_played,

    ROUND(SUM(minutes_played),2) AS total_minutes_played,

FROM sessions

GROUP BY session_id
ORDER BY session_id;