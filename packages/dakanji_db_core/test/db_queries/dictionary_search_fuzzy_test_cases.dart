import 'dictionary_search_test_helper_classes.dart';



List<SearchTestCase> fuzzySearchTestCases = [
    SearchTestCase(
    description: "Fuzzy match: でんさ -> でんしゃ",
    query: "でんさ",
    // Expected results for other query variants the system might generate.
    variantMatches: [
      // Simulates a fuzzy search variant, e.g., from a typo 'でんさ'.
      const ExpectedMatchGroup(
        fuzzyMatches: [
          ExpectedSearchResult(
            term: '電車',
            reading: 'でんしゃ',
            definitions: ['(electric) train'],
            match: 'でんしゃ',
          ),
        ],
      ),
    ],
  )
];