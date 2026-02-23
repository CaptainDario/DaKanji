import 'package:da_db/database/db_queries/dictionary_search/grouping_rules.dart';

import '../../dictionary_test_variables.dart';
import 'dictionary_search_test_helper_classes.dart';

List<DictionarySearchTestCase> groupByMultipleTypesTests = [

  // ---------------------------------------------------------------------------
  // TEST 1: Term vs. Term+Reading Grouping
  // Interaction: 
  // - Dict 2 (Bank 1) & 4 (Bank 4) merge by TERM (same term '水餃子', different readings).
  // - Dict 1 (Bank 2) & 3 (Bank 3) merge by TERM+READING (same term '水餃子', same reading).
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Term and Term+Reading grouping: Group ID 2&4 by Term (mixed readings), Group ID 1&3 by Term+Reading (strict).",
    query: "水餃子",
    groupingRules: [
      TermGroupingRule({2, 4}), // ID 2 (Bank 1: suigyouza) + ID 4 (Bank 4: mizugyouza)
      TermAndReadingGroupingRule({1, 3}), // ID 1 (Bank 2: suigyouza) + ID 3 (Bank 3: suigyouza)
    ],
    queryMatches: [const ExpectedMatchGroup(
      exactMatches: [
        // Group 1: Term+Reading Rule (ID 1 & 3) - Merged strictly
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['2) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['3) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
        ],
        // Group 2: Term Rule (ID 2 & 4) - Merged despite reading difference
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['1) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'みずぎょうざ',
            definitions: ['4) common misspelling of 水餃子'],
            match: '水餃子',
          ),
        ],
      ],
    )],
  ),

  // ---------------------------------------------------------------------------
  // TEST 2: Term vs. Sequence Grouping
  // Interaction:
  // - ID 3 (Bank 3) expands to ID 2 (Bank 1) via SEQUENCE (803).
  // - ID 4 (Bank 4) & 5 (Bank 5) merge by TERM.
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Term + Sequence grouping: ID 3 expands to ID 2 via Sequence 803. ID 4 & 5 merge by Term '帽子'.",
    query: "帽子",
    groupingRules: [
      TermGroupingRule({4, 5}), // ID 4 & 5 (Both '帽子')
      SequenceGroupingRule(
        sourceDictId: 3, // ID 3 (Bank 3) '帽子' (Seq 803)
        targetDictIds: {2} // ID 2 (Bank 1) '生餃子' (Seq 803)
      )
    ],
    queryMatches: [ExpectedMatchGroup(
      exactMatches: [
        // Group 1: Sequence Group (ID 3 + ID 2)
        // ID 3 is the query match, ID 2 is the sequence match
        [
          ExpectedDictionaryMatch(
            term: '帽子',
            reading: 'ぼうし',
            definitions: ['hat; cap (dict 3)'],
            match: '帽子',
          ),
          ExpectedDictionaryMatch(
            term: '生餃子',
            reading: 'なまぎょうざ',
            definitions: ['1) raw gyoza; uncooked dumplings'],
            match: 'Sequence number',
            metas: [namaGyouzaMeta]
          ),
        ],
        // Group 2: Term Group (ID 4 + ID 5)
        [
          ExpectedDictionaryMatch(
            term: '帽子',
            reading: 'ぼうし',
            definitions: ['hat; cap (dict 4)'],
            match: '帽子',
          ),
          ExpectedDictionaryMatch(
            term: '帽子',
            reading: 'ぼうし',
            definitions: ['hat; cap (dict 5)'],
            match: '帽子',
          ),
        ],
      ],
    )],
  ),

  // ---------------------------------------------------------------------------
  // TEST 3: Term+Reading vs. Sequence Grouping
  // Interaction:
  // - ID 2 (Bank 1) & 3 (Bank 3) merge by TERM+READING.
  // - ID 1 (Bank 2) expands to ID 4 (Bank 4) via SEQUENCE (998).
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Term+Reading and Sequence grouping: ID 2&3 merge by strict reading. ID 1 expands to ID 4 via Sequence 998.",
    query: "水餃子",
    groupingRules: [
      TermAndReadingGroupingRule({2, 3}), // ID 2 (Bank 1) & ID 3 (Bank 3)
      SequenceGroupingRule(
        sourceDictId: 1, // ID 1 (Bank 2) Seq 998
        targetDictIds: {4} // ID 4 (Bank 4) Seq 998
      )
    ],
    queryMatches: [const ExpectedMatchGroup(
      exactMatches: [
        // Group 1: Sequence Group (ID 1 + ID 4)
        // Merges despite ID 4 having a different reading ('mizugyouza') 
        // because Sequence rules override reading mismatches.
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['2) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'みずぎょうざ',
            definitions: ['4) common misspelling of 水餃子'],
            match: '水餃子',
          ),
        ],
        // Group 2: Term+Reading Group (ID 2 + ID 3)
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['1) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['3) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
        ],
      ],
    )],
  ),
];