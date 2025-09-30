import 'dictionary_search_test_helper_classes.dart';

String descriptionPrefix = "Sorting";

List<SearchTestCase> sortingTestCases = [
  // This is your existing test case. It's a good test for Rule #5.
  SearchTestCase(
    description: '$descriptionPrefix: popularity for identical reading matches',
    query: 'はやい',
    termMatches: const ExpectedMatchGroup(
      exactMatches: [
        // '速い' (freq: 93) should come before '早い' (freq: 23)
        ExpectedSearchResult(term: '速い', reading: 'はやい', match: 'はやい', definitions: ["fast; quick; rapid"]),
        ExpectedSearchResult(term: '早い', reading: 'はやい', match: 'はやい', definitions: ["early; premature"]),
      ],
    ),
  ),

  // New test cases below:

  // Test for Spec Rules: 2 (Match Type) & 4 (Length Difference)
  SearchTestCase(
    description: '$descriptionPrefix: match type and length difference',
    query: '電車',
    termMatches: const ExpectedMatchGroup(
      exactMatches: [
        // Rule 2.1: Exact match '電車' is prioritized
        ExpectedSearchResult(term: '電車', reading: 'でんしゃ', match: '電車', definitions: ["(electric) train"]),
      ],
      prefixMatches: [
        // Rule 2.2: Prefix match '電車賃' comes after exact
        // This also implicitly tests Rule 4: shorter matches ('電車') would come before longer ones ('電車賃') if both were prefix matches.
        ExpectedSearchResult(term: '電車賃', reading: 'でんしゃちん', match: '電車', definitions: ["train fare"]),
      ]
    ),
  ),

  // Test for Spec Rule 2: Match Type (Prefix > Infix)
  SearchTestCase(
    description: '$descriptionPrefix: match type hierarchy (Prefix > Infix)',
    query: '日本',
    termMatches: const ExpectedMatchGroup(
      exactMatches: [
        ExpectedSearchResult(term: '日本', reading: 'にほん', match: '日本', definitions: ["Japan"]),
      ],
      prefixMatches: [
        ExpectedSearchResult(term: '日本人', reading: 'にほんじん', match: '日本', definitions: ["Japanese person"]),
      ],
      tokenMatches: [
        // Infix match '全日本' should be ranked lower than prefix matches
        ExpectedSearchResult(term: '全日本', reading: 'ぜんにほん', match: '日本', definitions: ["all Japan"]),
      ],
    ),
  ),

  // Test for Spec Rule 4: Length Difference
  SearchTestCase(
    description: '$descriptionPrefix: length difference for prefix matches',
    query: '電',
    termMatches: const ExpectedMatchGroup(
      prefixMatches: [
        // Length of '電車' (2) is closer to query '電' (1) than '電車賃' (3)
        ExpectedSearchResult(term: '電車', reading: 'でんしゃ', match: '電', definitions: ["(electric) train"]),
        ExpectedSearchResult(term: '電車賃', reading: 'でんしゃちん', match: '電', definitions: ["train fare"]),
      ]
    ),
  ),

  // Test for Spec Rule 5: Popularity
  SearchTestCase(
    description: '$descriptionPrefix: popularity for identical hiragana matches',
    query: 'にほん',
    termMatches: const ExpectedMatchGroup(
      exactMatches: [
        // '日本' (freq: 99) should come before '二本' (freq: 80)
        ExpectedSearchResult(term: '日本', reading: 'にほん', match: 'にほん', definitions: ["Japan"]),
        ExpectedSearchResult(term: '二本', reading: 'にほん', match: 'にほん', definitions: ["two long objects"]),
      ],
      prefixMatches: [
        ExpectedSearchResult(term: '日本人', reading: 'にほんじん', match: 'にほんじん', definitions: ["Japanese person"]),
      ]
    ),
  ),

  // Test for Spec Rule 3: Match Column (Term > Definition)
  SearchTestCase(
    description: '$descriptionPrefix: match column priority (Term > Definition)',
    query: 'eat',
    termMatches: const ExpectedMatchGroup(
      exactMatches: [
        // This is an exact match on the term itself, so it should rank highly.
        ExpectedSearchResult(term: 'eat', reading: 'いーと', match: 'eat', definitions: ["the act of eating"]),
        // This is an exact match on one of its definitions.
        ExpectedSearchResult(term: '召し上がる', reading: 'めしあがる', match: 'to eat', definitions: ["to eat (honorific)","to eat"]),
      ],
      prefixMatches: [
        // This is a prefix match on its definition. It should rank below exact matches.
        ExpectedSearchResult(term: '食べる', reading: 'たべる', match: 'to eat', definitions: ["to eat"]),
      ],
    ),
  ),

  // Test for Spec Rule 6: FTS Relevance / Tie-breaking
  SearchTestCase(
    description: '$descriptionPrefix: tie-breaker sort order',
    query: 'かわ',
    hiraganaMatches: const ExpectedMatchGroup(
      prefixMatches: [
        // Both are prefix matches of the same length and popularity (98).
        // The final order depends on a stable tie-breaker like FTS relevance or sequence ID.
        // Assuming sequence ID, '可愛い' (214) comes before '川蝉' (407).
        ExpectedSearchResult(term: '可愛い', reading: 'かわいい', match: 'かわ', definitions: ["cute; lovely; charming"]),
        ExpectedSearchResult(term: '川蝉', reading: 'かわせみ', match: 'かわ', definitions: ["kingfisher"]),
      ],
    ),
  ),
];