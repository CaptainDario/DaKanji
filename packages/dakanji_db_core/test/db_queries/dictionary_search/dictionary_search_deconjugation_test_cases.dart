import 'dictionary_search_test_helper_classes.dart';

List<ExpectedDictionarySearchResult> deconjugationTestCases = [
  ExpectedDictionarySearchResult(
    description: 'Deconjugation: polite form',
    query: '食べます',
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(term: '食べます', reading: 'たべます', match: '食べます', definitions: ["to eat (polite)"]),
        ]
      ],
    ),
    queryVariantMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: '食べる', reading: 'たべる', match: '食べる', definitions: ["to eat"]),
          ]
        ],
        prefixMatches: [
          [
            ExpectedDictionaryMatch(term: '食べるラー油', reading: 'たべるらーゆ', match: '食べるラー油', definitions: ["chili oil with garlic, etc. for eating with rice"])
          ]
        ],
      )
    ],
  ),
  ExpectedDictionarySearchResult(
    description: 'Deconjugation: ambiguous potential form',
    query: 'いける',
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(term: '生ける', reading: 'いける', match: 'いける', definitions: ["to arrange (flowers)"]),
        ]
      ],
    ),
    queryVariantMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: '行く', reading: 'いく', match: 'いく', definitions: ["to go"]),
          ]
        ],
      )
    ],
  ),
  ExpectedDictionarySearchResult(
    description: 'Deconjugation: ambiguous negative form',
    query: 'ぶれない',
    queryVariantMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: 'ぶれる', reading: 'ぶれる', match: 'ぶれる', definitions: ["to be blurred", "to be shaky"]),
          ]
        ],
      ),
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: '振る', reading: 'ぶる', match: 'ぶる', definitions: ["to wave", "to shake", "to wield"]),
          ]
        ],
      )
    ],
  ),
];