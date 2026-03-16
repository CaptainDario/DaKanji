# Example Sentence Format: JSON Banks

This is the primary format for importing example sentences with metadata. 
It supports chunked JSON files to handle massive datasets without overloading memory, as well as bundled local audio files.

## Archive Structure

Your `.zip` file must contain an `index.json` file (which follows standard dictionary metadata schemas), one or more chunked JSON files named `example_bank_*.json` (e.g., `example_bank_1.json`), and any associated audio files.

Because tags can have rich metadata (like categories, sorting orders, and notes), this format natively supports **Yomitan Tag Banks**. You should define your tags in `tag_bank_*.json` files.

```bash
dictionary.zip
├── index.json              # Required dictionary metadata
├── tag_bank_1.json         # (Optional) Yomitan-formatted tag definitions
├── example_bank_1.json     # First chunk of sentences
├── example_bank_2.json     # Second chunk of sentences
└── media/                  # (Optional) Folder containing audio media
    ├── native/             # Subdirectories are fully supported
    │   └── apple.mp3
    └── tts/
        └── cat.mp3

## Schema

[Click here for the example_bank_1.json schema definition.](example-bank-schema.json)
[Click here for the tag_bank.json schema definition.](example-bank-schema.json)
