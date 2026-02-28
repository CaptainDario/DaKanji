# Example Sentence Format: Plain Text (Monolingual)

This is the simplest way to import bulk example sentences. This format takes standard `.txt` files containing texts.
The system will automatically segment and index the sentences during import.

## Archive Structure

Your `.zip` file must contain `yomitan_index.json` and one or more `.txt` files in the root directory.
Optionally, metadata can be supplied.

``` bash
dictionary.zip
├── index.json.                   # Required dictionary metadata
├── example_text_bank_1.txt       # Plain text file 1 (UTF-8)
├── example_text-metadata_1.json  # (Optional) metadata that is applied to all extracted sentences from bank-1
├── example_text_bank_2.txt       # Next Plain text file (UTF-8)
└── example_text_metadata_2.json  # (Optional) metadata that is applied to all extracted sentences from bank-2
```

## File Formatting

## Schema

[Click here for the JSON schema definition.](example-bank-schema.json)
