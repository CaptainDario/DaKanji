// (input, convertRomajiToHiragana, expectedHiraganaTerm, expectedTermVariants)
List<(
  String input,
  bool convertRomajiToHiragana,
  List<String> expectedNormalizedTerm, 
  List<String> expectedTermVariants
)> preprocessInputTestCases = [
  // --- Hiragana / Katakana ---
  // Katakana to Hiragana
  ("コンピューター", false, ["こんぴゅうたあ"], []),
  // Half-width Katakana to Hiragana
  ("ｱｲｳｴｵ", false, ["あいうえお"], []),

  // --- Full-width / Half-width ---
  // Full-width Romaji to Half-width
  ("ＨＥＬＬＯ", false, ["HELLO"], []),
  // Full-width space
  ("ＨＥＬＬＯ　ＷＯＲＬＤ", false, ["HELLO WORLD"], []),
  // Full-width lowercase Romaji to Half-width
  ("ｈｅｌｌｏ", false, ["hello"], []),

  // --- Romaji Conversion ---
  // Romaji-only input, conversion ON. 'hiraganaTerm' has two possible conversions.
  ("konnichiha", true, ['こんにちは', 'こんんいちは'], []),
  // Romaji-only input, conversion OFF. 'hiraganaTerm' is [].
  ("konnichiha", false, ['konnichiha'], []),
  // 'n' variations: n'
  ("kon'ya", true, ["こんや"], ['こんう']),
  // 'n' at the end
  ("ramen", true, ["らめん"], ['らめる', 'らむ']),
  // Long vowel mark
  ("ラーメン", true, ["らあめん"], ['らあめる', 'らあむ']),

  // --- Mixed Input ---
  // Mixed Kanji and Romaji + romaji conversion ON. 'hiraganaTerm' is converted.
  ("食べru", true, ["食べる"],  ['食ぶ']),
  // Mixed Kanji and Romaji, conversion OFF.
  ("食べru", false, ["食べru"], []),
  // Mixed full-width, katakana, and romaji, conversion ON.
  ("ＨＥRＯコンニチハ", true, ["へろこんにちは"], []),
  // Mixed full-width, katakana, and romaji, conversion OFF.
  ("ＨＥRＯコンニチハ", false, ["HEROこんにちは"], []),
  // Romaji that cannot be converted to kana, conversion ON. hiraganaTerm should be [].
  ("hello", true, [], []),

  // -- Variants / Deconjugation ---
  // Simple verb
  ("食べます", false, ["食べます"], ['食べむ', '食べる', '食ぶ']),
  // Simple verb from romaji
  ("tabemasu", true, ["たべます"], ['たべむ', 'たべる', 'たぶ']),

  // --- Edge Cases ---
  // Input is already hiragana, conversion ON. No change, so hiraganaTerm is same to input.
  ("こんにちは", true, ["こんにちは"], []),
  // Input is already hiragana, conversion OFF.
  ("こんにちは", false, ["こんにちは"], []),
  // Empty string
  ("", true, [], []),
];