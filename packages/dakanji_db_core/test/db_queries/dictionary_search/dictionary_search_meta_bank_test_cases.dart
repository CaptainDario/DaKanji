

import 'package:dakanji_db_core/data/term_meta_entry_types.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_ipa_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_pitch_entry.dart';

import '../../dictionary_test_variables.dart';
import 'dictionary_search_test_helper_classes.dart';


List<ExpectedDictionarySearchResult> metaBankTestCases = [
  ExpectedDictionarySearchResult(
    description: "Find meta bank entries",
    query: '土木工事',
    tags: [],
    queryMatches: ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(
            term: '土木工事',
            reading: 'どぼくこうじ',
            match: '土木工事',
            definitions: ["civil engineering works; public works"],
            metas: [
              TermMetaBankV3Entry(
                id: 0,
                indexEntry: testDictionaryIndexEntry,
                term: '土木工事',
                reading: 'どぼくこうじ',
                type: TermMetaBankEntryTypes.pitch,
                pitchs: [
                  TermMetaBankV3PitchEntry(position: 1, devoice: 12),
                  TermMetaBankV3PitchEntry(position: 2, nasal: 23, tags: [p1Tag]),
                  TermMetaBankV3PitchEntry(position: 3, devoice: 34),
                  TermMetaBankV3PitchEntry(position: 4, devoice: 45, tags: [p1Tag, p2Tag]),
                ],
                ipas: []
              ),
              TermMetaBankV3Entry(
                id: 0,
                indexEntry: testDictionaryIndexEntry,
                term: '土木工事',
                reading: 'どぼくこうじ',
                type: TermMetaBankEntryTypes.ipa,
                pitchs: [],
                ipas: [
                  TermMetaBankV3IpaEntry(ipa: "[sɨᵝkʲi]", tags: [tokyoTag, kyotoTag]),
                  TermMetaBankV3IpaEntry(ipa: "[laerglaeh]"),
                  TermMetaBankV3IpaEntry(ipa: "[alsjega]", tags: [tokyoTag]),
                  TermMetaBankV3IpaEntry(ipa: "[laheig]", tags: [testTag, asdTag]),
                ],
              ),
            ],
          ),
        ]
      ],
    ),
  ),
    ExpectedDictionarySearchResult(
    description: "Find meta bank entries that only have term (no reading)",
    query: '石',
    tags: [],
    queryMatches: ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(
            term: '石',
            reading: 'いし',
            match: '石',
            definitions: ["rock", "stone"],
            metas: [
              TermMetaBankV3Entry(
                id: 0,
                indexEntry: testDictionaryIndexEntry,
                term: '石',
                type: TermMetaBankEntryTypes.freq,
                frequency: 3,
                pitchs: [],
                ipas: []
              ),
              TermMetaBankV3Entry(
                id: 0,
                indexEntry: testDictionaryIndexEntry,
                term: '石',
                type: TermMetaBankEntryTypes.freq,
                frequency: 7,
                frequencyDisplayValue: "seven",
                pitchs: [],
                ipas: []
              ),
              TermMetaBankV3Entry(
                id: 0,
                indexEntry: testDictionaryIndexEntry,
                term: '石',
                reading: "いし",
                type: TermMetaBankEntryTypes.freq,
                frequency: 12,
                pitchs: [],
                ipas: []
              ),
              TermMetaBankV3Entry(
                id: 0,
                indexEntry: testDictionaryIndexEntry,
                term: '石',
                reading: "いし",
                type: TermMetaBankEntryTypes.freq,
                frequency: 18,
                frequencyDisplayValue: "eighteen",
                pitchs: [],
                ipas: []
              ),
            ],
          ),
        ]
      ],
    ),
  )
];