# Search specifications

## Input formats and normalization

* Hiragana / Katakana
  * Full-width and Half-width characters: Unify all characters to a single form. 
    * ｱ == ア
    * A == Ａ
  * Kana Folding:
    * りんご should match リンゴ
  * More intuitive handling of 'n → ん' (convert `n'`, and `n ` to ん)
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
    * I am considering removing sub matches for japanese (is this a necessary feature?): 日→一日中
    * eat -> to eat
* Wildcard search
  * ‘?‘ - matches one character
  * ‘*‘ - matches zero to many characters
* Fuzzy match (also consider misspellings): りょこ→りょこう

## Search Result Sorting

1. Sort by match type
   1. Exact match: 食べる→食べる
   2. Normalized exact match: 食べます→食べる
   3. Prefix Match: 食べる→食べるラー油
   4. Infix/N-gram Match: 日中 → 一日中
   5. Fuzzy Math: りょこ → りょこう
2. Sort by match column
   1. Kanji
   2. Reading
   3. Definition
3. Sort by fts5 relevance
4. Sort by result frequency
