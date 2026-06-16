DROP TABLE IF EXISTS marts.dim_date;

CREATE TABLE marts.dim_date AS

SELECT DISTINCT
    play_date AS date_id,
    play_date,

    EXTRACT(YEAR FROM play_date) AS year,
    EXTRACT(MONTH FROM play_date) AS month,
    EXTRACT(DAY FROM play_date) AS day,

    TO_CHAR(play_date, "YYYY-MM") AS year_month,
    TO_CHAR(play_date, "Mon YYYY") AS month_year_label,

    EXTRACT(YEAR FROM play_date) * 100 + EXTRACT(MONTH FROM play_date) AS year_month_id,

    TO_CHAR(play_date, "Day") AS weekday_name,
    TO_CHAR(play_date, "Month") AS month_name,

    EXTRACT(DOW FROM play_date) AS weekday_number,

    CASE 
        WHEN EXTRACT(DOW FROM play_date) IN (0,6)
        THEN "Weekend"
        ELSE "Weekday"
    END AS day_type

FROM staging.streaming_history_clean;