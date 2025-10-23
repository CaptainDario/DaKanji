import 'dictionary_search_test_helper_classes.dart';



String descriptionPrefix = "Search";

final List<SearchTestCase> dictionarySortOrderTestCases = [
  // --- General Search & Sorting ---
  SearchTestCase(
    description: '''$descriptionPrefix:
     Three imported dictionaries should have their user defined sort orders applied correctly''',
    query: "生餃子",
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        ExpectedSearchResult(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['2) raw gyoza; uncooked dumplings'],
        ),
        ExpectedSearchResult(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['1) raw gyoza; uncooked dumplings'],
        ),
        ExpectedSearchResult(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['3) raw gyoza; uncooked dumplings'],
        ),
      ],
    ),
  ),
];

