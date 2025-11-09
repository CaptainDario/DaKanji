

import 'package:dakanji_db_core/database/term_meta/term_meta_bank_ipa_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_pitch_entry.dart';

import '../../test_dictionary_variables.dart';
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
              (
                [
                  TermMetaBankV3PitchEntry(position: 1, devoice: 12),
                  TermMetaBankV3PitchEntry(position: 2, nasal: 23, tags: [p1Tag]),
                  TermMetaBankV3PitchEntry(position: 3, devoice: 34),
                  TermMetaBankV3PitchEntry(position: 4, devoice: 45, tags: [p1Tag, p2Tag]),
                ],
                []
              ),
              (
                [],
                [
                  TermMetaBankV3IpaEntry(ipa: "[sɨᵝkʲi]", tags: [tokyoTag, kyotoTag]),
                  TermMetaBankV3IpaEntry(ipa: "[laerglaeh]"),
                  TermMetaBankV3IpaEntry(ipa: "[alsjega]", tags: [tokyoTag]),
                  TermMetaBankV3IpaEntry(ipa: "[laheig]", tags: [testTag, asdTag]),
                ]
              )
            ],
          ),
        ]
      ],
    ),
  )
];