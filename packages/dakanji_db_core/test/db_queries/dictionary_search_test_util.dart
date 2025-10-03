import 'package:dakanji_db_core/database/db_queries/dictionary_search_result.dart';
import 'package:test/test.dart';

import 'dictionary_search_test_helper_classes.dart';

/// Custom matcher that verifies a `DictionaryMatch` object.
///
/// It checks the `match` text and the nested `entry`'s term, reading,
/// and definitions. This has been updated to use `DictionaryMatch`.
Matcher matchesSearchResult(ExpectedSearchResult expected) {
  return isA<DictionaryMatch>()
      .having((res) => res.match, 'match', expected.match)
      .having((res) => res.entry.term, 'entry.term', expected.term)
      .having((res) => res.entry.reading, 'entry.reading', expected.reading)
      .having((res) => res.entry.definitions, 'entry.definitions', orderedEquals(expected.definitions));
}

/// Helper function to assert that an actual `SearchMatchGroup`
/// matches an `ExpectedMatchGroup`.
void expectMatchGroup(
    SearchMatchGroup actual,
    ExpectedMatchGroup expected,
    String query,
    String groupName,
) {
    final exactMatchers = expected.exactMatches.map(matchesSearchResult).toList();
    expect(actual.exactMatches, orderedEquals(exactMatchers), reason: "ExactMatches in group '$groupName' for query '$query' did not match.");

    final prefixMatchers = expected.prefixMatches.map(matchesSearchResult).toList();
    expect(actual.prefixMatches, orderedEquals(prefixMatchers), reason: "PrefixMatches in group '$groupName' for query '$query' did not match.");
    
    final tokenMatchers = expected.tokenMatches.map(matchesSearchResult).toList();
    expect(actual.tokenMatches, orderedEquals(tokenMatchers), reason: "TokenMatches in group '$groupName' for query '$query' did not match.");

    final fuzzyMatchers = expected.fuzzyMatches.map(matchesSearchResult).toList();
    expect(actual.fuzzyMatches, orderedEquals(fuzzyMatchers), reason: "FuzzyMatches in group '$groupName' for query '$query' did not match.");

    final wildcardMatchers = expected.wildcardMatches.map(matchesSearchResult).toList();
    expect(actual.wildcardMatches, orderedEquals(wildcardMatchers), reason: "WildcardMatches in group '$groupName' for query '$query' did not match.");
}