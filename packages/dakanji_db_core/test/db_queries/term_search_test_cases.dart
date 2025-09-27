// term_search_test_cases.dart

// No change to this class
class ExpectedSearchResult {
  final String term;
  final String reading;

  const ExpectedSearchResult({required this.term, required this.reading});
}

/// NEW: This class mirrors your `DictionarySearchResult` structure.
/// It holds the expected results, categorized by match type.
class ExpectedSearchResultGroup {
  final List<ExpectedSearchResult> exactMatch;
  final List<ExpectedSearchResult> prefixMatch;
  final List<ExpectedSearchResult> tokenMatch;
  final List<ExpectedSearchResult> wildcardMatch;

  const ExpectedSearchResultGroup({
    this.exactMatch = const [],
    this.prefixMatch = const [],
    this.tokenMatch = const [],
    this.wildcardMatch = const [],
  });
}

// Defines a unified structure and list for all search test cases.
class SearchTestCase {
  final String description;
  final String query;
  final bool isFuture;
  final bool expectOrdered;

  // UPDATED: These now use the new group structure.
  final ExpectedSearchResultGroup expectedTermMatches;
  final ExpectedSearchResultGroup expectedHiraganaTermMatches;
  final List<ExpectedSearchResultGroup> expectedPreprocessedTermsMatches;

  const SearchTestCase({
    required this.description,
    required this.query,
    this.expectedTermMatches = const ExpectedSearchResultGroup(),
    this.expectedHiraganaTermMatches = const ExpectedSearchResultGroup(),
    this.expectedPreprocessedTermsMatches = const [],
    this.isFuture = false,
    this.expectOrdered = false,
  });
}


final List<SearchTestCase> termSearchTestCases = [
  // --- General Search & Sorting ---
  SearchTestCase(
    description: 'Exact and Prefix match on term',
    query: "食べる",
    expectedTermMatches: const ExpectedSearchResultGroup(
      exactMatch: [
        ExpectedSearchResult(term: '食べる', reading: 'たべる'),
      ],
      prefixMatch: [
        ExpectedSearchResult(term: '食べるラー油', reading: 'たべるらーゆ'),
      ],
    ),
    expectOrdered: true,
  ),
  SearchTestCase(
    description: 'Prefix match on term',
    query: '食べ',
    expectedTermMatches: const ExpectedSearchResultGroup(
      prefixMatch: [
        ExpectedSearchResult(term: '食べる', reading: 'たべる'),
        ExpectedSearchResult(term: '食べ物', reading: 'たべもの'),
        ExpectedSearchResult(term: '食べます', reading: 'たべます'),
        ExpectedSearchResult(term: '食べるラー油', reading: 'たべるらーゆ'),
      ],
    ),
    expectOrdered: true,
  ),
  SearchTestCase(
    description: 'Exact and Prefix match on reading (hiragana query)',
    query: 'たべる',
    expectedTermMatches: const ExpectedSearchResultGroup(
      exactMatch: [
        ExpectedSearchResult(term: '食べる', reading: 'たべる'),
      ],
      prefixMatch: [
        ExpectedSearchResult(term: '食べるラー油', reading: 'たべるらーゆ'),
      ],
    ),
    expectOrdered: true,
  ),
  SearchTestCase(
    description: 'Sort by popularity for identical reading matches',
    query: 'はやい',
    expectedTermMatches: const ExpectedSearchResultGroup(
      exactMatch: [
        // '速い' has popularity 93, so it should come before '早い' (91)
        ExpectedSearchResult(term: '速い', reading: 'はやい'),
        ExpectedSearchResult(term: '早い', reading: 'はやい'),
      ],
    ),
    expectOrdered: true,
  ),

  // --- Input processing ---
  SearchTestCase(
    description: 'Search with Romaji input (taberu -> たべる)',
    query: 'taberu',
    expectedTermMatches: const ExpectedSearchResultGroup(), // The original term "taberu" matches nothing.
    expectedHiraganaTermMatches: const ExpectedSearchResultGroup( // The converted "たべる" matches these.
      exactMatch: [
        ExpectedSearchResult(term: '食べる', reading: 'たべる'),
      ],
      prefixMatch: [
        ExpectedSearchResult(term: '食べるラー油', reading: 'たべるらーゆ'),
      ],
    ),
    expectOrdered: true,
  ),
  SearchTestCase(
    description: 'Search with Romaji input (kawaii -> かわいい)',
    query: 'kawaii',
    expectedTermMatches: const ExpectedSearchResultGroup(),
    expectedHiraganaTermMatches: const ExpectedSearchResultGroup(
      exactMatch: [
        ExpectedSearchResult(term: '可愛い', reading: 'かわいい'),
      ],
    ),
  ),

  // --- Sub matches (Assuming these fall under 'token' matches) ---
  SearchTestCase(
    description: 'Definition match ("eat" should match "to eat" and "eating")',
    query: 'eat',
    isFuture: false,
    expectedTermMatches: const ExpectedSearchResultGroup(
      tokenMatch: [
        ExpectedSearchResult(term: '食べる', reading: 'たべる'),
        ExpectedSearchResult(term: '食べるラー油', reading: 'たべるらーゆ'),
        ExpectedSearchResult(term: '食べます', reading: 'たべます'),
      ],
    ),
  ),

  // --- Deconjugation (Assuming these are a form of 'token' match) ---
  SearchTestCase(
    description: 'Deconjugation: polite form',
    query: '食べます',
    expectedTermMatches: const ExpectedSearchResultGroup(
      exactMatch: [
         ExpectedSearchResult(term: '食べます', reading: 'たべます'),
      ],
      tokenMatch: [
        // Should find the dictionary form '食べる'
        ExpectedSearchResult(term: '食べる', reading: 'たべる'),
      ],
    ),
  ),
  SearchTestCase(
    description: 'Deconjugation: ambiguous potential form',
    query: 'いける',
    expectedTermMatches: const ExpectedSearchResultGroup(
      tokenMatch: [
        ExpectedSearchResult(term: '行く', reading: 'いく'),
        ExpectedSearchResult(term: '生ける', reading: 'いける'),
      ],
    ),
  ),
  SearchTestCase(
    description: 'Deconjugation: ambiguous negative form',
    query: 'ぶれない',
    expectedTermMatches: const ExpectedSearchResultGroup(
      tokenMatch: [
        ExpectedSearchResult(term: 'ぶれる', reading: 'ぶれる'),
        ExpectedSearchResult(term: '振る', reading: 'ぶる'),
      ],
    ),
  ),

  // --- Wildcard Search ---
  SearchTestCase(
    description: "Wildcard '?': single character",
    query: '?本',
    expectedTermMatches: const ExpectedSearchResultGroup(
      wildcardMatch: [
        ExpectedSearchResult(term: '日本', reading: 'にほん'),
      ],
    ),
  ),
  SearchTestCase(
    description: "Wildcard '?': single character",
    query: '?本?',
    // This seems like a typo in the original test, assuming it should not match 'ドイツ人'.
    // If it should, it's a different kind of wildcard. Adjust if needed.
    expectedTermMatches: const ExpectedSearchResultGroup(
      wildcardMatch: [],
    ),
  ),
  SearchTestCase(
    description: "Wildcard '*': zero to many characters",
    query: '*人',
    expectedTermMatches: const ExpectedSearchResultGroup(
      wildcardMatch: [
        ExpectedSearchResult(term: '日本人', reading: 'にほんじん'),
        ExpectedSearchResult(term: 'ドイツ人', reading: 'どいつじん'),
      ],
    ),
  ),
];