# Music Analytics Platform

## Overview

A Data Engineering and Analytics project built using Spotify streaming history data.

The platform ingests raw Spotify JSON files, loads them into PostgreSQL using a Python ETL pipeline, transforms the data into a star schema, and exposes analytical views for reporting and dashboarding.

## Tech Stack

* Python
* PostgreSQL (Neon)
* SQL
* DBeaver
* Git & GitHub
* Power BI (planned for Version 2)

## Architecture

![Architecture Diagram](images/architecture.png)

## Features

### Data Ingestion

* Multi-file processing
* Automatic file discovery
* Incremental loading
* Idempotent pipeline
* Hash-based event keys

### Data Modeling

* Raw layer
* Staging layer
* Star schema
* Fact and dimension tables

### Analytics

* Sessionization using SQL window functions
* Session metrics
* Listening behavior analysis

### Observability

* Audit logging
* Success/Failure tracking
* Error message capture
* Per-file processing statistics

## Project Structure

music-analytics-platform/

├── docs/

├── etl/

├── sql/

│   ├── raw/

│   ├── staging/

│   ├── marts/

│   ├── analytics/

│   └── tests/

├── .gitignore

├── README.md

└── LICENSE

## Data Model

![Data Model](images/data_model.png)

## Project Scale

* 43,049 Spotify streaming records
* 5 source JSON files
* 3 warehouse layers
* 1 fact table
* 2 dimension tables
* 7 data quality tests
* Incremental ingestion with audit logging

## Key Learnings

* ETL design
* Incremental data loading
* Data warehouse modeling
* SQL window functions
* Operational metadata
* Pipeline monitoring
* Git workflow
* Environment variable management
