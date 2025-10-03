// (input, convertRomajiToHiragana, expectedHiraganaTerm, expectedTermVariants)
List<(String, bool, String?, String?)> preprocessInputTestCases = [
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
  ("konnichiha", true, "こんにちは", null),
  // Romaji-only input, conversion OFF. 'term' is unchanged, 'hiraganaTerm' is null.
  ("konnichiha", false, null, null),
  // 'n' variations: n'
  ("kon'ya", true, "こんや", null),
  // 'n' at the end
  ("ramen", true, "らめん", null),
  // Long vowel mark
  ("ラーメン", true, "らあめん", null),

  // --- Mixed Input ---
  // Mixed Kanji and Romaji, conversion ON. 'term' keeps romaji, 'hiraganaTerm' has conversion.
  ("食べru", true, "食べる", null),
  // Mixed Kanji and Romaji, conversion OFF.
  ("食べru", false, null, null),
  // Mixed full-width, katakana, and romaji, conversion ON.
  ("ＨＥRＯコンニチハ", true, "へろこんにちは", null),
  // Mixed full-width, katakana, and romaji, conversion OFF.
  ("ＨＥRＯコンニチハ", false, "HEROこんにちは", null),
  // Romaji that cannot be converted to kana, conversion ON. hiraganaTerm should be null.
  ("hello", true, null, null),

  // -- Variants / Deconjugation ---
  // Simple verb
  ("食べます", false, null, "食べる"),
  // Simple verb from romaji
  ("tabemasu", true, "たべます", "食べる"),

  // --- Edge Cases ---
  // Input is already hiragana, conversion ON. No change, so hiraganaTerm is null.
  ("こんにちは", true, null, null),
  // Input is already hiragana, conversion OFF.
  ("こんにちは", false, null, null),
  // Empty string
  ("", true, null, null),
];