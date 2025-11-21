import 'package:dakanji_db_core/data/term_meta_entry_types.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';

import '../../dictionary_test_variables.dart';
import 'dictionary_search_test_helper_classes.dart';

List<ExpectedDictionarySearchResult> deconjugationTestCases = [
  ExpectedDictionarySearchResult(
    description: 'Deconjugation: polite form',
    query: '食べます',
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(term: '食べます', reading: 'たべます', match: '食べます', definitions: ["to eat (polite)"]),
        ]
      ],
    ),
    queryVariantMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: '食べる', reading: 'たべる', match: '食べる', definitions: ["to eat"]),
          ]
        ],
        prefixMatches: [
          [
            ExpectedDictionaryMatch(term: '食べるラー油', reading: 'たべるらーゆ', match: '食べるラー油', definitions: ["chili oil with garlic, etc. for eating with rice"])
          ]
        ],
      )
    ],
  ),
  ExpectedDictionarySearchResult(
    description: 'Deconjugation: ambiguous potential form',
    query: 'いける',
    queryMatches: ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(
            term: '生ける',
            reading: 'いける',
            match: 'いける',
            definitions: ["to arrange (flowers)"],
            metas: [
              TermMetaBankV3Entry(
                id: 0,
                indexEntry: testDictionaryIndexEntry,
                term: "生ける",
                frequency: 2,
                type: TermMetaBankEntryTypes.freq,
                pitchs: [],
                ipas: []
              )
            ]
          ),
        ]
      ],
    ),
    queryVariantMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: '行く', reading: 'いく', match: 'いく', definitions: ["to go"]),
          ]
        ],
      )
    ],
  ),
  ExpectedDictionarySearchResult(
    description: 'Deconjugation: ambiguous negative form',
    query: 'ぶれない',
    queryVariantMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: 'ぶれる', reading: 'ぶれる', match: 'ぶれる', definitions: ["to be blurred", "to be shaky"]),
          ]
        ],
      ),
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(term: '振る', reading: 'ぶる', match: 'ぶる', definitions: ["to wave", "to shake", "to wield"]),
          ]
        ],
      )
    ],
  ),
];