/// Represents an expected search result, including the matched text.
class ExpectedSearchResult {
  final String term;
  final String reading;
  final List<String> definitions;
  /// The text that was matched (e.g., highlighted text)
  final String match;

  final List<String> termMetaTypes;

  const ExpectedSearchResult({
    required this.term,
    required this.reading,
    required this.definitions,
    required this.match,
    this.termMetaTypes = const [],
  });
}

/// A container for the expected results of a single search query form,
/// categorized by match type. This structure mirrors the `SearchMatchGroup` class.
class ExpectedMatchGroup {
  final List<ExpectedSearchResult> exactMatches;
  final List<ExpectedSearchResult> prefixMatches;
  final List<ExpectedSearchResult> tokenMatches;
  final List<ExpectedSearchResult> fuzzyMatches;
  final List<ExpectedSearchResult> wildcardMatches;

  const ExpectedMatchGroup({
    this.exactMatches = const [],
    this.prefixMatches = const [],
    this.tokenMatches = const [],
    this.fuzzyMatches = const [],
    this.wildcardMatches = const [],
  });
}

/// Defines a single, comprehensive test case that can assert against the different
/// categories of results from a `DictionaryLookupResult`.
class SearchTestCase {

  final String description;

  final String query;

  final List<String> tags;

  /// Expected results from the original, unmodified query.
  final ExpectedMatchGroup queryMatches;

  /// Expected results from the Romaji-to-Hiragana converted query.
  final ExpectedMatchGroup hiraganaQueryMatches;

  /// Expected results from de-conjugated or other normalized query variants.
  final List<ExpectedMatchGroup> queryVariantMatches;

  const SearchTestCase({
    required this.description,
    required this.query,
    this.tags = const [],
    this.queryMatches = const ExpectedMatchGroup(),
    this.hiraganaQueryMatches = const ExpectedMatchGroup(),
    this.queryVariantMatches = const [],
  });
}