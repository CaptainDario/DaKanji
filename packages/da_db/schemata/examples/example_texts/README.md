# Example Sentence Format: Plain Text (Monolingual)

This is the simplest way to import bulk example sentences. This format takes standard `.txt` files containing texts.
The system will automatically segment and index the sentences during import.

## Archive Structure

Your `.zip` file must contain `yomitan_index.json` and one or more `.txt` files in the root directory.

``` bash
dictionary.zip
├── yomitan_index.json      # Required dictionary metadata
├── sentences_part1.txt     # Plain text file (UTF-8)
└── sentences_part2.txt     # Optional chunked files
```

## File Formatting

* Files must be plain text (`.txt`) encoded in UTF-8.

**Example `sentences_part1.txt`:**

```text
リンゴを食べます。 彼は毎朝走るのが好きです。
昨日の夜はとても寒かった。
```
