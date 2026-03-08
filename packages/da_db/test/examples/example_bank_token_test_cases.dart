import 'package:da_db/database/example/example_search_result.dart';
import 'package:language_processing/language_processing.dart';

import 'example_bank_fts_test_cases.dart';

final List<(List<String>, List<Iso639_3>)> exampleTokenTestQueries = [
  (["食べる"], [Iso639_3.jpn]),
  (["犬"], [Iso639_3.jpn]),
  (["apples"], [Iso639_3.eng]),
];

final List<List<ExampleSearchResult>?> exampleTokenTestExpectedValues = [
  [
    ...exampleSentenceTestExpectedValues[0]!,
    ...exampleSentenceTestExpectedValues[4]!,
  ],
  exampleSentenceTestExpectedValues[1],
  [], /// only for the target language tokens should be extracted
];