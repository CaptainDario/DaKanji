import 'package:da_db/database/example/example_entry.dart';
import 'package:language_processing/language_processing.dart';

import 'example_bank_fts_test_cases.dart';

/// Test queries specifically for direct term string searches.
final List<(String, List<Iso639_3>)> exampleTokenTestQueries = [
  ("食べる", [Iso639_3.jpn]),  // 1. Should match the fully loaded example
  ("犬", [Iso639_3.jpn]),     // 2. Should match the bare minimum example
  ("apples", [Iso639_3.eng]), // 3. Should match the English example
];

/// The expected outputs for the token queries. 
/// We reuse the meticulously defined expected values from the FTS test cases 
/// since the resulting hydrated ExampleEntry objects should be identical.
final List<List<ExampleEntry>> exampleTokenTestExpectedValues = [
  exampleSentenceTestExpectedValues[0], // Expected for "リンゴ"
  exampleSentenceTestExpectedValues[1], // Expected for "犬"
  exampleSentenceTestExpectedValues[3], // Expected for "apples"
];