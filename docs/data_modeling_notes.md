# Entities

- Track
- Artist
- Listening Event
- End Time
- Time Played

# Relationships

- One artist has many tracks
- One album has many tracks
- One listening event references one track
- One listening event occurs at one timestamp

# Expected Grain

One row in listening history represents:
One track play event ending at a specific timestamp.