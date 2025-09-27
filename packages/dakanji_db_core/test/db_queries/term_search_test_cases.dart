// term_search_test_cases.dart

/// Represents an expected search result, including the matched text.
class ExpectedSearchResult {
  final String term;
  final String reading;
  final String match; // The text that was matched (e.g., highlighted text)

  const ExpectedSearchResult({
    required this.term,
    required this.reading,
    required this.match,
  });
}

/// Defines a single test case, mirroring the structure of `DictionarySearchResults`.
class SearchTestCase {
  final String description;
  final String query;
  final bool isFuture;
  final bool expectOrdered;

  final List<ExpectedSearchResult> expectedExactMatchs;
  final List<ExpectedSearchResult> expectedPrefixMatchs;
  final List<ExpectedSearchResult> expectedTokenMatchs;
  final List<ExpectedSearchResult> expectedFuzzyMatchs;
  final List<ExpectedSearchResult> expectedWildcardMatchs;

  const SearchTestCase({
    required this.description,
    required this.query,
    this.expectedExactMatchs = const [],
    this.expectedPrefixMatchs = const [],
    this.expectedTokenMatchs = const [],
    this.expectedFuzzyMatchs = const [],
    this.expectedWildcardMatchs = const [],
    this.isFuture = false,
    this.expectOrdered = false,
  });
}

// NOTE: Test case results are categorized based on their *intent*.
// Your current DAO implementation may only return results in `exactMatchs`,
// so tests for other types will fail until those match types are implemented.
final List<SearchTestCase> termSearchTestCases = [
  // --- General Search & Sorting ---
  SearchTestCase(
    description: 'Exact match on term',
    query: "食べる",
    expectedExactMatchs: [
      const ExpectedSearchResult(term: '食べる', reading: 'たべる', match: '食べる'),
    ],
    expectedPrefixMatchs: [
      const ExpectedSearchResult(term: '食べるラー油', reading: 'たべるらーゆ', match: '食べるラー油')
    ],
    expectOrdered: true,
  ),
  SearchTestCase(
    description: 'Prefix match on term',
    query: '食べ',
    // This is a pure prefix test, but FTS may categorize it as a token match.
    // Placing in `expectedPrefixMatchs` to align with intent.
    expectedPrefixMatchs: [
      const ExpectedSearchResult(term: '食べる', reading: 'たべる', match: '食べ'),
      const ExpectedSearchResult(term: '食べ物', reading: 'たべもの', match: '食べ'),
      const ExpectedSearchResult(term: '食べます', reading: 'たべます', match: '食べ'),
      const ExpectedSearchResult(term: '食べるラー油', reading: 'たべるらーゆ', match: '食べ'),
    ],
    expectOrdered: true,
  ),
  SearchTestCase(
    description: 'Exact match on reading (hiragana query)',
    query: 'たべる',
    expectedExactMatchs: [
      const ExpectedSearchResult(term: '食べる', reading: 'たべる', match: 'たべる'),
    ],
    expectedPrefixMatchs: [
      const ExpectedSearchResult(term: '食べるラー油', reading: 'たべるらーゆ', match: 'たべる')
    ],
    expectOrdered: true,
  ),
  SearchTestCase(
    description: 'Sort by popularity for identical reading matches',
    query: 'はやい',
    expectedExactMatchs: [
      // '速い' has higher popularity, should come before '早い'
      const ExpectedSearchResult(term: '速い', reading: 'はやい', match: 'はやい'),
      const ExpectedSearchResult(term: '早い', reading: 'はやい', match: 'はやい'),
    ],
    expectOrdered: true,
  ),

  // --- Input processing ---
  SearchTestCase(
    description: 'Search with Romaji input (taberu -> たべる)',
    query: 'taberu',
    expectedExactMatchs: [
      const ExpectedSearchResult(term: '食べる', reading: 'たべる', match: 'たべる'),
      const ExpectedSearchResult(term: '食べるラー油', reading: 'たべるらーゆ', match: 'たべる'),
    ],
    expectOrdered: true,
  ),
  SearchTestCase(
    description: 'Search with Romaji input (kawaii -> かわいい)',
    query: 'kawaii',
    expectedExactMatchs: [
      const ExpectedSearchResult(term: '可愛い', reading: 'かわいい', match: 'かわいい'),
    ],
  ),

  // --- Sub matches ---
  SearchTestCase(
    description: 'Definition match ("eat" should match "to eat")',
    query: 'eat',
    expectedTokenMatchs: [
      const ExpectedSearchResult(term: '食べる', reading: 'たべる', match: 'eat'),
      const ExpectedSearchResult(term: '食べるラー油', reading: 'たべるらーゆ', match: 'eat'),
      const ExpectedSearchResult(term: '食べます', reading: 'たべます', match: 'eat'),
    ],
  ),

  // --- Deconjugation ---
  SearchTestCase(
    description: 'Deconjugation: polite form',
    query: '食べます',
    expectedExactMatchs: [
      const ExpectedSearchResult(term: '食べます', reading: 'たべます', match: '食べます'),
    ],
    expectedTokenMatchs: [
      const ExpectedSearchResult(term: '食べる', reading: 'たべる', match: '食べます'),
    ],
  ),
  SearchTestCase(
    description: 'Deconjugation: ambiguous potential form',
    query: 'いける',
    expectedTokenMatchs: [
      const ExpectedSearchResult(term: '行く', reading: 'いく', match: 'いける'),
      const ExpectedSearchResult(term: '生ける', reading: 'いける', match: 'いける'),
    ],
  ),
  SearchTestCase(
    description: 'Deconjugation: ambiguous negative form',
    query: 'ぶれない',
    expectedTokenMatchs: [
      const ExpectedSearchResult(term: 'ぶれる', reading: 'ぶれる', match: 'ぶれない'),
      const ExpectedSearchResult(term: '振る', reading: 'ぶる', match: 'ぶれない'),
    ],
  ),

  // --- Wildcard Search ---
  SearchTestCase(
    description: "Wildcard '?': single character",
    query: '?本',
    expectedWildcardMatchs: [
      const ExpectedSearchResult(term: '日本', reading: 'にほん', match: '?本'),
    ],
  ),
  SearchTestCase(
    description: "Wildcard '?': another single character test",
    query: '?本?',
    // This seems to be a test for a more complex token match, like `*本*`.
    // Categorized as wildcard based on the original description.
    expectedWildcardMatchs: [
      const ExpectedSearchResult(term: 'ドイツ人', reading: 'どいつじん', match: '?本?'),
    ],
  ),
  SearchTestCase(
    description: "Wildcard '*': zero to many characters",
    query: '*人',
    expectedWildcardMatchs: [
      const ExpectedSearchResult(term: '日本人', reading: 'にほんじん', match: '*人'),
      const ExpectedSearchResult(term: 'ドイツ人', reading: 'どいつじん', match: '*人'),
    ],
  ),

  // --- Tests for Future Implementation ---
  SearchTestCase(
    description: 'Infix/N-gram match',
    query: '日中',
    isFuture: true,
    expectedTokenMatchs: [
      const ExpectedSearchResult(term: '一日中', reading: 'いちにちじゅう', match: '日中'),
    ],
  ),
  SearchTestCase(
    description: 'Fuzzy match (misspelling)',
    query: 'りょこ',
    isFuture: true,
    // There isn't a fuzzy list in your new structure, so token is the next best place.
    expectedTokenMatchs: [
      const ExpectedSearchResult(term: '旅行', reading: 'りょこう', match: 'りょこ'),
    ],
  ),
];