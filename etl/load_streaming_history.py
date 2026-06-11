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

total_rows_inserted = 0

# Load JSON data
raw_folder = Path("data/raw")

for file_path in raw_folder.glob("StreamingHistory_music_*.json"):

    file_rows_inserted = 0

    print(f"Processing {file_path.name}")

    # Create audit record
    cursor.execute(
        """
        INSERT INTO raw.load_audit (
            file_name,
            load_status
        )
        VALUES (%s, %s)
        RETURNING load_id;
        """,
        (
            file_path.name,
            "RUNNING"
        )
    )

    load_id = cursor.fetchone()[0]

    print(f"Audit record created. load_id={load_id}")

    try:
    
        with open(file_path, "r", encoding="utf-8") as f:
            data = json.load(f)

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
            
            file_rows_inserted += cursor.rowcount
            total_rows_inserted += cursor.rowcount

        # Update audit record
        cursor.execute(
            """
            UPDATE raw.load_audit
            SET 
                load_status = %s,
                rows_inserted = %s
            WHERE load_id = %s
            """,
            (
                "SUCCESS",
                file_rows_inserted,
                load_id
            )
        )
    
    except Exception as e:

        cursor.execute(
            """
            UPDATE raw.load_audit
            SET 
                load_status = %s,
                error_message = %s
            WHERE load_id = %s
            """,
            (
                "FAILED",
                str(e),
                load_id
            )
        )

        conn.commit()

        continue

print(f"Inserted {total_rows_inserted} new rows.")

cursor.close()
conn.close()

print("Done.")