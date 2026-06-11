CREATE TABLE raw.load_audit (

    load_id SERIAL PRIMARY KEY,
    
    file_name VARCHAR(255) NOT NULL,

    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    rows_inserted INTEGER,

    load_status VARCHAR(20) NOT NULL,

    error_message TEXT

);