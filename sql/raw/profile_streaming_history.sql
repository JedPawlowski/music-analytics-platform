SELECT COUNT(*) AS total_rows
FROM raw.streaming_history;

SELECT MIN(end_time) AS first_play,
       MAX(end_time) AS last_play
FROM raw.streaming_history;

SELECT COUNT(*) FILTER (WHERE end_time IS NULL) AS null_end_time,
       COUNT(*) FILTER (WHERE artist_name IS NULL) AS null_artist,
       COUNT(*) FILTER (WHERE track_name IS NULL) AS null_track,
       COUNT(*) FILTER (WHERE ms_played IS NULL) AS null_ms_played
FROM raw.streaming_history;

SELECT artist_name,
        COUNT(*) AS play_count
FROM raw.streaming_history
GROUP BY artist_name
ORDER BY play_count DESC
LIMIT 10;

SELECT MIN(ms_played) AS min_ms,
       MAX(ms_played) AS max_ms,
       AVG(ms_played) AS avg_ms
FROM raw.streaming_history; 

SELECT end_time,
         artist_name,
         track_name,
         COUNT(*) AS duplicate_count
FROM raw.streaming_history
GROUP BY end_time, artist_name, track_name
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

         