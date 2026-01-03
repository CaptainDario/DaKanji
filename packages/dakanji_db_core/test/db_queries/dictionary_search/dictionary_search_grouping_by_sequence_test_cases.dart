import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';

import '../../dictionary_test_variables.dart';
import 'dictionary_search_test_helper_classes.dart';



List<DictionarySearchTestCase> groupBySequenceTests = [

  // ---------------------------------------------------------------------------
  // TEST 1: Basic Sequence grouping (Same term found via sequence)
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "The entries with the same sequence number as 食べる should be grouped together.",
    query: "食べる",
    groupingRules: [
      SequenceGroupingRule(
        sourceDictId: 2, // Dict 1 (Index 2) is the Source
        targetDictIds: {1, 2, 3, 4, 5}
      ),
    ],
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(
            term: '食べる',
            reading: 'たべる',
            definitions: ['to eat'],
            match: '食べる',
          ),
          ExpectedDictionaryMatch(
            term: '食べます',
            reading: 'たべます',
            definitions: ['to eat (polite)'],
            match: 'Sequence number',
          ),
          ExpectedDictionaryMatch(
            term: '召し上がる',
            reading: 'めしあがる',
            definitions: ['to eat (honorific)', 'to eat'],
            match: 'Sequence number',
          ),
        ],
      ],
      prefixMatches: [
        [
          ExpectedDictionaryMatch(
            term: '食べるラー油',
            reading: 'たべるらーゆ',
            definitions: ['chili oil with garlic, etc. for eating with rice'],
            match: '食べるラー油',
          ),
        ]
      ]
    ),
  ),

  // ---------------------------------------------------------------------------
  // TEST 2: Basic Expansion
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Expand '生餃子' from Source(1) with definitions from Target(2, 3)"
      "Direct search matches (生餃子 from Dict 1,2,3) should appear before sequence match '帽子' from Dict 4",
    query: "生餃子",
    groupingRules: [
      SequenceGroupingRule(
        sourceDictId: 1, // Dict 1 (Index 2) - Seq 803
        targetDictIds: {2, 3} // Dict 2 (Index 1), Dict 3 (Index 3) - Seq 803
      ),
    ],
    queryMatches: ExpectedMatchGroup(
      exactMatches: [
        [
          // 1. The Source Match (Root) from Dict 1 (Index 2)
          ExpectedDictionaryMatch(
            term: '生餃子',
            reading: 'なまぎょうざ',
            definitions: ['2) raw gyoza; uncooked dumplings'],
            match: '生餃子',
            metas: [namaGyouzaMeta]
          ),
          // 2. Target Match 1 from Dict 2 (Index 1)
          ExpectedDictionaryMatch(
            term: '生餃子',
            reading: 'なまぎょうざ',
            definitions: ['1) raw gyoza; uncooked dumplings'],
            match: '生餃子',
            metas: [namaGyouzaMeta]
          ),
          // 3. Target Match 2 from Dict 3 (Index 3)
          ExpectedDictionaryMatch(
            term: '生餃子',
            reading: 'なまぎょうざ',
            definitions: ['3) raw gyoza; uncooked dumplings'],
            match: '生餃子', 
            metas: [namaGyouzaMeta]
          ),
          ExpectedDictionaryMatch(
            term: "帽子",
            reading: "ぼうし",
            definitions: ["hat; cap (dict 3)"],
            match: "Sequence number"
          )
        ],
      ],
    ),
  ),

  // ---------------------------------------------------------------------------
  // TEST 3: Filter Unwanted Dictionaries (Split Behavior)
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Expand '生餃子' from Source(1) using ONLY Target(2). "
    "Dict 3 appears separately as it is excluded from Targets. "
    " This also checks that a target dict can 'start' a sequence group.",
    query: "生餃子",
    groupingRules: [
      SequenceGroupingRule(
        sourceDictId: 2, // Dict 1 (Index 2)
        targetDictIds: {1} // Only Dict 2 (Index 1). Dict 3 (Index 3) is excluded.
      ),
    ],
    queryMatches: ExpectedMatchGroup(
      exactMatches: [
        // GROUP 1: The Merged Sequence Group (Source + Allowed Target)
        [
          ExpectedDictionaryMatch(
            term: '生餃子',
            reading: 'なまぎょうざ',
            definitions: ['2) raw gyoza; uncooked dumplings'],
            match: '生餃子',
            metas: [namaGyouzaMeta]
          ),
          ExpectedDictionaryMatch(
            term: '生餃子',
            reading: 'なまぎょうざ',
            definitions: ['1) raw gyoza; uncooked dumplings'],
            match: '生餃子',
            metas: [namaGyouzaMeta]
          ),
        ],
        // GROUP 2: The "Excluded" Dictionary 3 Match (Index 3)
        // Since it matched the search text "生餃子" but wasn't in the Target list,
        // it appears as a standalone, unmerged result.
        [
          ExpectedDictionaryMatch(
            term: '生餃子',
            reading: 'なまぎょうざ',
            definitions: ['3) raw gyoza; uncooked dumplings'],
            match: '生餃子',
            metas: [namaGyouzaMeta]
          ),
        ]
      ],
    ),
  ),

  // ---------------------------------------------------------------------------
  // TEST 4: Sequence Mismatch (Both appear as separate groups)
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Show separate groups for '水餃子' if sequences differ (Source:999 vs Target:998"
      "and dict 4 with same seq as target is not included).",
    query: "水餃子",
    groupingRules: [
      SequenceGroupingRule(
        sourceDictId: 2, // Dict 1 (Index 2) - Seq 999
        targetDictIds: {1} // Dict 2 (Index 1) - Seq 998
      ),
    ],
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        // Group 1: Source Dictionary Match (Dict 1 - Seq 999)
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['2) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
        ],
        // Group 2: Target Dictionary Match (Dict 2 - Seq 998)
        // Stays separate because Seq 998 != Seq 999
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['1) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
        ],
        // Group 3: Target Dictionary Match (Dict 3 - Seq 997)
        // Stays separate because Seq 997 != Seq 999
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['3) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
        ],
        // Group 4: Target Dictionary Match (Dict 4 - Seq 999)
        // Stays separate because dict 4 is not included in the Target list
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'みずぎょうざ',
            definitions: ['4) common misspelling of 水餃子'],
            match: '水餃子',
          ),
        ],
      ],
    ),
  ),

  // ---------------------------------------------------------------------------
  // TEST 5: Successful Expansion via Alternate Source
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Merge '水餃子' when Source(2) and Target(4) share sequence 998",
    query: "水餃子",
    groupingRules: [
      SequenceGroupingRule(
        sourceDictId: 1, // Dict 2 (Index 1) - Seq 998
        targetDictIds: {4} // Dict 4 (Index 4) - Seq 998
      ),
    ],
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['2) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'みずぎょうざ', // Reading in Dict 4 is different
            definitions: ['4) common misspelling of 水餃子'],
            match: '水餃子',
          ),
        ],
        // Stays separate because Seq 998 != Seq 999
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['1) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
        ],
        // Stays separate because Seq 997 != Seq 999
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['3) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
        ],
      ],
    ),
  ),

  // ---------------------------------------------------------------------------
  // TEST 6: Sequence Collision (Different Terms)
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Merge different terms ('生餃子' and '帽子') if they share the same sequence (803)",
    query: "生餃子",
    groupingRules: [
      SequenceGroupingRule(
        sourceDictId: 2, // Dict 1 (Index 2) - Seq 803
        targetDictIds: {4} // Dict 4 (Index 4) - Seq 803
      ),
    ],
    queryMatches: ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(
            term: '生餃子',
            reading: 'なまぎょうざ',
            definitions: ['2) raw gyoza; uncooked dumplings'],
            match: '生餃子',
            metas: [namaGyouzaMeta]
          ),
        ],
        [
          ExpectedDictionaryMatch(
            term: '生餃子',
            reading: 'なまぎょうざ',
            definitions: ['1) raw gyoza; uncooked dumplings'],
            match: '生餃子',
            metas: [namaGyouzaMeta]
          ),
          ExpectedDictionaryMatch(
            term: '帽子', 
            reading: 'ぼうし',
            definitions: ['hat; cap (dict 4)'],
            match: 'Sequence number',
          ),
        ],
        [
          ExpectedDictionaryMatch(
            term: '生餃子',
            reading: 'なまぎょうざ',
            definitions: ['3) raw gyoza; uncooked dumplings'],
            match: '生餃子',
            metas: [namaGyouzaMeta]
          ),
        ]
      ],
    ),
  ),

  // ---------------------------------------------------------------------------
  // TEST 7: Source Dictionary Constraint (Fallback to Raw)
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Term '帽子' is not in Source (2), therefore no grouping occurs.",
    query: "帽子",
    groupingRules: [
      SequenceGroupingRule(
        sourceDictId: 2, // Dict 1 (Index 2) does NOT have '帽子'
        targetDictIds: {3, 4, 5} // Dict 4 (Index 4) & 5 (Index 5) have it
      ),
    ],
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        // Match from Dict 3 (Index 3)
        [
          ExpectedDictionaryMatch(
            term: '帽子',
            reading: 'ぼうし',
            definitions: ['hat; cap (dict 3)'],
            match: '帽子',
          ),
        ],
        // Match from Dict 4 (Index 4)
        [
          ExpectedDictionaryMatch(
            term: '帽子',
            reading: 'ぼうし',
            definitions: ['hat; cap (dict 4)'],
            match: '帽子',
          ),
        ],
        // Match from Dict 5 (Index 5)
        [
          ExpectedDictionaryMatch(
            term: '帽子',
            reading: 'ぼうし',
            definitions: ['hat; cap (dict 5)'],
            match: '帽子',
          ),
        ],
      ], 
    ),
  ),

  // ---------------------------------------------------------------------------
  // TEST 8: Frequency Sorting Across Sequence Groups
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Sequence grouping should not affect frequency-based sorting "
      "ungrouped results. "
      "This also tests that results are deduplicated correctly when grouping is "
      "applied. "
      "Also tests that no goruping happens when no target dicts are specified.",
    // Use a 2-char string to trigger prefix search
    query: "食べ", 
    groupingRules: [
      SequenceGroupingRule(
        sourceDictId: 2, 
        targetDictIds: {}
      ),
    ],
    queryMatches: const ExpectedMatchGroup(
      prefixMatches: [
        // Rank 1: 食べる (Freq 100)
        [
          ExpectedDictionaryMatch(
            term: '食べる',
            reading: 'たべる',
            definitions: ['to eat'],
            match: '食べる',
          ),
        ],
        // Rank 2: 食べ物 (Freq 90)
        [
          ExpectedDictionaryMatch(
            term: '食べ物',
            reading: 'たべもの',
            definitions: ['food'],
            match: '食べ物',
          ),
        ],
        // Rank 3: 食べます (Freq 80)
        [
          ExpectedDictionaryMatch(
            term: '食べます',
            reading: 'たべます',
            definitions: ['to eat (polite)'],
            match: '食べます',
          ),
        ],
         // Rank 4: 食べるラー油 (Freq 50)
        [
          ExpectedDictionaryMatch(
            term: '食べるラー油',
            reading: 'たべるらーゆ',
            definitions: ['chili oil with garlic, etc. for eating with rice'],
            match: '食べるラー油',
          ),
        ],
      ],
    ),
  ),
  // ---------------------------------------------------------------------------
  // TEST 9: Sequence Grouping Restriction (Excluded source Dictionary when not in target list)
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Sequence Grouping Restriction: '帽子' in Dict 3 (Primary) "
      "merges Dict 4 (Allowed Secondary), but other entries from dict 3 with "
      "the same sequence number do not merge as they are not in the allowed "
      "list (bank_3: 生餃子). ",
    query: "帽子",
    groupingRules: [
      SequenceGroupingRule(
        sourceDictId: 3, // Dict 3 (Index 3) starts the group
        targetDictIds: {4} // Only Dict 4 (Index 4) is allowed to join. Dict 5 is excluded.
      ),
    ],
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        // GROUP 1: The Valid Sequence Group
        // Dict 3 establishes the group. Dict 4 is on the allow-list, so it merges.
        [
          ExpectedDictionaryMatch(
            term: '帽子',
            reading: 'ぼうし',
            definitions: ['hat; cap (dict 3)'], // Anchor [cite: 55]
            match: '帽子',
          ),
          ExpectedDictionaryMatch(
            term: '帽子',
            reading: 'ぼうし',
            definitions: ['hat; cap (dict 4)'], // Merged [cite: 53]
            match: '帽子',
          ),
        ],
        
        // GROUP 2: Excluded Dictionary Match
        [
          ExpectedDictionaryMatch(
            term: '帽子',
            reading: 'ぼうし',
            definitions: ['hat; cap (dict 5)'], // Standalone [cite: 54]
            match: '帽子',
          ),
        ],
      ],
    ),
  ),
];