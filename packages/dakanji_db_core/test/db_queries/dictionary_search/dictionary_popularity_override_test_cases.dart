import 'dictionary_search_test_helper_classes.dart';



String descriptionPrefix = "Popularity Override";

List<SearchTestCase> popularityOverrideTestCases = [
  SearchTestCase(
    description: '''$descriptionPrefix: Popularity override should rank 生餃子 -> 生ける -> 生ビール but still apply dictionary sort order
    生ビール　does not have a popularity override and should come last
    ''',
    query: "生",
    queryMatches: const ExpectedMatchGroup(
      prefixMatches: [
        // --- dictionary 1 ----------------------------------------------------
        ExpectedSearchResult(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['2) raw gyoza; uncooked dumplings'],
        ),
        // --- dictionary 2 ----------------------------------------------------
        ExpectedSearchResult(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['1) raw gyoza; uncooked dumplings'],
        ),
        ExpectedSearchResult(
          term: '生ける',
          reading: 'いける',
          match: '生ける',
          definitions: ['to arrange (flowers)'],
        ),
        ExpectedSearchResult(
          term: '生ビール',
          reading: '',
          match: '生ビール',
          definitions: ['draft beer; draught beer'],
        ),
        // --- dictionary 3 ----------------------------------------------------
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