import 'dictionary_search_test_helper_classes.dart';

List<SearchTestCase> deconjugationTestCases = [
  SearchTestCase(
    description: 'Deconjugation: polite form',
    query: '食べます',
    termMatches: const ExpectedMatchGroup(
      exactMatches: [
        ExpectedSearchResult(term: '食べます', reading: 'たべます', match: '食べます', definitions: ["to eat (polite)"]),
      ],
    ),
    variantMatches: [
      const ExpectedMatchGroup(
        tokenMatches: [
          ExpectedSearchResult(term: '食べる', reading: 'たべる', match: '食べます', definitions: ["to eat"]),
        ],
      )
    ],
  ),
  SearchTestCase(
    description: 'Deconjugation: ambiguous potential form',
    query: 'いける',
    variantMatches: [
      const ExpectedMatchGroup(
        tokenMatches: [
          ExpectedSearchResult(term: '行く', reading: 'いく', match: 'いける', definitions: ["to go"]),
          ExpectedSearchResult(term: '生ける', reading: 'いける', match: 'いける', definitions: ["to arrange (flowers)"]),
        ],
      )
    ],
  ),
  SearchTestCase(
    description: 'Deconjugation: ambiguous negative form',
    query: 'ぶれない',
    variantMatches: [
      const ExpectedMatchGroup(
        tokenMatches: [
          ExpectedSearchResult(term: 'ぶれる', reading: 'ぶれる', match: 'ぶれない', definitions: ["to be blurred", "to be shaky"]),
          ExpectedSearchResult(term: '振る', reading: 'ぶる', match: 'ぶれない', definitions: ["to wave", "to shake", "to wield"]),
        ],
      )
    ],
  ),
];