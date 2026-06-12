SELECT

    COUNT(*) AS null_tracks_count

FROM staging.streaming_history_clean
WHERE track_name IS NULL;