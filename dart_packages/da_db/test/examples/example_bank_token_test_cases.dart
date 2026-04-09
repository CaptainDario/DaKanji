import 'package:da_db/database/example/example_search_result.dart';

import 'example_bank_fts_test_cases.dart';

final List<(List<String>, )> exampleTokenTestQueries = [
  (["食べる"], ),
  (["犬"], ),
  (["apples"], ),
];

final List<List<ExampleSearchResult>?> exampleTokenTestExpectedValues = [
  [
    ...exampleSentenceTestExpectedValues[0]!,
    exampleSentenceTestExpectedValues[4]![0],
  ],
  exampleSentenceTestExpectedValues[1],
  [], /// only for the target language tokens should be extracted
];