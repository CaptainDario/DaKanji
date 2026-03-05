/// Test cases for the mora counting logic
final List<({String reading, List<String> expected})> moraTestCases = [
  // Standard kana
  (reading: 'わたし', expected: ['わ', 'た', 'し']),
  (reading: 'にほんご', expected: ['に', 'ほ', 'ん', 'ご']),
  
  // Yōon (small combining kana)
  (reading: 'きゃく', expected: ['きゃ', 'く']),
  (reading: 'しょうがっこう', expected: ['しょ', 'う', 'が', 'っ', 'こ', 'う']),
  (reading: 'きょう', expected: ['きょ', 'う']),
  (reading: 'ちぇ', expected: ['ちぇ']),
  
  // Sokuon (small tsu - counts as its own mora)
  (reading: 'がっき', expected: ['が', 'っ', 'き']),
  
  // Single mora edge cases
  (reading: 'き', expected: ['き']),
  (reading: 'しゃ', expected: ['しゃ']),
];

/// Test cases for the H/L pitch pattern generation logic
final List<({String reading, int position, String expected})> patternTestCases = [
  // ------------------------------------------------------------------
  // Heiban (平板) - position 0
  // Starts Low, goes High, stays High
  // ------------------------------------------------------------------
  (reading: 'わたし', position: 0, expected: 'LHH'), // 3 morae
  (reading: 'がっこう', position: 0, expected: 'LHHH'), // 4 morae
  (reading: 'きょう', position: 0, expected: 'LH'), // 2 morae ('きょ' is 1 mora)

  // ------------------------------------------------------------------
  // Atamadaka (頭高) - position 1
  // Starts High, drops immediately to Low, stays Low
  // ------------------------------------------------------------------
  (reading: 'ねこ', position: 1, expected: 'HL'), // 2 morae
  (reading: 'いのち', position: 1, expected: 'HLL'), // 3 morae
  (reading: 'きょうりゅう', position: 1, expected: 'HLLL'), // 4 morae

  // ------------------------------------------------------------------
  // Nakadaka (中高) - 1 < position < length
  // Starts Low, goes High until downstep, drops to Low
  // ------------------------------------------------------------------
  (reading: 'あなた', position: 2, expected: 'LHL'), // 3 morae, drops after 2nd
  (reading: 'としょかん', position: 2, expected: 'LHLL'), // 4 morae, drops after 2nd
  (reading: 'おんがく', position: 3, expected: 'LHHL'), // 4 morae, drops after 3rd
  (reading: 'しょうがっこう', position: 3, expected: 'LHHLLL'), // 6 morae, drops after 3rd

  // ------------------------------------------------------------------
  // Odaka (尾高) - position == length
  // Starts Low, goes High, stays High until the end (drops on the particle)
  // Note: The string length equals the mora length; the drop is implied after.
  // ------------------------------------------------------------------
  (reading: 'いもうと', position: 4, expected: 'LHHH'), // 4 morae
  (reading: 'おとこ', position: 3, expected: 'LHH'), // 3 morae
  
  // Edge case: 1-mora word Odaka (Starts High, drops on particle)
  (reading: 'き', position: 1, expected: 'H'), // 1 mora
  (reading: 'しゃ', position: 1, expected: 'H'), // 1 mora (yōon)
];