ALTER TABLE raw.streaming_history
ADD COLUMN event_key TEXT;

UPDATE raw.streaming_history
SET event_key = 
    MD5(
        COALESCE(end_time::TEXT, '') 
        || '|'
        || COALESCE(artist_name, '')
        || '|'
        || COALESCE(track_name, '')
        || '|'
        || COALESCE(ms_played::TEXT, '')
    );

ALTER TABLE raw.streaming_history
ADD CONSTRAINT uq_streaming_history_event_key
UNIQUE (event_key);