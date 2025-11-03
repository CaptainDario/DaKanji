import 'dictionary_search_test_helper_classes.dart';

String descriptionPrefix = "Input processing";

List<ExpectedDictionarySearchResult> inputPreprocessingSearchTestCases = [
  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: Search with Romaji input (taberu -> たべる)',
    query: 'taberu',
    normalizedQueryMatchGroups: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: '食べる', reading: 'たべる', match: 'たべる', definitions: ["to eat"]),
          ]
        ],
        prefixMatches: [
          [
            ExpectedDictionaryMatch(term: '食べるラー油', reading: 'たべるらーゆ', match: 'たべるらーゆ', definitions: ["chili oil with garlic, etc. for eating with rice"])
          ]
        ],
      ),
    ]
  ),
  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: Search with uppercase Romaji (TABERU -> たべる)',
    query: 'TABERU',
    normalizedQueryMatchGroups: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: '食べる', reading: 'たべる', match: 'たべる', definitions: ["to eat"]),
          ]
        ],
        prefixMatches: [
          [
            ExpectedDictionaryMatch(term: '食べるラー油', reading: 'たべるらーゆ', match: 'たべるらーゆ', definitions: ["chili oil with garlic, etc. for eating with rice"])
          ]
        ],
      ),
    ]
  ),
  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: Search with Romaji and kana input (カワii -> かわいい)',
    query: 'カワii',
    normalizedQueryMatchGroups: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: '可愛い', reading: 'かわいい', match: 'かわいい', definitions: ["cute; lovely; charming"]),
          ]
        ],
      ),
    ]
  ),
  ExpectedDictionarySearchResult(
    description: '''$descriptionPrefix: Search for こんぴゅーたー should match コンピューター (term) and こんぴゅーたー (normalized term) as exact matches,
    but not コンピューター (normalized reading) as normalized match as it is already a query match
    ''',
    query: 'こんぴゅーたー',
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(term: 'こんぴゅーたー', reading: '', match: 'こんぴゅーたー', definitions: ["Computer"]),
        ]
      ],
    ),
    normalizedQueryMatchGroups: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: 'コンピューター', reading: '', match: 'コンピューター', definitions: ["Computer"]),
          ]
        ],
      ),
    ]
  ),
  ExpectedDictionarySearchResult(
    description: '''$descriptionPrefix:
      Search for ストラップ should match ストラップ (reading) and すとらっぷ (normalized reading) as exact matches,
      but not コンピューター (normalized reading) as a normalized match as it is already a query match
    ''',
    query: 'ストラップ',
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(term: '', reading: 'ストラップ', match: 'ストラップ', definitions: ["Computer"]),
        ]
      ],
    ),
    normalizedQueryMatchGroups: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: '', reading: 'すとらっぷ', match: 'すとらっぷ', definitions: ["Computer"]),
          ]
        ],
      ),
    ]
  ),
  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: Search for コンピューター (Katakana) should match こんぴゅーたー (reading)',
    query: 'コンピューター',
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(term: 'コンピューター', reading: '', match: 'コンピューター', definitions: ["Computer"]),
        ]
      ],
    ),
    normalizedQueryMatchGroups: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: 'こんぴゅーたー', reading: '', match: 'こんぴゅーたー', definitions: ["Computer"]),
          ]
        ],
      ),
    ]
  ),
  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: Search for とうきょう (explicit vowel) should match トーキョー (long vowel mark) ONLY in normalized matches',
    query: 'とうきょう',
    normalizedQueryMatchGroups: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: 'トーキョー', reading: '', match: 'トーキョー', definitions: ["Tokyo (katakana)"]),
          ]
        ],
      ),
    ]
  ),

  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: Search for らーめん (long vowel mark) should match らあめん (explicit vowel)',
    query: 'らーめん',
    normalizedQueryMatchGroups: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: 'らあめん', reading: '', match: 'らあめん', definitions: ["ramen"]),
          ]
        ],
      ),
    ]
  ),

  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: Search for びーる should match 生ビール (normalized tokens)',
    query: 'びーる',
    normalizedQueryMatchGroups: [
      const ExpectedMatchGroup(
        tokenMatches: [
          [
            ExpectedDictionaryMatch(term: '生ビール', reading: '', match: '生ビール', definitions: ["draft beer; draught beer"]),
          ]
        ],
      ),
    ]
  ),

  ExpectedDictionarySearchResult(
    description:
        '$descriptionPrefix: Romaji to Hiragana with multiple results (kani -> かんい, かに)',
    query: 'kani',
    normalizedQueryMatchGroups: [
      ExpectedMatchGroup(exactMatches: [
        [
          ExpectedDictionaryMatch(term: '蟹', reading: 'かに', definitions: ['crab'], match: 'かに')
        ]
      ]),
      ExpectedMatchGroup(exactMatches: [
        [
          ExpectedDictionaryMatch(term: '簡易', reading: 'かんい', definitions: ['simplicity; easiness'], match: 'かんい')
        ]
      ]),
    ],
  ),
];