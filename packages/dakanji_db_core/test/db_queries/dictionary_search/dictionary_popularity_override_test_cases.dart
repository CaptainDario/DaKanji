import 'package:dakanji_db_core/data/frequency_mode.dart';
import 'package:dakanji_db_core/data/term_meta_entry_types.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';

import '../../dictionary_test_variables.dart';
import 'dictionary_search_test_helper_classes.dart';

// Helper to define the shared meta for Gyoza (Value 3)
final TermMetaBankV3Entry namaGyouzaMeta = TermMetaBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry, 
  type: TermMetaBankEntryTypes.freq,
  frequency: 3,
  term: "生餃子",
  pitchs: [],
  ipas: []
);

// Helper for Ikeru (Value 2)
final TermMetaBankV3Entry ikeruMeta = TermMetaBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  type: TermMetaBankEntryTypes.freq,
  frequency: 2,
  term: "生ける",
  pitchs: [],
  ipas: []
);

List<DictionarySearchTestCase> popularityOverrideTestCases = [
  
  // ---------------------------------------------------------------------------
  // TEST 1: Rank-Based (Lower is Better)
  // Logic: 2 (Ikeru) is BETTER than 3 (Gyoza)
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: '''
    GLOBAL FREQUENCY OVERRIDE TEST (Rank-Based):
    Target: "生"
    Mode: RankBased (Lower number = Better)
    
    Data:
      - 生ける: 2
      - 生餃子: 3
    
    Expectation:
      - 生ける (2) comes FIRST.
      - 生餃子 (3) comes SECOND.
    ''',
    query: "生",
    frequencyModeOverride: FrequencyMode.rankBased,
    queryMatches: [ExpectedMatchGroup(
      prefixMatches: [
        
        // --- 1. RANK 2 (Best Match) ------------------------------------------
        [ExpectedDictionaryMatch(
          term: '生ける',
          reading: 'いける',
          match: '生ける',
          definitions: ['to arrange (flowers)'],
          metas: [ikeruMeta]
        )],

        // --- 2. RANK 3 (Tied Block) ------------------------------------------
        // Sorted by ID: 1 (Dict 2) -> 2 (Dict 1) -> 3 (Dict 3)
        
        // Idx 1: Dict 2
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['2) raw gyoza; uncooked dumplings'], // Dict 2 def
          metas: [namaGyouzaMeta]
        )],
        
        // Idx 2: Dict 1
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['1) raw gyoza; uncooked dumplings'], // Dict 1 def
          metas: [namaGyouzaMeta]
        )],
        
        // Idx 3: Dict 3
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['3) raw gyoza; uncooked dumplings'], // Dict 3 def
          metas: [namaGyouzaMeta]
        )],

        // --- 3. NO RANK (Worst Match) ----------------------------------------
        [ExpectedDictionaryMatch(
          term: '生ビール',
          reading: '',
          match: '生ビール',
          definitions: ['draft beer; draught beer'],
        )],
      ],
    ),]
  ),

  // ---------------------------------------------------------------------------
  // TEST 2: Occurrence-Based (Higher is Better)
  // Logic: 3 (Gyoza) is BETTER than 2 (Ikeru)
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: '''
    GLOBAL FREQUENCY OVERRIDE TEST (Occurrence-Based):
    Target: "生"
    Mode: OccurrenceBased (Higher number = Better)
    
    Data:
      - 生ける: 2
      - 生餃子: 3
    
    Expectation:
      - 生餃子 (3) comes FIRST.
      - 生ける (2) comes SECOND.
    ''',
    query: "生",
    frequencyModeOverride: FrequencyMode.occurrenceBased,
    queryMatches: [ExpectedMatchGroup(
      prefixMatches: [
        
        // --- 1. FREQ 3 (Best Match) ------------------------------------------
        // Sorted by ID: 1 (Dict 2) -> 2 (Dict 1) -> 3 (Dict 3)
        
        // Idx 1: Dict 2
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['2) raw gyoza; uncooked dumplings'], // Dict 2 def
          metas: [namaGyouzaMeta]
        )],
        
        // Idx 2: Dict 1
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['1) raw gyoza; uncooked dumplings'], // Dict 1 def
          metas: [namaGyouzaMeta]
        )],
        
        // Idx 3: Dict 3
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['3) raw gyoza; uncooked dumplings'], // Dict 3 def
          metas: [namaGyouzaMeta]
        )],

        // --- 2. FREQ 2 (Second Best) -----------------------------------------
        [ExpectedDictionaryMatch(
          term: '生ける',
          reading: 'いける',
          match: '生ける',
          definitions: ['to arrange (flowers)'],
          metas: [ikeruMeta]
        )],

        // --- 3. NO DATA (Worst Match) ----------------------------------------
        [ExpectedDictionaryMatch(
          term: '生ビール',
          reading: '',
          match: '生ビール',
          definitions: ['draft beer; draught beer'],
        )],
      ],
    ),]
  ),
];