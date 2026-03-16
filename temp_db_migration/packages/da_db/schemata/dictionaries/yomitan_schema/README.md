# Yomitan Format

Yomitan dictionaries can be diretly imported into the db.
You can read more [about the format it on the yomitan website](https://github.com/yomidevs/yomitan/blob/master/docs/making-yomitan-dictionaries.md).

## Schema

* [custom-audio-list-schema.json](custom-audio-list-schema.json)
  * Meaning: List of URLs from which audios can be fetched
  * File name pattern: `audio-list.json`
* [dictionary-index-schema.json](dictionary-index-schema.json)
  * Meaning: Metadata about the dictionary. Please include as much detail as possible.
  * File name pattern: `index.json`
* [dictionary-kanji-bank-v3-schema.json](dictionary-kanji-bank-v3-schema.json)
  * Meaning: Information used in the kanji viewer - meanings, readings, statistics, and codepoints.
  * File name pattern: `kanji_bank_${number}.json`
* [dictionary-kanji-meta-bank-v3-schema.json](dictionary-kanji-meta-bank-v3-schema.json)
  * Meaning: Stores kanji frequency data.
  * File name pattern: `kanji_meta-bank_${number}.json`
* [dictionary-tag-bank-v3-schema.json](dictionary-tag-bank-v3-schema.json)
  * Meaning: Defines tags for kanji and term dictionaries, like parts of speech or kanken level.
  * File name pattern: `tag_bank_${number}.json`
* [dictionary-term-bank-v3-schema.json](dictionary-term-bank-v3-schema.json)
  * Meaning: Stores dictionary readings, definitions, etc.
  * File name pattern: `term_bank_${number}.json`
* [dictionary-term-meta-bank-v3-schema.json](dictionary-term-meta-bank-v3-schema.json)
  * Meaning: Stores meta information about terms, such as frequency data and pitch accent data.
  * File name pattern: `term_meta_bank_${number}.json`
