# Search specifications

## Input formats and normalization

* Hiragana / Katakana
  * Full-width and Half-width characters: Unify all characters to a single form.
    * ｱ == ア
    * A == Ａ
  * Kana Folding:
    * りんご should match リンゴ
  * More intuitive handling of 'n → ん' (convert `n'`, and `n ` to ん)
    * If n can match んい and another kana like に
      * Term match: んい
      * Variant match: に
  * ー should match its vowel equivalent
    * ラーメン could also be found by らあめん
  * Kanji
  * Romaji
    * Romaji should automatically be converted to kana for Japanese term matching
    * Queries should allow mix and match of kana romaji and kanji: 食べru
  * Deconjugation (converting conjugated verbs into their base form for search 食べます→食べる)
    * General:
    * Ambiguous deconjugations (if you have more test cases please let me know)
      * burenai -> bureru, buru
      * いける → 生ける, 行く
  
## General Search

* Match sub matches
  * Exact match: 食べる→食べる
  * At the beginning: 食べ→食べる
  * Sub matches
    * 日→一日中 (not TRUE sub matches, ONLY sub-token matches)
    * eat → to eat
* Wildcard search
  * ‘?‘ - matches one character
  * ‘*‘ - matches zero to many characters
* Fuzzy match (also consider misspellings): りょこ→りょこう
* Filter by languages

## Search Result Sorting

1. Sort by matched query
   1. Exact search term matches
   2. Search term converted to hiragana matches
   3. Any of the preprocessed terms matches
2. Sort by match type
   1. Exact match: 食べる→食べる
   2. Prefix Match: 食べる→食べるラー油
   3. Infix/N-gram Match: 日 → 一日中
   4. Fuzzy Math: りょこ → りょこう
3. Sort by match column
   1. Kanji
   2. Reading
   3. Definition
4. Sort by result frequency
5. Sort by fts5 relevance
6. Sort by length difference of search term and match

## Filtering

* Tag filtering
* Language filtering
* 
