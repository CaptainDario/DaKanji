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
* Linux:
* Windows:

## Running

### Official DaKanji dictionary

The official (base dictionary that is shipped with DaKanji) consists of the following dictionaries

* Yomitan format
  * Jitendex
    * Base dictionary
  * [JLPT](https://github.com/stephenmk/yomitan-jlpt-vocab)
    * Word level JLPT annotations
  * JPDB frquency
    * Word frequencies
  * KANJIDIC
    * Kanji definitions
* Custom parsed
  * Kanji
    * [RADK](https://github.com/scriptin/jmdict-simplified)
      * Project contains information about radicals used by kanjis.
    * [KRAD](https://github.com/scriptin/jmdict-simplified)
      * Project contains information about radicals used by kanjis.
    * [KanjiVG](https://kanjivg.tagaini.net/)
      * Project contains detailed stroke order diagrams of many kanji.
    * [Kanjium](https://github.com/mifunetoshiro/kanjium)
      * Pitch accents
      * Antonyms
      * Synonyms
      * Kanjidict
  * Audio
    * [Yomitan Audio](https://github.com/yomidevs/local-audio-yomichan)
  * Examples
    * Tatoeba (based on DaKanji example format)

To build DaKanji DB first download each of the aforementioned databaes and place them in `./input_files`

Now the DB can be build by running

``` bash
dart run ./bin/build_dakanji_db.dart
```

## Development

### Testing

For testing the official yomitan test dictionary is included in `samples/`.
It can be tested using the tests in `test/`

#### Stress testing

The scripts in `ADD PATH HERE` are used to test the performance of the database creation and queries.

### Generating schema

You can generate a schema of the dakanji_db by running

`.venv/bin/eralchemy -i sqlite:///./tmp/dakanji.db -o dakanji_db_schema/schema.pdf`

Make sure that

* the drift code is up to date
* the sqlite file is up to date

### Supported databases

The main idea of this rewrite is to allow users to import their own yomitan json dictionaries.
Additionally, some other databases are included in DaKanji

#### Yomitan json schema

* [custom-audio-list-schema.json](yomitan_schema/custom-audio-list-schema.json) - ❌
  * Meaning: ?
  * File name pattern: `?`
  * [Inspector](https://json-schema-viewer.vercel.app/view?url=https%3A%2F%2Fraw.githubusercontent.com%2Fyomidevs%2Fyomitan%2Frefs%2Fheads%2Fmaster%2Fext%2Fdata%2Fschemas%2Fcustom-audio-list-schema.json&description_is_markdown=on&expand_buttons=on&show_breadcrumbs=on&with_footer=on&template_name=js)
* [dictionary-index-schema.json](yomitan_schema/dictionary-index-schema.json) - ✅
  * Meaning: Metadata about the dictionary. Please include as much detail as possible.
  * File name pattern: `index.json`
  * [Inspector](https://json-schema-viewer.vercel.app/view?url=https%3A%2F%2Fraw.githubusercontent.com%2Fyomidevs%2Fyomitan%2Frefs%2Fheads%2Fmaster%2Fext%2Fdata%2Fschemas%2Fdictionary-index-schema.json&description_is_markdown=on&expand_buttons=on&show_breadcrumbs=on&with_footer=on&template_name=js)
* [dictionary-kanji-bank-v3-schema.json](yomitan_schema/dictionary-kanji-bank-v3-schema.json) - ✅
  * Meaning: Information used in the kanji viewer - meanings, readings, statistics, and codepoints.
  * File name pattern: `kanji_bank_${number}.json`
  * [Inspector](https://json-schema-viewer.vercel.app/view?url=https%3A%2F%2Fraw.githubusercontent.com%2Fyomidevs%2Fyomitan%2Frefs%2Fheads%2Fmaster%2Fext%2Fdata%2Fschemas%2Fdictionary-kanji-bank-v3-schema.json&description_is_markdown=on&expand_buttons=on&show_breadcrumbs=on&with_footer=on&template_name=js)
* [dictionary-kanji-meta-bank-v3-schema.json](yomitan_schema/dictionary-kanji-meta-bank-v3-schema.json) - ✅
  * Meaning: Stores kanji frequency data.
  * File name pattern: `kanji_meta-bank_${number}.json`
  * [Inspector](https://json-schema-viewer.vercel.app/view?url=https%3A%2F%2Fraw.githubusercontent.com%2Fyomidevs%2Fyomitan%2Frefs%2Fheads%2Fmaster%2Fext%2Fdata%2Fschemas%2Fdictionary-kanji-meta-bank-v3-schema.json&description_is_markdown=on&expand_buttons=on&show_breadcrumbs=on&with_footer=on&template_name=js)
* [dictionary-tag-bank-v3-schema.json](yomitan_schema/dictionary-tag-bank-v3-schema.json) - ✅
  * Meaning: Defines tags for kanji and term dictionaries, like parts of speech or kanken level.
  * File name pattern: `tag_bank_${number}.json`
  * [Inspector](https://json-schema-viewer.vercel.app/view?url=https%3A%2F%2Fraw.githubusercontent.com%2Fyomidevs%2Fyomitan%2Frefs%2Fheads%2Fmaster%2Fext%2Fdata%2Fschemas%2Fdictionary-tag-bank-v3-schema.json&description_is_markdown=on&expand_buttons=on&show_breadcrumbs=on&with_footer=on&template_name=js)
* [dictionary-term-bank-v3-schema.json](yomitan_schema/dictionary-term-bank-v3-schema.json) - ❌
  * Meaning: Stores dictionary readings, definitions, etc.
  * File name pattern: `term_bank_${number}.json`
  * [Inspector](https://json-schema-viewer.vercel.app/view?url=https%3A%2F%2Fraw.githubusercontent.com%2Fyomidevs%2Fyomitan%2Frefs%2Fheads%2Fmaster%2Fext%2Fdata%2Fschemas%2Fdictionary-term-bank-v3-schema.json&description_is_markdown=on&expand_buttons=on&show_breadcrumbs=on&with_footer=on&template_name=js#items_items_i5_items_oneOf_i0)
* [dictionary-term-meta-bank-v3-schema.json](yomitan_schema/dictionary-term-meta-bank-v3-schema.json) - ✅
  * Meaning: Stores meta information about terms, such as frequency data and pitch accent data.
  * File name pattern: `term_meta_bank_${number}.json`
  * [Inspector](https://json-schema-viewer.vercel.app/view?url=https%3A%2F%2Fraw.githubusercontent.com%2Fyomidevs%2Fyomitan%2Frefs%2Fheads%2Fmaster%2Fext%2Fdata%2Fschemas%2Fdictionary-term-meta-bank-v3-schema.json&description_is_markdown=on&expand_buttons=on&show_breadcrumbs=on&with_footer=on&template_name=js)

#### Example sentences

DaKanji also allows users to import their own example sentence databases.
For this two different types are importable.

##### Japanese with translation

For this type of example sentences any text file that is structured like the following example can be imported

```
iso8306 language code

```

an example can be found in []()

##### Japanese only

test