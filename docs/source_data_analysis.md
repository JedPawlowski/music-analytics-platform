# Source Data Analysis

## File Inventory

| File Name | Format | Description |
|---|---|---|
| StreamingHistory_music_0.json | JSON | Listening history events |
| StreamingHistory_music_1.json | JSON | Listening history events |
| StreamingHistory_music_2.json | JSON | Listening history events |
| StreamingHistory_music_3.json | JSON | Listening history events |
| StreamingHistory_music_4.json | JSON | Listening history events |

---

## Initial Observations

### StreamingHistory_music.json files

- Contain listening events
- One row likely represents one track play event
- Include timestamps
- Include artist and track names
- Likely event-grain data

---

## Suspected Grain

One row = one listening event for one track at one timestamp.

---

## Potential Issues

- Missing values
- Duplicate plays
- Timezone handling
- Track renaming over time