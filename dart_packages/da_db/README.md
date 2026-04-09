# DaKanji-DB

A set of tools to create the database used in DaKanji.
These tools are used for DaKanji v4 and onwards.
For previous verisons see the [legacy database tools](https://github.com/CaptainDario/DaKanji-Dictionary).

## Setup

### Python

For generating schema of the database python >= 3.8 is used.
Run the following commands to setup an environment

``` bash
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt
```

To generate schemas graphviz is required.
Install it like this

* Macos: `brew install graphviz`
* Linux: `?`
* Windows: `?`

## Running

### Official DaKanji dictionary

The official (base dictionary that is shipped with DaKanji) consists of the following data

* Yomitan format
  * [Jitendex](https://github.com/yomidevs/jmdict-yomitan)
    * Base dictionary
  * [JLPT](https://github.com/stephenmk/yomitan-jlpt-vocab)
    * Word level JLPT annotations
  * [JPDB frequency](https://github.com/Kuuuube/yomitan-dictionaries)
    * Word frequencies
  * [KANJIDIC](https://github.com/yomidevs/jmdict-yomitan)
    * Kanji definitions
  * [Kanjium](https://learnjapanese.moe/yomichan/)
    * Pitch accents
* Audio
  * [WaniKanji](https://github.com/tofugu/japanese-vocabulary-pronunciation-audio)
* Examples
  * Tatoeba (based on DaKanji example format)
* Custom parsed
  * Kanji
    * [RADK / KRAD](https://github.com/scriptin/jmdict-simplified)
      * Project contains information about radicals used by kanjis.
    * [KanjiVG](https://kanjivg.tagaini.net/)
      * Project contains detailed stroke order diagrams of many kanji.
    * [Kanji Network](https://github.com/acoomans/kanjinetworks)
      * Database of etymologies for kanjis

The DB can be built by running the below command (it downloads the necessary files at runtime)

``` bash
dart run ./bin/build_da_db.dart
```

## Development

### Testing

For testing the official yomitan test dictionary is included in `samples/`.
It can be tested using the tests in `test/`

### Generating schema

You can generate a schema of the da_db by running

`.venv/bin/eralchemy -i sqlite:///./tmp/dakanji.db -o da_db_schema/schema.pdf`

Make sure that

* the drift code is up to date
* the sqlite file is up to date

### Supported databases

See [the supported formats document.](./schemata/supported_formats.md)