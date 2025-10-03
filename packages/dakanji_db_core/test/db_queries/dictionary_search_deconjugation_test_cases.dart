import 'dictionary_search_test_helper_classes.dart';

List<SearchTestCase> deconjugationTestCases = [
  SearchTestCase(
    description: 'Deconjugation: polite form',
    query: '食べます',
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        ExpectedSearchResult(term: '食べます', reading: 'たべます', match: '食べます', definitions: ["to eat (polite)"]),
      ],
    ),
    queryVariantMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          ExpectedSearchResult(term: '食べる', reading: 'たべる', match: '食べる', definitions: ["to eat"]),
        ],
      )
    ],
  ),
  SearchTestCase(
    description: 'Deconjugation: ambiguous potential form',
    query: 'いける',
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        ExpectedSearchResult(term: '生ける', reading: 'いける', match: 'いける', definitions: ["to arrange (flowers)"]),
      ],
    ),
    queryVariantMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          ExpectedSearchResult(term: '行く', reading: 'いく', match: 'いく', definitions: ["to go"]),
        ],
      )
    ],
  ),
  SearchTestCase(
    description: 'Deconjugation: ambiguous negative form',
    query: 'ぶれない',
    queryVariantMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          ExpectedSearchResult(term: 'ぶれる', reading: 'ぶれる', match: 'ぶれる', definitions: ["to be blurred", "to be shaky"]),
        ],
      ),
      const ExpectedMatchGroup(
        exactMatches: [
          ExpectedSearchResult(term: '振る', reading: 'ぶる', match: 'ぶる', definitions: ["to wave", "to shake", "to wield"]),
        ],
      )
    ],
  ),
];