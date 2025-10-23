

import 'package:dakanji_db_core/database/term_meta/term_meta_bank_ipa_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_pitch_entry.dart';

import 'dictionary_search_test_helper_classes.dart';

List<SearchTestCase> metaBankTestCases = [
  SearchTestCase(
    description: "Find meta bank entries",
    query: '土木工事',
    tags: [],
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        ExpectedSearchResult(
          term: '土木工事',
          reading: 'どぼくこうじ',
          match: '土木工事',
          definitions: ["civil engineering works; public works"],
          metas: [
            (
              [
                TermMetaBankV3PitchEntry(position: 1, devoice: 12),
                TermMetaBankV3PitchEntry(position: 2, nasal: 23, tags: ["P1"]),
                TermMetaBankV3PitchEntry(position: 3, devoice: 34),
                TermMetaBankV3PitchEntry(position: 4, devoice: 45, tags: ["P1", "P2"]),
              ],
              []
            ),
            (
              [],
              [
                TermMetaBankV3IpaEntry(ipa: "[sɨᵝkʲi]", tags: ["東京", "京東"]),
                TermMetaBankV3IpaEntry(ipa: "[laerglaeh]"),
                TermMetaBankV3IpaEntry(ipa: "[alsjega]", tags: ["東京"]),
                TermMetaBankV3IpaEntry(ipa: "[laheig]", tags: ["test", "asd"]),
              ]
            )
          ],
        ),
      ],
    ),
  )
];