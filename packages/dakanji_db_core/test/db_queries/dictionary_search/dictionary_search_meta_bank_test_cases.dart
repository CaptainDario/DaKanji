

import 'dictionary_search_test_helper_classes.dart';

List<SearchTestCase> metaBankTestCases = [
  SearchTestCase(
    description: "Find meta bank entries",
    query: '土木工事',
    tags: [],
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        ExpectedSearchResult(
          term: '土木工事',
          reading: 'どぼくこうじ',
          match: '土木工事',
          definitions: ["civil engineering works; public works"],
          termMetaTypes: ["pitch", "ipa"]
        ),
      ],
    ),
  )
];