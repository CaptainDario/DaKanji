// (input, convertRomajiToHiragana, expectedTerm, expectedHiraganaTerm)
List<(String, bool, String, String?)> preprocessInputTestCases = [
  // --- Hiragana / Katakana ---
  // Katakana to Hiragana
  ("コンピューター", false, "こんぴゅうたあ", null),
  // Half-width Katakana to Hiragana
  ("ｱｲｳｴｵ", false, "あいうえお", null),

  // --- Full-width / Half-width ---
  // Full-width Romaji to Half-width
  ("ＨＥＬＬＯ", false, "HELLO", null),
  // Full-width space
  ("ＨＥＬＬＯ　ＷＯＲＬＤ", false, "HELLO WORLD", null),
  // Full-width lowercase Romaji to Half-width
  ("ｈｅｌｌｏ", false, "hello", null),

  // --- Romaji Conversion ---
  // Romaji-only input, conversion ON. 'term' is unchanged, 'hiraganaTerm' has conversion.
  ("konnichiha", true, "konnichiha", "こんにちは"),
  // Romaji-only input, conversion OFF. 'term' is unchanged, 'hiraganaTerm' is null.
  ("konnichiha", false, "konnichiha", null),
  // 'n' variations: n'
  ("kon'ya", true, "kon'ya", "こんや"),
  // 'n' at the end
  ("ramen", true, "ramen", "らめん"),
  // Long vowel mark
  ("ラーメン", true, "らあめん", null),

  // --- Mixed Input ---
  // Mixed Kanji and Romaji, conversion ON. 'term' keeps romaji, 'hiraganaTerm' has conversion.
  ("食べru", true, "食べru", "食べる"),
  // Mixed Kanji and Romaji, conversion OFF.
  ("食べru", false, "食べru", null),
  // Mixed full-width, katakana, and romaji, conversion ON.
  ("ＨＥRＯコンニチハ", true, "HEROこんにちは", "へろこんにちは"),
  // Romaji that cannot be converted to kana, conversion ON. hiraganaTerm should be null.
  ("hello", true, "hello", null),

  // --- Edge Cases ---
  // Input is already hiragana, conversion ON. No change, so hiraganaTerm is null.
  ("こんにちは", true, "こんにちは", null),
  // Input is already hiragana, conversion OFF.
  ("こんにちは", false, "こんにちは", null),
  // Empty string
  ("", true, "", null),
];