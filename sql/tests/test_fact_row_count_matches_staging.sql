SELECT
    (
        SELECT COUNT(*)
        FROM staging.streaming_history_clean
    ) AS staging_count,

    (
        SELECT COUNT(*)
        FROM marts.fact_streaming
    ) AS fact_count;