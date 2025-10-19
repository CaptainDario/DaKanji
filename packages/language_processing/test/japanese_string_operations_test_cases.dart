
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

final List<(String, String)> katakanaToHiraganaTestCases = [
  ('カタカナ', 'かたかな'),
  ('コンニチハ', 'こんにちは'),
  ('サヨウナラ', 'さようなら'),
  ('アイウエオ', 'あいうえお'),
  ('カンジ', 'かんじ'),
  ('パーティー', 'ぱあてぃい'),
  ('こんぴゅーたー', 'こんぴゅうたあ'),
  ('ミュージック', 'みゅうじっく'),
  ('トウキョウ', 'とうきょう'),
  ('スーパー', 'すうぱあ'),
  ('バスケットボール', 'ばすけっとぼうる'),
  // All Katakana
  ('カタカナ', 'かたかな'),
  // Mixed Katakana and Hiragana
  ('カタカナとひらがな', 'かたかなとひらがな'),
  // Mixed Katakana and Kanji
  ('日本語とカタカナ', '日本語とかたかな'),
  // Mixed Katakana and Romaji
  ('カタカナ and Romaji', 'かたかな and Romaji'),
  // Mixed everything
  ('これはテストです。This is a TEST.', 'これはてすとです。This is a TEST.'),
  // Empty string
  ('', ''),
  // Only Hiragana
  ('ひらがな', 'ひらがな'),
  // Only Kanji
  ('漢字', '漢字'),
  // Only Romaji
  ('romaji', 'romaji'),
  // With punctuation
  ('コンニチハ、セカイ！', 'こんにちは、せかい！'),
  // Small Katakana characters
  ('ァィゥェォッャュョヮ', 'ぁぃぅぇぉっゃゅょゎ'),
  // Voiced and semi-voiced Katakana
  ('ガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポ', 'がぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽ'),
  // String with numbers and symbols
  ('テスト123！＠＃', 'てすと123！＠＃'),
];