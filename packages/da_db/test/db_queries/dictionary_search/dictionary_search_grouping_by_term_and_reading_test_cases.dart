
import 'package:da_db/database/db_queries/dictionary_search/grouping_rules.dart';

import 'dictionary_search_test_helper_classes.dart';



List<DictionarySearchTestCase> groupByTermAndReadingTests = [

  DictionarySearchTestCase(
    description: "query 水餃子",
    query: "水餃子",
    groupingRules: [
      TermAndReadingGroupingRule({1, 2, 3, 4, 5})
    ],
    queryMatches: [const ExpectedMatchGroup(
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
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'みずぎょうざ',
            definitions: ['4) common misspelling of 水餃子'],
            match: '水餃子',
          ),
        ]
      ],
    )],
  ),

  DictionarySearchTestCase(
    description: "homonym separation: '速い' and '早い' (both read 'はやい') must NOT merge",
    query: "はやい", // Search by hiragana to find both
    groupingRules: [
      TermAndReadingGroupingRule({1}), // Both are in Dict 1
    ],
    queryMatches: [const ExpectedMatchGroup(
      exactMatches: [
        // Group 1: Fast (速い)
        [
          ExpectedDictionaryMatch(
            term: '速い',
            reading: 'はやい',
            definitions: ['fast; quick; rapid'],
            match: 'はやい',
          ),
        ],
        // Group 2: Early (早い) - Must be separate!
        [
          ExpectedDictionaryMatch(
            term: '早い',
            reading: 'はやい',
            definitions: ['early; premature'],
            match: 'はやい',
          ),
        ],
      ],
    )],
  ),

  DictionarySearchTestCase(
    description: "Group by Term+Reading 3 (Mixed): Merge Dict 1 & 2 (Rule Applied), but keep Dict 3 separate (No Rule)",
    query: "水餃子",
    groupingRules: [
      // Only Dict 1 and 2 are in the rule. Dict 3 is excluded.
      TermAndReadingGroupingRule({1, 2}), 
    ],
    queryMatches: [const ExpectedMatchGroup(
      exactMatches: [
        // Group 1: Merged (Dict 1 & 2)
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
            definitions: ['1) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
        ],
        // Group 2: Standalone (Dict 3)
        // Because Dict 3 isn't in the rule, it falls into the "default bucket" and is not merged.
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['3) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
        ],
        // Group 3: Standalone (Dict 4 - Different reading)
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'みずぎょうざ',
            definitions: ['4) common misspelling of 水餃子'],
            match: '水餃子',
          ),
        ]
      ],
    )],
  ),

  DictionarySearchTestCase(
    description: "Ordering (Term+Reading): Partial Rule. Dict 3 (Excluded) must stay above Dict 4+5 (Grouped).",
    query: "帽子",
    groupingRules: [
      // Only group 4 and 5 if Term AND Reading match.
      // Dict 3 is excluded.
      TermAndReadingGroupingRule({4, 5}),
    ],
    queryMatches: [const ExpectedMatchGroup(
      exactMatches: [
        // Rank 1: Dict 3
        [
          ExpectedDictionaryMatch(
            term: '帽子',
            reading: 'ぼうし',
            definitions: ['hat; cap (dict 3)'],
            match: '帽子',
          ),
        ],
        // Rank 2: Dict 4 & 5
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
];