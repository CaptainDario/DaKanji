# Audio Dictionary Format 1: Filename-Based

This format requires no JSON mapping files for the audio. The system parses the term, reading, and pitch accent directly from the audio file's name.

## Archive Structure

Your `.zip` file must contain `yomitan_index.json` (follows the [yomitan schema](../../yomitan_schema/dictionary-index-schema.json)) and the audio files in the root directory (no subfolders).

``` bash
dictionary.zip
├── yomitan_index.json      # Required dictionary metadata
├── 食べる [たべる] (2).mp3   # Term, Reading, and Pitch
├── 走る [はしる].ogg         # Term and Reading only
└── 飲む.mp3                 # Term only
```

## File Naming Convention

The parser uses the following pattern to extract data from the file name (excluding the extension):
`Term [Reading] (Pitch)`

* **Term:** (Required) The base word (e.g., `食べる`).
* **Reading:** (Optional) Enclosed in square brackets `[]` or `【】` (e.g., `[たべる]`).
* **Pitch Accent:** (Optional) Enclosed in parentheses `()` or `（）` (e.g., `(2)`).
