import 'dictionary_search_test_helper_classes.dart';



String descriptionPrefix = "Search";

final List<ExpectedDictionarySearchResult> searchTestCases = [
  // --- General Search & Sorting ---
  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: Exact match on term',
    query: "食べる",
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(
            term: '食べる', reading: 'たべる', match: '食べる',
            definitions: ["to eat"]
          ),
        ]
      ],
      prefixMatches: [
        [
          ExpectedDictionaryMatch(
            term: '食べるラー油', reading: 'たべるらーゆ', match: '食べるラー油',
            definitions: ["chili oil with garlic, etc. for eating with rice"]
          )
        ]
      ],
    ),
  ),
  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: Prefix match on term',
    query: '食べ',
    queryMatches: const ExpectedMatchGroup(
      prefixMatches: [
        [
          ExpectedDictionaryMatch(term: '食べる', reading: 'たべる', match: '食べる', definitions: ["to eat"]),
          ExpectedDictionaryMatch(term: '食べ物', reading: 'たべもの', match: '食べ物', definitions: ["food"]),
          ExpectedDictionaryMatch(term: '食べます', reading: 'たべます', match: '食べます', definitions: ["to eat (polite)"]),
          ExpectedDictionaryMatch(term: '食べるラー油', reading: 'たべるらーゆ', match: '食べるラー油', definitions: ["chili oil with garlic, etc. for eating with rice"]),
        ]
      ],
    ),
  ),
  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: Exact match on reading (hiragana query)',
    query: 'たべる',
    queryMatches: const ExpectedMatchGroup(
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
  ),
  // --- Definitions ---
  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: Definition ordering',
    query: "召し上がる",
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(
            term: '召し上がる', reading: 'めしあがる',
            definitions: ["to eat (honorific)", "to eat"],
            match: '召し上がる'
          ),
        ]
      ],
    ),
  ),

  // --- Sub matches ---
  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: Definition match ("eat" should match "to eat" and "eating")',
    query: 'eat',
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(term: 'イート', reading: 'いーと', match: 'eat', definitions: ["eat"]),
        ]
      ],
      tokenMatches: [
        [
          ExpectedDictionaryMatch(term: '食べる', reading: 'たべる', match: 'to eat', definitions: ["to eat"]),
          ExpectedDictionaryMatch(term: '召し上がる', reading: 'めしあがる', match: 'to eat', definitions: ["to eat (honorific)", "to eat"]),
          ExpectedDictionaryMatch(term: '食べます', reading: 'たべます', match: 'to eat (polite)', definitions: ["to eat (polite)"]),
          ExpectedDictionaryMatch(term: 'イート', reading: 'いーと', match: "the act of eating", definitions: ["the act of eating"]),
          ExpectedDictionaryMatch(term: '食べるラー油', reading: 'たべるらーゆ', match: 'chili oil with garlic, etc. for eating with rice', definitions: ["chili oil with garlic, etc. for eating with rice"]),
        ]
      ],
    )
  ),

  // --- Various match types using 電車 (でんしゃ) ---
  ExpectedDictionarySearchResult(
    description: "$descriptionPrefix: Exact, prefix and token matches",
    query: "電車",
    // Expected results for the hiragana-converted query: 'でんしゃ'
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(
            term: '電車',
            reading: 'でんしゃ',
            definitions: ['(electric) train'],
            match: '電車',
          ),
        ]
      ],
      prefixMatches: [
        [
          ExpectedDictionaryMatch(
            term: '電車賃',
            reading: 'でんしゃちん',
            definitions: ['train fare'],
            match: '電車賃',
          ),
        ]
      ],
      tokenMatches: [
        [
          ExpectedDictionaryMatch(
            term: '満員電車',
            reading: 'まんいんでんしゃ',
            definitions: ['crowded train; packed train'],
            match: '満員電車',
          ),
        ]
      ],
    ),
  ),
];

