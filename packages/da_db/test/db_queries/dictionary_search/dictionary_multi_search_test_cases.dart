import 'package:da_db/database/db_queries/dictionary_search/grouping_rules.dart';

import 'dictionary_search_test_helper_classes.dart';

List<DictionarySearchTestCase> multiSearchTestCases = [

  // ---------------------------------------------------------------------------
  // TEST 1: Basic Multi-Term Search
  // Purpose: Verify that searching for two distinct terms returns two distinct 
  // groups in the correct order.
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Basic Multi-Term: '食べる' and '電車'",
    query: "?q=食べる&q=電車", // This string is split by the logic before search, effectively ["食べる", "電車"]
    // Note: The 'queryMatches' list order corresponds to the input order.
    queryMatches: [
      // Group 1: '食べる'
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(
              term: '食べる', 
              reading: 'たべる', 
              match: '食べる', 
              definitions: ["to eat"]
            ),
          ]
        ],
        prefixMatches: [
           [
            ExpectedDictionaryMatch(
              term: '食べるラー油', 
              reading: 'たべるらーゆ', 
              match: '食べるラー油',
              definitions: ["chili oil with garlic, etc. for eating with rice"]
            )
          ]
        ]
      ),
      // Group 2: '電車'
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(
              term: '電車', 
              reading: 'でんしゃ', 
              match: '電車', 
              definitions: ["(electric) train"]
            ),
          ]
        ],
        prefixMatches: [
          [
            ExpectedDictionaryMatch(
              term: '電車賃', 
              reading: 'でんしゃちん', 
              match: '電車賃', 
              definitions: ["train fare"]
            ),
          ],
          [ExpectedDictionaryMatch(
            term: '電車酔い',
            reading: 'でんしゃよい',
            match: '電車酔い',
            definitions: ["train sickness; motion sickness on a train"]
          )],
          [ExpectedDictionaryMatch(
            term: '電車道相撲',
            reading: 'でんしゃみちすもう',
            match: '電車道相撲',
            definitions: ["railroading an opponent straight out of the ring​"]
          )],
        ],
        tokenMatches: [
          [ExpectedDictionaryMatch(
            term: '満員電車',
            reading: 'まんいんでんしゃ',
            match: '満員電車',
            definitions: ["crowded train; packed train"]
          )],
        ]
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // TEST 2: Order Verification (Reverse)
  // Purpose: Confirm that swapping the input string swaps the result order.
  // Compare with Test 1 ("食べる 電車").
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Order Verification: '電車' then '食べる'",
    query: "?q=電車&q=食べる", 
    queryMatches: [
      // Group 1: '電車' (Must be first now)
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(
              term: '電車', 
              reading: 'でんしゃ', 
              match: '電車', 
              definitions: ["(electric) train"]
            ),
          ]
        ],
        prefixMatches: [
          [
            ExpectedDictionaryMatch(
              term: '電車賃', 
              reading: 'でんしゃちん', 
              match: '電車賃', 
              definitions: ["train fare"]
            ),
          ],
          [ExpectedDictionaryMatch(
            term: '電車酔い',
            reading: 'でんしゃよい',
            match: '電車酔い',
            definitions: ["train sickness; motion sickness on a train"]
          )],
          [ExpectedDictionaryMatch(
            term: '電車道相撲',
            reading: 'でんしゃみちすもう',
            match: '電車道相撲',
            definitions: ["railroading an opponent straight out of the ring​"]
          )],
        ],
        tokenMatches: [
          [ExpectedDictionaryMatch(
            term: '満員電車',
            reading: 'まんいんでんしゃ',
            match: '満員電車',
            definitions: ["crowded train; packed train"]
          )],
        ]
      ),
      // Group 2: '食べる' (Must be second now)
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(
              term: '食べる', 
              reading: 'たべる', 
              match: '食べる', 
              definitions: ["to eat"]
            ),
          ]
        ],
        prefixMatches: [
           [
            ExpectedDictionaryMatch(
              term: '食べるラー油', 
              reading: 'たべるらーゆ', 
              match: '食べるラー油',
              definitions: ["chili oil with garlic, etc. for eating with rice"]
            )
          ]
        ]
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // TEST 3: Mixed Match Types (Kanji + Hiragana)
  // Purpose: Verify one term matching by kanji and another matching by reading
  // works in a single request.
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Mixed Types: '人' (Kanji) and 'たべる' (Hiragana)",
    query: "?q=人&q=たべる",
    queryMatches: [
      // Group 1: '人' (Exact Kanji match)
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(
              term: '人', 
              reading: 'じん', 
              match: '人', 
              definitions: ["Person"]
            )
          ]
        ],
        tokenMatches: [
          [ExpectedDictionaryMatch(term: '中国人', reading: 'ちゅうごくじん', match: '中国人', definitions: ["Chinese person"])],
          [ExpectedDictionaryMatch(term: '日本人', reading: 'にほんじん', match: '日本人', definitions: ["Japanese person"])],
          [ExpectedDictionaryMatch(term: 'ドイツ人', reading: 'どいつじん', match: 'ドイツ人', definitions: ["Eine deutsche Person"])]
        ],
      ),
      // Group 2: 'たべる' (Exact Reading match)
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(
              term: '食べる', 
              reading: 'たべる', 
              match: 'たべる', 
              definitions: ["to eat"]
            ),
          ]
        ],
        prefixMatches: [
           [
            ExpectedDictionaryMatch(
              term: '食べるラー油', 
              reading: 'たべるらーゆ', 
              match: 'たべるらーゆ',
              definitions: ["chili oil with garlic, etc. for eating with rice"]
            )
          ]
        ]
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // TEST 4: Multi-Term with Grouping Rules
  // Purpose: Ensure grouping rules are applied correctly to each term's results.
  // - '水餃子' should group all 4 dictionaries.
  // - '帽子' should group dicts 4 & 5.
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Multi-Term with Grouping: '水餃子' (Group All) and '帽子' (Group 4&5)",
    query: "?q=水餃子&q=帽子",
    groupingRules: [
      TermGroupingRule({1, 2, 3, 4, 5}), // Merge everything for 水餃子
      TermGroupingRule({4, 5}),          // Merge 4&5 for 帽子
    ],
    queryMatches: [
      // Group 1: '水餃子' (Merged into one big group)
      const ExpectedMatchGroup(
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
        ]
      ),
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(
              term: '帽子',
              reading: 'ぼうし',
              definitions: ['hat; cap (dict 3)'],
              match: '帽子',
            ),
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
      ),
    ],
    
  ),

  // ---------------------------------------------------------------------------
  // TEST 5: Partial Failure (Valid + Invalid Term)
  // Purpose: Verify that a nonsense term doesn't break the valid term's results.
  // ---------------------------------------------------------------------------
  DictionarySearchTestCase(
    description: "Partial Failure: 'xyz_nonsense' and '食べる'",
    query: "?q=xyz_nonsense&q=食べる",
    queryMatches: [
      // Group 1: 'xyz_nonsense' (No matches expected)      
      // Group 2: Valid
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(
              term: '食べる', 
              reading: 'たべる', 
              match: '食べる', 
              definitions: ["to eat"]
            ),
          ]
        ],
        prefixMatches: [
           [
            ExpectedDictionaryMatch(
              term: '食べるラー油', 
              reading: 'たべるらーゆ', 
              match: '食べるラー油',
              definitions: ["chili oil with garlic, etc. for eating with rice"]
            )
          ]
        ]
      ),
    ],
  ),
];