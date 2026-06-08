CREATE TABLE raw.streaming_history (
    end_time TIMESTAMP,
    artist_name TEXT,
    track_name TEXT,
    ms_played INTEGER,
    source_file TEXT,
    ingestion_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);