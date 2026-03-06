

import 'package:da_db/data/term_meta_entry_types.dart';
import 'package:da_db/database/term_meta/term_meta_bank_entry.dart';
import 'package:da_db/database/term_meta/term_meta_bank_ipa_entry.dart';
import 'package:da_db/database/term_meta/term_meta_bank_pitch_entry.dart';

import '../../dictionary_test_variables.dart';
import 'dictionary_search_test_helper_classes.dart';


List<DictionarySearchTestCase> metaBankTestCases = [
  DictionarySearchTestCase(
    description: "Find meta bank entries",
    query: '土木工事',
    queryMatches: [ExpectedMatchGroup(
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
                  // どぼくこうじ = 6 morae
                  // pos 1: Atamadaka -> High drops to Low immediately
                  TermMetaBankV3PitchEntry(position: "HLLLLL", devoice: [12], tags: []),
                  // pos 2: Nakadaka -> Drops after 2nd mora
                  TermMetaBankV3PitchEntry(position: "LHLLLL", nasal: [23], tags: [p1Tag]),
                  // pos 3: Nakadaka -> Drops after 3rd mora
                  TermMetaBankV3PitchEntry(position: "LHHLLL", devoice: [34], tags: []),
                  // pos 4: Nakadaka -> Drops after 4th mora
                  TermMetaBankV3PitchEntry(position: "LHHHLL", devoice: [45], tags: [p1Tag, p2Tag]),
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
                  TermMetaBankV3IpaEntry(ipa: "[laerglaeh]", tags: []),
                  TermMetaBankV3IpaEntry(ipa: "[alsjega]", tags: [tokyoTag]),
                  TermMetaBankV3IpaEntry(ipa: "[laheig]", tags: [testTag, asdTag]),
                ],
              ),
            ],
          ),
        ]
      ],
    )],
  ),
    DictionarySearchTestCase(
    description: "Find meta bank entries that only have term (no reading)",
    query: '石',
    queryMatches: [ExpectedMatchGroup(
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
    )],
  )
];