import 'dictionary_search_test_helper_classes.dart';



List<SearchTestCase> fuzzySearchTestCases = [

  // Test Case 2: Sorting Fuzzy Matches by Cost
  // This test ensures that fuzzy results are sorted correctly among themselves.
  // A 'ち' -> 'じ' substitution has a cost of 10.
  // A 'にほん' -> 'でんしゃ' substitution has a much higher cost (multiple default substitutions of 100).
  // Therefore, 'にほんじん' should appear first.
  SearchTestCase(
    description: "Fuzzy (Sort Order): Lower cost errors (voiced kana, cost 10) should rank higher than higher cost errors (default substitution, cost 100+)",
    query: "ちゅうごくしん",
    fuzzyMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          // 1. Expected: 中国人 (ちゅうごくじん)
          // Reason: 'し' -> 'じ' is a single, low-cost (10) substitution.
          ExpectedSearchResult(
            term: '中国人',
            reading: 'ちゅうごくじん',
            definitions: ['Chinese person'],
            match: 'ちゅうごくじん',
          ),
          // 2. Expected: 日本史 (にほんし)
          // Reason: One high cost deletion (100)
          ExpectedSearchResult(
            term: '中国史',
            reading: 'ちゅうごくし',
            definitions: ['Chinese history; history of China'],
            match: 'ちゅうごくし',
          ),
        ],
      ),
    ]
  ),

  // Tests a common phonetic error defined in your cost table.
  SearchTestCase(
    description: "Fuzzy (match): Long vowel confusion りょこお -> りょこう (Cost 25)",
    query: "りょこお",
    fuzzyMatches: [
      ExpectedMatchGroup(
        exactMatches: [
          ExpectedSearchResult(
            term: '旅行',
            reading: 'りょこう',
            definitions: ['travel; trip'],
            match: 'りょこう',
          )
        ]
      ),
    ],
  ),
  // Tests a common phonetic error defined in your cost table.
  SearchTestCase(
    description: "Fuzzy (match): Long vowel confusion りょこしゃ -> りょこうしゃ",
    query: "りょこしゃ",
    fuzzyMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          ExpectedSearchResult(
            term: '旅行者',
            reading: 'りょこうしゃ',
            definitions: ["traveller; traveler"],
            match: 'りょこうしゃ',
          ),
        ],
      ),
    ]
  ),

  // Tests a common typing mistake involving yōon characters.
  SearchTestCase(
    description: "Fuzzy (match): Small vs large kana でんしや -> でんしゃ (Cost 20)",
    query: "でんしや",
    fuzzyMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          ExpectedSearchResult(
            term: '電車',
            reading: 'でんしゃ',
            definitions: ['(electric) train'],
            match: 'でんしゃ',
          ),
        ],
      ),
    ],
  ),
  SearchTestCase(
    description: "Fuzzy (match): delete extra character",
    query: "たべものう",
    fuzzyMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          ExpectedSearchResult(
            term: '食べ物',
            reading: 'たべもの',
            definitions: ["food"],
            match: 'たべもの',
          ),
        ],
      ),
    ]
  ),
];