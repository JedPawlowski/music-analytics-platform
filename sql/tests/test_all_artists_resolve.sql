/*
Test Name: All Artists Resolve

Purpose:
Verify that all artists in the fact table can be resolved to valid artist records.

Expected Result:
0 rows returned

Failure Meaning:
There are records in marts.fact_streaming with artist_id values that do not match any artist_id in marts.dim_artist.
*/

SELECT
    COUNT(*)
FROM marts.fact_streaming fs
LEFT JOIN marts.dim_artist da
    ON fs.artist_id = da.artist_id
WHERE da.artist_id IS NULL;