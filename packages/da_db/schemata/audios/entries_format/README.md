# Audio Dictionary Format 3: Entries JSON Mapping

This format uses an `entries.json` file consisting of an array of objects. It is ideal for importing structured entry dumps where pronunciation data is nested inside the term's object.

## Archive Structure

Your `.zip` file must contain `yomitan_index.json` (follows the [yomitan schema](../../yomitan_schema/dictionary-index-schema.json)), `entries.json`, and the audio files in the root directory.

```bash
dictionary.zip
├── yomitan_index.json      # Required dictionary metadata
├── entries.json            # Array of dictionary entries
├── audio_001.mp3       
└── audio_002.ogg         
```

## Schema

[Click here for the JSON schema definition.](entries-json-schema.json)
