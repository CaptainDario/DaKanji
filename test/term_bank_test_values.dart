// Project imports:
import 'package:dakanji_db/database/kanji_meta/kanji_meta_bank_v3_entry.dart';
import 'package:dakanji_db/database/tag/tag_bank_v3_entry.dart';
import 'package:dakanji_db/database/term/term_bank_v3_entry.dart';


/// ----------------------------------------------------------------------------
/// Test cases for the kanji meta bank
final kanjiMetaBankTestCases = ["打"];
/// kanjiMetaBankV3 test case expected values
final kanjiMetaBankTestCaseExpectations = [
  KanjiMetaBankV3Entry(kanji: "打", type: "freq", freqValue: 1, freqDisplayValue: null),
  KanjiMetaBankV3Entry(kanji: "打", type: "freq", freqValue: null, freqDisplayValue: "three"),
  KanjiMetaBankV3Entry(kanji: "打", type: "freq", freqValue: 5, freqDisplayValue: null),
];


/// ----------------------------------------------------------------------------
/// Test cases for the kanji meta bank
final termBankTestCases = ["打"];
/// kanjiMetaBankV3 test case expected values
final termBankTestCaseExpectations = [
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
        name: "E1", categories: "default", sortingOrder: 0,
        notes: "example tag 1", score: 0
      )
    ]
  )
];