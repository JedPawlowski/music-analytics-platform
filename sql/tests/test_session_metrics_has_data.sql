/*
Test Name: Session Metrics Has Data

Purpose:
Verify that the session metrics table contains data.

Expected Result:
A row count greater than 0.

Failure Meaning:
The session metrics table is empty.
*/

SELECT
    COUNT(*)
FROM marts.session_metrics;