import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_ipa_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_pitch_entry.dart';
import 'package:test/test.dart';

import 'dictionary_search_test_helper_classes.dart';

Matcher matchesPitch(int position, {List<String>? tags, int? nasal, int? devoice}) {
  return isA<TermMetaBankV3PitchEntry>()
    .having((p) => p.position, 'position', position)
    .having((p) => p.tags, 'tags', tags ?? isEmpty)
    .having((p) => p.nasal, 'nasal', nasal)
    .having((p) => p.devoice, 'devoice', devoice);
}

Matcher matchesIpa(String ipa, {List<String>? tags}) {
  return isA<TermMetaBankV3IpaEntry>()
    .having((e) => e.ipa, 'ipa', ipa)
    .having((e) => e.tags, 'tags', tags ?? isEmpty);
}

// Matches a single TermMetaBankV3Entry against one of the expected tuples
Matcher matchesMetaEntry((List<TermMetaBankV3PitchEntry>, List<TermMetaBankV3IpaEntry>) expectedMeta) {
  final expectedPitches = expectedMeta.$1;
  final expectedIpas = expectedMeta.$2;

  // Assumes the object in res.metaEntries is TermMetaBankV3Entry
  return isA<TermMetaBankV3Entry>()      
      //  Match the list of pitches
      .having(
        (e) => e.pitchs,
        'pitchs',
        unorderedEquals(
          expectedPitches.map((p) => matchesPitch(
                p.position,
                tags: p.tags,
                nasal: p.nasal,
                devoice: p.devoice,
              )).toList(),
        ),
      )
      
      // Match the list of IPAs
      .having(
        (e) => e.ipas,
        'ipas',
        unorderedEquals(
          expectedIpas.map((ipa) => matchesIpa(
                ipa.ipa,
                tags: ipa.tags,
              )).toList(),
        ),
      );
}

/// Custom matcher that verifies a `DictionaryMatch` object.
///
/// It checks the `match` text and the nested `entry`'s term, reading,
/// and definitions. This has been updated to use `DictionaryMatch`.
Matcher matchesSearchResult(ExpectedSearchResult expected) {
  return isA<DictionaryMatch>()
      .having((res) => res.match, 'match', expected.match)
      .having((res) => res.entry.term, 'entry.term', expected.term)
      .having((res) => res.entry.reading, 'entry.reading', expected.reading)
      .having((res) => res.entry.definitions, 'entry.definitions', orderedEquals(expected.definitions))
      
      // This is much cleaner now
      .having(
        (res) => res.metaEntries,
        'entry.metaEntries',
        unorderedEquals(
          // Map each expected meta-tuple into its own matcher
          expected.metas.map((metaTuple) => matchesMetaEntry(metaTuple)).toList(),
        ),
      );
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

    final wildcardMatchers = expected.wildcardMatches.map(matchesSearchResult).toList();
    expect(actual.wildcardMatches, orderedEquals(wildcardMatchers), reason: "WildcardMatches in group '$groupName' for query '$query' did not match.");

}