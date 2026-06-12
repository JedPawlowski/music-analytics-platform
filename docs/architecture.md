# Architecture Diagram

Spotify Streaming History Files
│
▼
Python ETL Pipeline
│
▼
raw.streaming_history
│
▼
staging.streaming_history_clean
│
▼
marts.fact_streaming
│
▼           
marts.dim_artist  marts.dim_track
│
▼
analytics.session_metrics
│
▼
Power BI

Operational Metadata

Python ETL Pipeline
│
▼
raw.load_audit
