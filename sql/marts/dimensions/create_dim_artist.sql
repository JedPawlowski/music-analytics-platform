CREATE TABLE dim_artist AS

SELECT
    ROW_NUMBER() OVER (ORDER BY artist_name) AS artist_id,
    artist_name

FROM (

    SELECT DISTINCT 
        artist_name
    FROM staging.streaming_history_clean
    WHERE artist_name IS NOT NULL

) artists;