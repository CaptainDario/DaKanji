# Audio Dictionary Format 2: Index JSON Mapping

This format uses an `index.json` file to map headwords to their respective audio files, allowing multiple words to share the same audio recording.

## Archive Structure
Your `.zip` file must contain `yomitan_index.json` (follows the [yomitan schema](../../yomitan_schema/dictionary-index-schema.json)), `index.json`, and the audio files.

``` bash
dictionary.zip
├── yomitan_index.json      # Required dictionary metadata
├── index.json              # Audio mapping data
├── taberu_native.mp3       
└── hashiru_kan.ogg         
```

## Schema

[Click here for the JSON schema definition.](index-json-schema.json)
