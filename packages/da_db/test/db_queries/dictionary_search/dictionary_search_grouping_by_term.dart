
import 'package:da_db/database/db_queries/dictionary_search/grouping_rules.dart';

import 'dictionary_search_test_helper_classes.dart';


List<DictionarySearchTestCase> groupByTermTests = [

  DictionarySearchTestCase(
    description: "group everything into one group",
    query: "水餃子",
    groupingRules: [
      TermGroupingRule({1, 2, 3, 4, 5})
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

  DictionarySearchTestCase(
    description: "split into two groups",
    query: "水餃子",
    groupingRules: [
      TermGroupingRule({1, 2}),
      TermGroupingRule({3, 4, 5})
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
        ],
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['3) dumplings cooked in boiling water; boiled dumplings'],
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

  DictionarySearchTestCase(
    description: "Do NOT merge '速い' and '早い' (both read 'はやい') even if they are in the same dictionary/rule",
    query: "はやい", // Search by hiragana to find both
    groupingRules: [
      TermGroupingRule({1}), // Both are in Dict 1
    ],
    queryMatches: [const ExpectedMatchGroup(
      exactMatches: [
        // Group 1: Fast (速い)
        [
          ExpectedDictionaryMatch(
            term: '速い',
            reading: 'はやい',
            definitions: ['fast; quick; rapid'],
            match: 'はやい', // Matches via normalized search or explicit lookup
          ),
        ],
        // Group 2: Early (早い) - Must be a separate group!
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
  description: "Ordering (Term): Partial Rule. Dict 3 (Excluded) must stay above Dict 4+5 (Grouped).",
  query: "帽子",
  groupingRules: [
    // We only tell the system to group 4 and 5.
    // Dict 3 is intentionally left out to see if it maintains its rank.
    TermGroupingRule({4, 5}),
  ],
  queryMatches: [const ExpectedMatchGroup(
    exactMatches: [
      // Rank 1: Dict 3 (Stays at top because ID 3 < ID 4)
      [
        ExpectedDictionaryMatch(
          term: '帽子',
          reading: 'ぼうし',
          definitions: ['hat; cap (dict 3)'], // Dict 3
          match: '帽子',
        ),
      ],
      // Rank 2: Dict 4 & 5 (Merged)
      // Dict 4 establishes this group's position. Dict 5 joins it.
      [
        ExpectedDictionaryMatch(
          term: '帽子',
          reading: 'ぼうし',
          definitions: ['hat; cap (dict 4)'], // Dict 4 (Leader)
          match: '帽子',
        ),
        ExpectedDictionaryMatch(
          term: '帽子',
          reading: 'ぼうし',
          definitions: ['hat; cap (dict 5)'], // Dict 5 (Joiner)
          match: '帽子',
        ),
      ],
    ],
  )],
),

];