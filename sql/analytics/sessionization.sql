SELECT

    end_time,

    LAG(end_time) OVER (ORDER BY end_time) AS previous_end_time,

    end_time -
    LAG(end_time) OVER(ORDER BY end_time) AS time_since_previous_stream

FROM marts.fact_streaming

ORDER BY end_time;


WITH events AS (

    SELECT
    
        end_time,

        LAG(end_time) OVER(ORDER BY end_time) AS previous_end_time

    FROM marts.fact_streaming

)

SELECT

    end_time,
    previous_end_time,

    end_time - previous_end_time AS time_since_previous_stream,

    CASE
        WHEN previous_end_time IS NULL THEN 1
        WHEN end_time - previous_end_time > INTERVAL '30 minutes' THEN 1
        ELSE 0
    END AS new_session_flag

FROM events

ORDER BY end_time;


WITH events AS (

    SELECT

        end_time,

        CASE
            WHEN LAG(end_time) OVER(ORDER BY end_time) IS NULL THEN 1
            WHEN end_tim - LAG(end_time) OVER(ORDER BY end_time) > INTERVAL '30 minutes' THEN 1
            ELSE 0
        END AS new_session_flag

    FROM marts.fact_streaming

)

SELECT

    end_time,
    
    SUM(new_session_flag) OVER(ORDER BY end_time) AS session_id

FROM events

ORDER BY end_time;