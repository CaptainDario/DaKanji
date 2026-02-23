# Example Sentence Format: JSON Banks

This is the primary format for importing example sentences with metadata. 
It supports chunked JSON files to handle massive datasets without overloading memory, as well as bundled local audio files.

## Archive Structure

Your `.zip` file must contain `yomitan_index.json` (follows the [yomitan schema](../../yomitan_schema/dictionary-index-schema.json)), one or more chunked JSON files named `example_bank_*.json` (e.g., `example_bank_1.json`), and any associated audio files.

You can place audio files in the root directory, group them in a single folder, or nest them infinitely inside subdirectories (e.g., sorting by speaker or quality).

```bash
dictionary.zip
├── yomitan_index.json      # Required dictionary metadata
├── example_bank_1.json     # First chunk of sentences
├── example_bank_2.json     # Second chunk of sentences
└── audio/                  # (Optional) Folder containing audio media
    ├── native/             # Subdirectories are fully supported
    │   └── ringo_taberu.mp3
    └── tts/
        └── kare_hashiru.ogg
```

## Schema

[Click here for the JSON schema definition.](example-bank-schema.json)
