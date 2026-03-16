import '../../dictionary_test_variables.dart';
import 'dictionary_search_test_helper_classes.dart';



List<DictionarySearchTestCase> sortingTestCases = [
  DictionarySearchTestCase(
    description: 'popularity for identical reading matches',
    query: 'はやい',
    queryMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          // '速い' (freq: 93) should come before '早い' (freq: 23)
          [ExpectedDictionaryMatch(term: '速い', reading: 'はやい', match: 'はやい', definitions: ["fast; quick; rapid"])],
          [ExpectedDictionaryMatch(term: '早い', reading: 'はやい', match: 'はやい', definitions: ["early; premature"])],
        ],
      ),
    ]
  ),

  // Length Difference
  DictionarySearchTestCase(
    description: 'length difference for prefix matches',
    query: '電車',
    queryMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          [ExpectedDictionaryMatch(term: '電車', reading: 'でんしゃ', match: '電車', definitions: ["(electric) train"])],
        ],
        prefixMatches: [
          // Length of '電車' (2) is closer to query '電' (1) than '電車賃' (3)
          [ExpectedDictionaryMatch(term: '電車賃', reading: 'でんしゃちん', match: '電車賃', definitions: ["train fare"])],
          [ExpectedDictionaryMatch(term: '電車酔い', reading: 'でんしゃよい', match: '電車酔い', definitions: ["train sickness; motion sickness on a train"])],
          [ExpectedDictionaryMatch(term: '電車道相撲', reading: 'でんしゃみちすもう', match: '電車道相撲', definitions: ["railroading an opponent straight out of the ring​"])],
        ],
        tokenMatches: [
          [ExpectedDictionaryMatch(term: '満員電車', reading: 'まんいんでんしゃ', match: '満員電車', definitions: ["crowded train; packed train"])],
        ]
      ),
    ]
  ),

  // Test for Length Difference as a Tie-Breaker
  DictionarySearchTestCase(
    description: 'length difference when popularity is equal',
    query: 'にほん',
    groupingRules: [],
    queryMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          // Exact matches still come first.
          [ExpectedDictionaryMatch(term: '日本', reading: 'にほん', match: 'にほん', definitions: ["Japan"])], // pop 99
          [ExpectedDictionaryMatch(term: '二本', reading: 'にほん', match: 'にほん', definitions: ["two long objects"])], // pop 80
        ],
        prefixMatches: [
          // All three prefix matches below have the same popularity (95).
          // Rule 6 (length difference) is now used to sort them.
          // We assume length refers to the term's character count.

          // '日本人' and '日本酒' are both 3 characters long, so they come before the 4-character term.
          // The tie between them is broken by the final rule ('alphabetical').
          // '日本酒' comes before '日本人'.
          [ExpectedDictionaryMatch(term: '日本酒', reading: 'にほんしゅ', match: 'にほんしゅ', definitions: ["sake; Japanese rice wine"])], // pop 95, length 3
          [ExpectedDictionaryMatch(term: '日本人', reading: 'にほんじん', match: 'にほんじん', definitions: ["Japanese person"])], // pop 95, length 3
          
          // '日本晴れ' comes last because it is the longest term (4 characters).
          [ExpectedDictionaryMatch(term: '日本晴れ', reading: 'にほんばれ', match: 'にほんばれ', definitions: ["clear weather; cloudless sky"])], // pop 95, length 4
        ],
        tokenMatches: [
          [ExpectedDictionaryMatch(term: '全日本', reading: 'ぜんにほん', match: 'ぜんにほん', definitions: ["all Japan"])],
        ]
      ),
    ]
  ),
  DictionarySearchTestCase(
    description: '''Three imported dictionaries should have their user defined sort orders applied correctly''',
    query: "生餃子",
    queryMatches: [ExpectedMatchGroup(
      exactMatches: [
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['2) raw gyoza; uncooked dumplings'],
          metas: [namaGyouzaMeta]
        )],
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['1) raw gyoza; uncooked dumplings'],
          metas: [namaGyouzaMeta]
        )],
        [ExpectedDictionaryMatch(
          term: '生餃子',
          reading: 'なまぎょうざ',
          match: '生餃子',
          definitions: ['3) raw gyoza; uncooked dumplings'],
          metas: [namaGyouzaMeta]
        )],
      ],
    ),]
  ),

  DictionarySearchTestCase(
    description: 'Definition Rank Sort: Primary definitions (Rank 0) > Rank 2 > Rank 4 > Rank 5',
    query: 'Game',
    queryMatches: [
      const ExpectedMatchGroup(
        // All are "Exact Matches" because the Definition text "Game" == Query "Game"
        exactMatches: [
          // ---------------------------------------------------------
          // Rank 0 Matches (Primary Definition is "Game")
          // Sorted by internal ID (Tie)
          // ---------------------------------------------------------
          [ExpectedDictionaryMatch(
            term: 'Sport', 
            reading: 'sport', 
            match: 'Game', 
            definitions: ["Game"]
          )],
          [ExpectedDictionaryMatch(
            term: 'Contest', 
            reading: 'contest', 
            match: 'Game', 
            definitions: ["Game"]
          )],
          [ExpectedDictionaryMatch(
            term: 'Match', 
            reading: 'match', 
            match: 'Game', 
            definitions: ["Game"]
          )],

          // ---------------------------------------------------------
          // Rank 2 Matches (3rd Definition is "Game")
          // ---------------------------------------------------------
          [ExpectedDictionaryMatch(
            term: 'Fun', 
            reading: 'fun', 
            match: 'Game', 
            definitions: ["Amusement", "Play", "Game"]
          )],

          // ---------------------------------------------------------
          // Rank 4 Matches (5th Definition is "Game")
          // ---------------------------------------------------------
          [ExpectedDictionaryMatch(
            term: 'Group', 
            reading: 'group', 
            match: 'Game', 
            definitions: ["Cluster", "Batch", "Lot", "Set", "Game"]
          )],

          // ---------------------------------------------------------
          // Rank 5 Match (6th Definition is "Game")
          // ---------------------------------------------------------
          [ExpectedDictionaryMatch(
            term: 'Set', 
            reading: 'set', 
            match: 'Game', 
            definitions: ["Collection", "Place", "Ready", "Go", "Just some filler", "Game"]
          )],
        ],
        prefixMatches: [

          [ExpectedDictionaryMatch(
            term: 'Activity', 
            reading: 'activity', 
            match: 'Game (non exact match)', 
            definitions: ["Action", "Movement", "Game (non exact match)"]
          )],
          [ExpectedDictionaryMatch(
            term: 'Collection', 
            reading: 'collection', 
            match: 'Game (non exact match)', 
            definitions: ["Gathering", "Assembly", "Heap", "Pile", "Game (non exact match)"]
          )],
        ]
      ),
    ]
  ),
];