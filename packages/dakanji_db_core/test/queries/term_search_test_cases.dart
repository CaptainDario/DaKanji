// This file contains the definitions for the search test cases.
// Separating test cases from the test runner makes them easier to manage and expand.

/// A class to encapsulate a single search test case.
class SearchTestCase {
  /// A description of what this test case is validating.
  final String description;

  /// The search term to be used as input.
  final String query;

  /// A list of the expected 'term' strings in the exact order they should appear.
  final List<String> expectedOrderedTerms;

  /// An optional list of expected 'reading' strings to verify sorting
  /// when terms are identical.
  final List<String>? expectedOrderedReadings;

  SearchTestCase({
    required this.description,
    required this.query,
    required this.expectedOrderedTerms,
    this.expectedOrderedReadings,
  });
}

/// A list of all test cases to be run.
/// The data is based on the provided term_bank_1.json and term_bank_2.json files.
final List<SearchTestCase> searchTestCases = [
  // --- General Search Criteria ---
  SearchTestCase(
    description: 'Exact match on term',
    query: '読む',
    expectedOrderedTerms: ['読む'],
  ),
  SearchTestCase(
    description: 'Exact match on reading',
    query: 'よむ',
    expectedOrderedTerms: ['読む'],
  ),
  SearchTestCase(
    description: 'Prefix match on term',
    query: '打',
    // Expected order: '打つ' and '打ち込む' appear first due to higher popularity (10)
    // than '打' (1). '打つ' comes before '打ち込む' due to a smaller length difference.
    // Duplicates exist because of multiple readings/definitions in the source data.
    expectedOrderedTerms: ['打つ', '打つ', '打ち込む', '打ち込む', '打', '打'],
  ),
  SearchTestCase(
    description: 'Search should find terms from the definition',
    query: 'read', // "to read" is the definition for "読む"
    expectedOrderedTerms: ['読む'],
  ),

  // --- Normalization Tests ---
  SearchTestCase(
    description: 'Normalization of half-width katakana',
    query: 'ﾃｷｽﾄ', // Half-width
    expectedOrderedTerms: ['テキスト'],
  ),
  SearchTestCase(
    description: 'Normalization of full-width romaji',
    query: 'Ｅｎｇｌｉｓｈ', // Full-width
    expectedOrderedTerms: ['English'],
  ),

  // --- Sorting Criteria ---
  SearchTestCase(
    description: 'Sort by popularity (descending)',
    query: '自重',
    // The term '自重' has two entries. The one with reading 'じじゅう' has a higher
    // popularity (2) than 'じちょう' (1), so it should appear first.
    expectedOrderedTerms: ['自重', '自重'],
    expectedOrderedReadings: ['じじゅう', 'じちょう'],
  ),

];
