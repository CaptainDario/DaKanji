/// A simple class to hold spellfix test case data.
/// Parameters like n and maxCost are set in the test runner,
/// not here, to allow for tuning.
class SpellfixTestCase {
  const SpellfixTestCase({
    required this.description,
    required this.word,
    required this.expected,
  });

  final String description;
  final String word;
  final List<String> expected;
}

/// A list of 50 test cases for the spellfix generator,
/// structured by word length. All tests follow a
/// misspelled -> correct (or valid_word -> valid_word) pattern.
final List<SpellfixTestCase> spellfixTestCases = [
  // ======================================================================
  // Short Words (1-3 Hiragana) - 8 Samples
  // ======================================================================

  SpellfixTestCase(
    description: 'みづ -> みず (水, water)',
    word: 'みづ',
    expected: ['みず'],
  ),
  SpellfixTestCase(
    description: 'きょお -> きょう (今日, today)',
    word: 'きょお',
    expected: ['きょう'],
  ),
  SpellfixTestCase(
    description: 'じず -> ちず (地図, map)',
    word: 'じず',
    expected: ['ちず'],
  ),
  SpellfixTestCase(
    description: 'すし -> ずし (逗子, Zushi)',
    word: 'すし',
    expected: ['ずし'],
  ),
  SpellfixTestCase(
    description: 'まち -> まっち (マッチ, match)',
    word: 'まち',
    expected: ['まっち'],
  ),
  SpellfixTestCase(
    description: 'なに -> なんい (難易, difficulty)',
    word: 'なに',
    expected: ['なんい'],
  ),
  SpellfixTestCase(
    description: 'かい -> がい (貝, shell -> 害, harm)',
    word: 'かい',
    expected: ['がい'],
  ),
  SpellfixTestCase(
    description: 'いめ -> いぬ (犬, dog)',
    word: 'いめ',
    expected: ['いぬ'],
  ),

  // ======================================================================
  // Medium Words (4-6 Hiragana) - 30 Samples
  // ======================================================================

  SpellfixTestCase(
    description: 'はなぢ -> はなじ (鼻血, nosebleed)',
    word: 'はなぢ',
    expected: ['はなじ'],
  ),
  SpellfixTestCase(
    description: 'おおさか -> おうさか (大阪, Osaka)',
    word: 'おおさか',
    expected: ['おうさか'],
  ),
  SpellfixTestCase(
    description: 'とおきょう -> とうきょう (東京, Tokyo)',
    word: 'とおきょう',
    expected: ['とうきょう'],
  ),
  SpellfixTestCase(
    description: 'せんせえ -> せんせい (先生, teacher)',
    word: 'せんせえ',
    expected: ['せんせい'],
  ),
  SpellfixTestCase(
    description: 'ええが -> えいが (映画, movie)',
    word: 'ええが',
    expected: ['えいが'],
  ),
  SpellfixTestCase(
    description: 'ほんおよむ -> ほんをよむ (本を読む, read a book)',
    word: 'ほんおよむ',
    expected: ['ほんをよむ'],
  ),
  SpellfixTestCase(
    description: 'わたしわ -> わたしは (私は, as for me)',
    word: 'わたしわ',
    expected: ['わたしは'],
  ),
  SpellfixTestCase(
    description: 'えきえいく -> えきへいく (駅へ行く, go to the station)',
    word: 'えきえいく',
    expected: ['えきへいく'],
  ),
  SpellfixTestCase(
    description: 'しょうじ -> しょうし (障子, screen -> 少子, declining birthrate)',
    word: 'しょうじ',
    expected: ['しょうし'],
  ),
  SpellfixTestCase(
    description: 'りょこしゃ -> りょこうしゃ (旅行者, traveler)',
    word: 'りょこしゃ',
    expected: ['りょこうしゃ'],
  ),
  SpellfixTestCase(
    description: 'せんせ -> せんせい (先生, teacher)',
    word: 'せんせ',
    expected: ['せんせい'],
  ),
  SpellfixTestCase(
    description: 'びょういん -> びよういん (病院, hospital -> 美容院, beauty salon)',
    word: 'びょういん',
    expected: ['びよういん'],
  ),
  SpellfixTestCase(
    description: 'びよういん -> びょういん (美容院, beauty salon -> 病院, hospital)',
    word: 'びよういん',
    expected: ['びょういん'],
  ),
  SpellfixTestCase(
    description: 'おかさん -> おかあさん (お母さん, mother)',
    word: 'おかさん',
    expected: ['おかあさん'],
  ),
  SpellfixTestCase(
    description: 'とうきょ -> とうきょう (東京, Tokyo)',
    word: 'とうきょ',
    expected: ['とうきょう'],
  ),
  SpellfixTestCase(
    description: 'きょと -> きょうと (京都, Kyoto)',
    word: 'きょと',
    expected: ['きょうと'],
  ),
  SpellfixTestCase(
    description: 'がつこう -> がっこう (学校, school)',
    word: 'がつこう',
    expected: ['がっこう'],
  ),
  SpellfixTestCase(
    description: 'さか -> さっか (坂, hill -> 作家, author)',
    word: 'さか',
    expected: ['さっか'],
  ),
  SpellfixTestCase(
    description: 'さっか -> さか (作家, author -> 坂, hill)',
    word: 'さっか',
    expected: ['さか'],
  ),
  SpellfixTestCase(
    description: 'きゃく -> きやく (客, guest -> 規約, agreement)',
    word: 'きゃく',
    expected: ['きやく'],
  ),
  SpellfixTestCase(
    description: 'きやく -> きゃく (規約, agreement -> 客, guest)',
    word: 'きやく',
    expected: ['きゃく'],
  ),
  SpellfixTestCase(
    description: 'しよてん -> しょてん (書店, bookstore)',
    word: 'しよてん',
    expected: ['しょてん'],
  ),
  SpellfixTestCase(
    description: 'じゅぎょう -> じゆぎょう (授業, class -> Jiyugyou)',
    word: 'じゅぎょう',
    expected: ['じゆぎょう'],
  ),
  SpellfixTestCase(
    description: 'きのう -> きんおう (昨日, yesterday -> Kin\'ou)',
    word: 'きのう',
    expected: ['きんおう'],
  ),
  SpellfixTestCase(
    description: 'がいこく -> かいこく (外国, foreign country -> 海国, maritime nation)',
    word: 'がいこく',
    expected: ['かいこく'],
  ),
  SpellfixTestCase(
    description: 'だいがく -> たいがく (大学, university -> 退学, dropping out)',
    word: 'だいがく',
    expected: ['たいがく'],
  ),
  SpellfixTestCase(
    description: 'ぱっぴょう -> はっぴょう (発表, presentation)',
    word: 'ぱっぴょう',
    expected: ['はっぴょう'],
  ),
  SpellfixTestCase(
    description: 'しがし -> ひがし (東, east)',
    word: 'しがし',
    expected: ['ひがし'],
  ),
  SpellfixTestCase(
    description: 'すごい -> まごい (凄い, amazing -> 真鯉, black carp)',
    word: 'すごい',
    expected: ['まごい'],
  ),

  // ======================================================================
  // Long Words (7+ Hiragana) - 12 Samples
  // ======================================================================

  SpellfixTestCase(
    description: 'せんせいええご -> せんせいえいご (先生英語, teacher\'s English)',
    word: 'せんせいええご',
    expected: ['せんせいえいご'],
  ),
  SpellfixTestCase(
    description: 'とおきょうタワー -> とうきょうタワー (東京タワー, Tokyo Tower)',
    word: 'とおきょうタワー',
    expected: ['とうきょうタワー'],
  ),
  SpellfixTestCase(
    description: 'わたしわがくせい -> わたしはがくせい (私は学生, I am a student)',
    word: 'わたしわがくせい',
    expected: ['わたしはがくせい'],
  ),
  SpellfixTestCase(
    description: 'ちゅうごくしん -> ちゅうごくじん (中国人, Chinese person)',
    word: 'ちゅうごくしん',
    expected: ['ちゅうごくじん'],
  ),
  SpellfixTestCase(
    description: 'びょういんのちず -> びよういんのちず (map of the beauty salon)',
    word: 'びょういんのちず',
    expected: ['びよういんのちず'],
  ),
  SpellfixTestCase(
    description: 'せんせありがとう -> せんせいありがとう (先生ありがとう, thank you teacher)',
    word: 'せんせありがとう',
    expected: ['せんせいありがとう'],
  ),
  SpellfixTestCase(
    description: 'しゅかんしをよむ -> しゅうかんしをよむ (週刊誌を読む, read a weekly magazine)',
    word: 'しゅかんしをよむ',
    expected: ['しゅうかんしをよむ'],
  ),
  SpellfixTestCase(
    description: 'はぴょうします -> はっぴょうします (発表します, will present)',
    word: 'はぴょうします',
    expected: ['はっぴょうします'],
  ),
  SpellfixTestCase(
    description: 'じゆぎょうちゅう -> じゅぎょうちゅう (授業中, in class)',
    word: 'じゆぎょうちゅう',
    expected: ['じゅぎょうちゅう'],
  ),
  SpellfixTestCase(
    description: 'んいほんご -> にほんご (日本語, Japanese language)',
    word: 'んいほんご',
    expected: ['にほんご'],
  ),
  SpellfixTestCase(
    description: 'だいがくせい -> たいがくせい (退学生, student who dropped out)',
    word: 'だいがくせい',
    expected: ['たいがくせい'],
  ),
];

