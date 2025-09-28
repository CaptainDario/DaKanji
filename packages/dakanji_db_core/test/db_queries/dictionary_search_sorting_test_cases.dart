import 'dictionary_search_test_helper_classes.dart';



List<SearchTestCase> sortingTestCases = [
  SearchTestCase(
    description: 'Sort by popularity for identical reading matches',
    query: 'はやい',
    termMatches: const ExpectedMatchGroup(
      exactMatches: [
        // '速い' has higher popularity, should come before '早い'
        ExpectedSearchResult(term: '速い', reading: 'はやい', match: 'はやい', definitions: ["fast; quick; rapid"]),
        ExpectedSearchResult(term: '早い', reading: 'はやい', match: 'はやい', definitions: ["early; premature"]),
      ],
    ),
  ),
];