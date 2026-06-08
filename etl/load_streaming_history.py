import json
import pandas as pd
import psycopg2
from pathlib import Path
import hashlib
import os
from dotenv import load_dotenv

load_dotenv()

print("Loading streaming history data into PostgreSQL...")

# PostgreSQL connection
conn = psycopg2.connect(
    host=os.getenv("DB_HOST"),
    database=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    port=os.getenv("DB_PORT")
)

cursor = conn.cursor()

# Load JSON data
file_path = Path("data/raw/StreamingHistory_music_0.json")

with open(file_path, "r", encoding="utf-8") as f:
    data = json.load(f)

rows_inserted = 0

# Insert records
for row in data:
    event_key = hashlib.md5(
        (
            f"{row.get('endTime')}|"
            f"{row.get('artistName')}|"
            f"{row.get('trackName')}|"
            f"{row.get('msPlayed')}"
        ).encode("utf-8")
    ).hexdigest()

    cursor.execute(
        """
        INSERT INTO raw.streaming_history (
            end_time,
            artist_name, 
            track_name, 
            ms_played,
            source_file,
            event_key
        )
        VALUES (%s, %s, %s, %s, %s, %s)

        ON CONFLICT (event_key)
        DO NOTHING
        """,
        (
            row.get("endTime"),
            row.get("artistName"),
            row.get("trackName"),
            row.get("msPlayed"),
            file_path.name,
            event_key
        )
    )

    rows_inserted += cursor.rowcount

conn.commit()

print(f"Inserted {rows_inserted} new rows.")

cursor.close()
conn.close()

print("Done.")