/// Defines high-level test cases for the [processText] function.
/// 
/// These tests evaluate the handling of full sentences, paragraphs, mixed 
/// character sets (Kanji, Kana, Romaji), and whitespace/newline preservation.
final List<Map<String, dynamic>> processTextTestCases = [
  {
    'description': 'Parses a standard full sentence correctly',
    'input': '私は学校に行きます。',
    'expectedSegments': <String>['私', 'は', '学校', 'に', '行きます', '。'],
    'expectedTokens': <String>['私', 'は', '学校', 'に', '行くます', '。'], 
    // UniDic outputs 'ワタクシ' for 私 and 'ガッコー' for 学校.
    // Pure kana ('は', 'に') and punctuation yield spaces/empty strings.
    'expectedReadings': <String>['ワタクシ', ' ', 'ガッコー', ' ', 'イキマス', ''],
    'expectedPosLengths': 6, 
  },
  {
    'description': 'Preserves multi-line formatting and blank lines',
    'input': '猫\n\n犬', // Swapped from 一番/二番 to avoid UniDic's number/counter splitting
    'expectedSegments': <String>['猫', '\n', '\n', '犬'],
    'expectedTokens': <String>['猫', '\n', '\n', '犬'],
    'expectedReadings': <String>['ネコ', '', '', 'イヌ'],
    'expectedPosLengths': 4,
  },
  {
    'description': 'Handles mixed Japanese and English text',
    'input': 'Flutterでアプリを作る',
    'expectedSegments': <String>['Flutter', 'で', 'アプリ', 'を', '作る'],
    'expectedTokens': <String>['Flutter', 'で', 'アプリ', 'を', '作る'],
    // English words and pure Kana words ('で', 'アプリ', 'を') correctly yield spaces
    // to prevent redundant furigana rendering in the UI.
    'expectedReadings': <String>[' ', ' ', ' ', ' ', 'ツクル'],
    'expectedPosLengths': 5,
  },
  {
    'description': 'Handles empty and pure whitespace strings safely',
    'input': '   \n  ',
    'expectedSegments': <String>['   \n  '],
    'expectedTokens': <String>['   \n  '],
    'expectedReadings': <String>[' '],
    'expectedPosLengths': 1,
  },
  {
    'description': 'Groups verb + polite + past tense (食べました)',
    'input': 'ケーキを食べました。',
    'expectedSegments': <String>['ケーキ', 'を', '食べました', '。'],
    // Combined orthBase: 食べる (taberu) + ます (masu) + た (ta)
    'expectedTokens': <String>['ケーキ', 'を', '食べるますた', '。'], 
    // 'ケーキ' and 'を' are pure kana, so they yield spaces to suppress furigana
    'expectedReadings': <String>[' ', ' ', 'タベマシタ', ''], 
    'expectedPosLengths': 4,
  },
  {
    'description': 'Groups verb + desire + past tense (食べたかった)',
    'input': '寿司を食べたかった',
    'expectedSegments': <String>['寿司', 'を', '食べたかった'],
    // Combined orthBase: 食べる (taberu) + たい (tai) + た (ta)
    'expectedTokens': <String>['寿司', 'を', '食べるたいた'], 
    'expectedReadings': <String>['スシ', ' ', 'タベタカッタ'],
    'expectedPosLengths': 3,
  },
  {
    'description': 'Groups I-adjective + past tense (可愛かった)',
    'input': '犬は可愛かった',
    'expectedSegments': <String>['犬', 'は', '可愛かった'],
    // Combined orthBase: 可愛い (kawaii) + た (ta)
    'expectedTokens': <String>['犬', 'は', '可愛いた'], 
    'expectedReadings': <String>['イヌ', ' ', 'カワイカッタ'],
    'expectedPosLengths': 3,
  },
  {
    'description': 'Groups causative passive verb (待たせられた)',
    'input': '待たせられた',
    'expectedSegments': <String>['待たせられた'],
    // Combined orthBase: 待つ (matsu) + せる (seru) + られる (rareru) + た (ta)
    'expectedTokens': <String>['待つせるられるた'], 
    'expectedReadings': <String>['マタセラレタ'],
    'expectedPosLengths': 1,
  },
];