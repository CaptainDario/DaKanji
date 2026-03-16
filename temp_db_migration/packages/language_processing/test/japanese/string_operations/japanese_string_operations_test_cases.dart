
const List<(String, String)> romajiToHiraganaTestCases = [

  ("taberu", "たべる"),
  ("tabemasu", "たべます"),
  ("tabemasen", "たべません"),
  ("tabemasendeshita", "たべませんでした"),
  ("taberundesu", "たべるんです"),
  ("kani", "かに"),
  ("kaNi", "かんい"),
  ("kan'i", "かんい"),
  ("kan i", "かんい"),
  // long vowels
  ('pa-texi-', 'ぱあてぃい'),
  ('paatexii', 'ぱあてぃい'),
  // mixed scripts
  ("飲めru", "飲める"),
  ("のめru", "のめる"),
  ('ぱaてxii', 'ぱあてぃい'),
  ('paーてxiー', 'ぱあてぃい'),
];

final List<(List<String>, List<String>)> extractKanjiTestCases = [
  (
    ['こんにちは世界', '日本語'],
    ['世', '界', '日', '本', '語']
  ),
  (
    ['猫は可愛い', '犬も好き'],
    ['猫', '可', '愛', '犬', '好']
  ),
  (['ひらがな', 'カタカナ'], []),
  (
    ['abc123日本語', 'def456'],
    ['日', '本', '語']
  ),
  ([], []),
  (
    ['重複重複', '漢字漢字'],
    ['重', '複', '漢', '字']
  ),
];

final List<(String, String)> toHalfWidthTestCases = [
  // Full-width alphabet to half-width
  ('ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
  // Full-width numbers to half-width
  ('０１２３４５６７８９', '0123456789'),
  // Full-width space to half-width
  ('　', ' '),
  // Mixed full-width string
  ('ＨＥＬＬＯ　ＷＯＲＬＤ！', 'HELLO WORLD!'),
  // String with no full-width characters
  ('Hello World!', 'Hello World!'),
  // Empty string
  ('', ''),
  // String with Japanese characters (should not be converted)
  ('こんにちは、世界！', 'こんにちは、世界!'),
  // String with mixed Japanese and full-width ASCII
  ('これはＴＥＳＴです。', 'これはTESTです。'),
  // Full-width symbols
  ('！＂＃＄％＆＇（）＊＋，－．／：；＜＝＞？＠［＼］＾＿｀｛｜｝～', '!"#\$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'),
];

final List<(String, String, bool)> katakanaToHiraganaTestCases = [
  ('カタカナ', 'かたかな', false),
  ('コンニチハ', 'こんにちは', false),
  ('サヨウナラ', 'さようなら', false),
  ('アイウエオ', 'あいうえお', false),
  ('カンジ', 'かんじ', false),
  ('パーティー', 'ぱあてぃい', false),
  ('こんぴゅーたー', 'こんぴゅうたあ', false),
  ('ミュージック', 'みゅうじっく', false),
  ('トウキョウ', 'とうきょう', false),
  ('スーパー', 'すうぱあ', false),
  ('バスケットボール', 'ばすけっとぼうる', false),
  // All Katakana
  ('カタカナ', 'かたかな', false),
  // Mixed Katakana and Hiragana
  ('カタカナとひらがな', 'かたかなとひらがな', false),
  // Mixed Katakana and Kanji
  ('日本語とカタカナ', '日本語とかたかな', false),
  // Mixed Katakana and Romaji
  ('カタカナ and Romaji', 'かたかな and Romaji', false),
  // Mixed everything
  ('これはテストです。This is a TEST.', 'これはてすとです。This is a TEST.', false),
  // Empty string
  ('', '', false),
  ('', '', true),
  // Only Hiragana
  ('ひらがな', 'ひらがな', false),
  // Only Kanji
  ('漢字', '漢字', false),
  // Only Romaji
  ('romaji', 'romaji', false),
  ('romaji', 'ろまじ', true),
  // With punctuation
  ('コンニチハ、セカイ！', 'こんにちは、せかい！', false),
  // Small Katakana characters
  ('ァィゥェォッャュョヮ', 'ぁぃぅぇぉっゃゅょゎ', false),
  // Voiced and semi-voiced Katakana
  ('ガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポ', 'がぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽ', false),
  // String with numbers and symbols
  ('テスト123！＠＃', 'てすと123！＠＃', false),
  // Long vowel marks
  ('スーパー', 'すうぱあ', false),
  // Kanji and romaji WITHOUT kana
  ('日本語 and romaji', '日本語 and romaji', false),
  ('食beru', '食beru', false),
  ('食beru', '食べる', true),
];