import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_ipa_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_pitch_entry.dart';
import 'package:test/test.dart';

import 'dictionary_search_test_helper_classes.dart';

Matcher matchesPitch(int position, {List<TagBankV3Entry>? tags, int? nasal, int? devoice}) {
  
  return isA<TermMetaBankV3PitchEntry>()
    .having((p) => p.position, 'position', position)
    .having((p) => p.tags.map((e) => e.copyWith(
      id: 0,
      indexEntry: e.indexEntry.copyWith(id: 0, currentSortingOrder: 0)
    )).toList(), 'tags', tags ?? isEmpty)
    .having((p) => p.nasal, 'nasal', nasal)
    .having((p) => p.devoice, 'devoice', devoice);
}

Matcher matchesIpa(String ipa, {List<TagBankV3Entry>? tags}) {

  return isA<TermMetaBankV3IpaEntry>()
    .having((e) => e.ipa, 'ipa', ipa)
    .having((p) => p.tags.map((e) => e.copyWith(
      id: 0,
      indexEntry: e.indexEntry.copyWith(id: 0, currentSortingOrder: 0)
    )).toList(), 'tags', tags ?? isEmpty);
}

// Matches a single TermMetaBankV3Entry against one of the expected tuples
Matcher matchesMetaEntry(TermMetaBankV3Entry expectedMeta) {
  return isA<TermMetaBankV3Entry>()
      // --- 1. Match Core Identity Fields ---
      .having((e) => e.term, 'term', expectedMeta.term)
      .having((e) => e.reading, 'reading', expectedMeta.reading)
      .having((e) => e.type, 'type', expectedMeta.type)

      // --- 2. match freq data 
      .having((e) => e.frequency, 'frequency', expectedMeta.frequency,)
      .having((e) => e.frequencyDisplayValue, 'frequencyDisplayValue', expectedMeta.frequencyDisplayValue,)
      
      // --- 2. Match Pitch List ---
      .having(
        (e) => e.pitchs,
        'pitchs',
        unorderedEquals(
          expectedMeta.pitchs.map((p) => matchesPitch(
                p.position,
                tags: p.tags,
                nasal: p.nasal,
                devoice: p.devoice,
              )).toList(),
        ),
      )

      // --- 3. Match IPA List ---
      .having(
        (e) => e.ipas,
        'ipas',
        unorderedEquals(
          expectedMeta.ipas.map((ipa) => matchesIpa(
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
Matcher matchesSearchResult(List<ExpectedDictionaryMatch> expectedGroup) {
  final expectedMatches =
      expectedGroup.map((e) => e.match).toList();
  final expectedTerms =
      expectedGroup.map((e) => e.term).toList();
  final expectedReadings =
      expectedGroup.map((e) => e.reading).toList();
  final expectedDefinitionMatchers = expectedGroup
      .map((e) => orderedEquals(e.definitions))
      .toList();
  final expectedMetaMatchers = expectedGroup
      .map((e) => unorderedEquals(
            e.metas.map(matchesMetaEntry).toList(),
          ))
      .toList();

  return isA<DictionaryMatch>()
      .having(
        (res) => res.matches,
        'matches',
        orderedEquals(expectedMatches),
      )
      .having(
        (res) => res.entries.map((e) => e.term).toList(),
        'entry terms',
        orderedEquals(expectedTerms),
      )
      .having(
        (res) => res.entries.map((e) => e.reading).toList(),
        'entry readings',
        orderedEquals(expectedReadings),
      )
      .having(
        (res) => res.entries.map((e) => e.definitions).toList(),
        'entry definitions',
        orderedEquals(expectedDefinitionMatchers),
      )
      .having(
        (res) => res.metaEntriesForEachEntry,
        'entry meta entries',
        orderedEquals(expectedMetaMatchers),
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
  _compareMatchBucket(
    actual.exactMatches,
    expected.exactMatches,
    query,
    groupName,
    'ExactMatches',
  );

  _compareMatchBucket(
    actual.prefixMatches,
    expected.prefixMatches,
    query,
    groupName,
    'PrefixMatches',
  );

  _compareMatchBucket(
    actual.tokenMatches,
    expected.tokenMatches,
    query,
    groupName,
    'TokenMatches',
  );

  _compareMatchBucket(
    actual.wildcardMatches,
    expected.wildcardMatches,
    query,
    groupName,
    'WildcardMatches',
  );
}

void _compareMatchBucket(
  List<DictionaryMatch> actual,
  List<List<ExpectedDictionaryMatch>> expected,
  String query,
  String groupName,
  String bucketLabel,
) {
  var actualIndex = 0;

  for (var groupIndex = 0; groupIndex < expected.length; groupIndex++) {
    final expectedGroup = expected[groupIndex];

    if (actualIndex >= actual.length) {
      fail(
        'Missing $bucketLabel for group \'$groupName\' in query \'$query\'. '
        'Expected ${expected.length} groups but only ${actual.length} present.',
      );
    }

    final current = actual[actualIndex];

    expect(
      current,
      matchesSearchResult(expectedGroup), // This matcher is correct
      reason: "$bucketLabel[$groupIndex] in group '$groupName' for query '$query' did not match.",
    );
    actualIndex++;
  }

  if (actualIndex != actual.length) {
    final extras = actual
        .sublist(actualIndex)
        .map((m) => m.toFormattedString(indent: '  '))
        .join('\n');
    fail('Unexpected extra $bucketLabel in group \'$groupName\' for query \'$query\':\n$extras',);
  }
}

void expectMatchGroupList(
  List<SearchMatchGroup> actual,
  List<ExpectedMatchGroup> expected,
  String query,
  String label,
) {
  if (actual.length != expected.length) {
    fail(
      'Unexpected number of $label for query \'$query\'.\n'
      'Expected length: ${expected.length}\n'
      '  Actual length: ${actual.length}\n'
      '   ACTUAL CONTENTS:\n${actual.map((g) => g.toFormattedString(indent: "    ")).join("\n")}',
    );
  }
  for (var i = 0; i < expected.length; i++) {
    expectMatchGroup(actual[i], expected[i], query, '$label[$i]');
  }
}