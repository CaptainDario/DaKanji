import 'dictionary_search_test_helper_classes.dart';

String descriptionPrefix = "Sorting";

List<ExpectedDictionarySearchResult> sortingTestCases = [
  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: popularity for identical reading matches',
    query: 'はやい',
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        // '速い' (freq: 93) should come before '早い' (freq: 23)
        [ExpectedDictionaryMatch(term: '速い', reading: 'はやい', match: 'はやい', definitions: ["fast; quick; rapid"])],
        [ExpectedDictionaryMatch(term: '早い', reading: 'はやい', match: 'はやい', definitions: ["early; premature"])],
      ],
    ),
  ),

  // Length Difference
  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: length difference for prefix matches',
    query: '電',
    queryMatches: const ExpectedMatchGroup(
      prefixMatches: [
        // Length of '電車' (2) is closer to query '電' (1) than '電車賃' (3)
        [ExpectedDictionaryMatch(term: '電車', reading: 'でんしゃ', match: '電車', definitions: ["(electric) train"])],
        [ExpectedDictionaryMatch(term: '電車賃', reading: 'でんしゃちん', match: '電車賃', definitions: ["train fare"])],
      ],
      tokenMatches: [
        [ExpectedDictionaryMatch(term: '満員電車', reading: 'まんいんでんしゃ', match: '満員電車', definitions: ["crowded train; packed train"])],
      ]
    ),
  ),

  // Test for Length Difference as a Tie-Breaker
  ExpectedDictionarySearchResult(
    description: '$descriptionPrefix: length difference when popularity is equal',
    query: 'にほん',
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        // Exact matches still come first.
        [ExpectedDictionaryMatch(term: '日本', reading: 'にほん', match: 'にほん', definitions: ["Japan"])], // pop 99
        [ExpectedDictionaryMatch(term: '二本', reading: 'にほん', match: 'にほん', definitions: ["two long objects"])], // pop 80
      ],
      prefixMatches: [
        // All three prefix matches below have the same popularity (95).
        // Rule 6 (length difference) is now used to sort them.
        // We assume length refers to the term's character count.

        // '日本人' and '日本酒' are both 3 characters long, so they come before the 4-character term.
        // The tie between them is broken by the final rule (fts5/ID). '日本人' (ID 207) comes before '日本酒' (ID 502).
        [ExpectedDictionaryMatch(term: '日本人', reading: 'にほんじん', match: 'にほんじん', definitions: ["Japanese person"])], // pop 95, length 3
        [ExpectedDictionaryMatch(term: '日本酒', reading: 'にほんしゅ', match: 'にほんしゅ', definitions: ["sake; Japanese rice wine"])], // pop 95, length 3

        // '日本晴れ' comes last because it is the longest term (4 characters).
        [ExpectedDictionaryMatch(term: '日本晴れ', reading: 'にほんばれ', match: 'にほんばれ', definitions: ["clear weather; cloudless sky"])], // pop 95, length 4
      ]
    ),
  ),
  ExpectedDictionarySearchResult(
    description: '''$descriptionPrefix:
     Three imported dictionaries should have their user defined sort orders applied correctly''',
    query: "生餃子",
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['2) raw gyoza; uncooked dumplings'],
        )],
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['1) raw gyoza; uncooked dumplings'],
        )],
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['3) raw gyoza; uncooked dumplings'],
        )],
      ],
    ),
  ),
];