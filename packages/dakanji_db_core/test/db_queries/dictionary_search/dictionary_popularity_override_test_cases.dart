import 'package:dakanji_db_core/data/term_meta_entry_types.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';

import '../../dictionary_test_variables.dart';
import 'dictionary_search_test_helper_classes.dart';



String descriptionPrefix = "Popularity Override";

List<ExpectedDictionarySearchResult> popularityOverrideTestCases = [
  ExpectedDictionarySearchResult(
    description: '''$descriptionPrefix: Popularity override should rank 生餃子 -> 生ける -> 生ビール but still apply dictionary sort order
    生ビール　does not have a popularity override and should come last
    ''',
    query: "生",
    queryMatches: ExpectedMatchGroup(
      prefixMatches: [
        // --- dictionary 1 ----------------------------------------------------
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['2) raw gyoza; uncooked dumplings'],
          metas: [
            TermMetaBankV3Entry(
              id: 0,
              indexEntry: testDictionaryIndexEntry,
              term: "生餃子",
              frequency: 3,
              type: TermMetaBankEntryTypes.freq,
              pitchs: [],
              ipas: []
            )
          ]
        )],
        // --- dictionary 2 ----------------------------------------------------
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['1) raw gyoza; uncooked dumplings'],
          metas: [
            TermMetaBankV3Entry(
              id: 0,
              indexEntry: testDictionaryIndexEntry,
              term: "生餃子",
              frequency: 3,
              type: TermMetaBankEntryTypes.freq,
              pitchs: [],
              ipas: []
            )
          ]
        )],
        [ExpectedDictionaryMatch(
          term: '生ける',
          reading: 'いける',
          match: '生ける',
          definitions: ['to arrange (flowers)'],
          metas: [
            TermMetaBankV3Entry(
              id: 0,
              indexEntry: testDictionaryIndexEntry, 
              type: TermMetaBankEntryTypes.freq,
              frequency: 2,
              term: "生ける",
              pitchs: [],
              ipas: []
            )
          ]
        )],
        [ExpectedDictionaryMatch(
          term: '生ビール',
          reading: '',
          match: '生ビール',
          definitions: ['draft beer; draught beer'],
        )],
        // --- dictionary 3 ----------------------------------------------------
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['3) raw gyoza; uncooked dumplings'],
          metas: [
            TermMetaBankV3Entry(
              id: 0,
              indexEntry: testDictionaryIndexEntry,
              term: "生餃子",
              frequency: 3,
              type: TermMetaBankEntryTypes.freq,
              pitchs: [],
              ipas: []
            )
          ]
        )],
      ],
    ),
  ),
];