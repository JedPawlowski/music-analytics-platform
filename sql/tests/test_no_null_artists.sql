SELECT

    COUNT(*) AS null_artist_count

FROM staging.streaming_history_clean
WHERE artist_name IS NULL;