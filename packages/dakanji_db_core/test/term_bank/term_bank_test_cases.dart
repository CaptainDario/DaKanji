// Project imports:
import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';



/// ----------------------------------------------------------------------------
/// Test cases for the kanji meta bank
final termBankTestCases = ["打"];
/// kanjiMetaBankV3 test case expected values
final termBankTestCaseExpectations = [
  [
    TermBankV3Entry(
      term: "打",
      reading: "だ",
      definitionTags: ["n"],
      ruleIdentifiers: ["n"],
      popularity: 1,
      definitions: ["da definition 1", "da definition 2"],
      sequenceNumber: 1,
      tags: [
        TagBankV3Entry(
          name: "E1",
          category: "default",
          sortingOrder: 0,
          notes: "example tag 1",
          score: 0
        )
      ]
    ),
    TermBankV3Entry(
      term: "打",
      reading: "ダース",
      definitionTags: ["n", "abbr"],
      ruleIdentifiers: ["n"],
      popularity: 1,
      definitions: ["daasu definition 1", "daasu definition 2"],
      sequenceNumber: 2,
      tags: [
        TagBankV3Entry(
          name: "E1",
          category: "default",
          sortingOrder: 0,
          notes: "example tag 1",
          score: 0
        )
      ]
    ),
  ]
];