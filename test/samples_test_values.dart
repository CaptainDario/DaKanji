// Project imports:
import 'package:dakanji_db/database/kanji/kanji_bank_entry.dart';
import 'package:dakanji_db/database/kanji/kanji_bank_entry_stat.dart';
import 'package:dakanji_db/database/kanji_meta/kanji_meta_bank_entry.dart';
import 'package:dakanji_db/database/tag/tag_bank_entry.dart';

/// ----------------------------------------------------------------------------
/// Test cases for the kanji bank
final kanjiBankTetsCases = [
  "打"
];

/// kanji bank test case expected values
final kanjiBankTetsCaseExpectations = [
  KanjiBankEntry(
    kanji: "打",
    onyomis: ["ダ", "ダアス"],
    kunyomis: ["う.つ", "う.ち-", "ぶ.つ"],
    tags: [
      TagBankEntry(
        name: "K1",
        categories: "default",
        sortingOrder: 0,
        notes: "example kanji tag 1",
        score: 0),
      TagBankEntry(
        name: "K2",
        categories: "default",
        sortingOrder: 0, 
        notes: "example kanji tag 2",
        score: 0)
    ],
    meanings: [
      "utsu meaning 1",
      "utsu meaning 2",
      "utsu meaning 3",
      "utsu meaning 4",
      "utsu meaning 5"
    ],
    stats: [
      KanjiBankEntryStat(
        name: "kstat1",
        value: "kanji stat 1 value"
      ), 
      KanjiBankEntryStat(
        name: "kstat2",
        value: "kanji stat 2 value"
      ),
      KanjiBankEntryStat(
        name: "kstat3",
        value: "kanji stat 3 value"
      ),
      KanjiBankEntryStat(
        name: "kstat4",
        value: "kanji stat 4 value"
      ),
      KanjiBankEntryStat(
        name: "kstat5",
        value: "kanji stat 5 value"
      )
    ]
  )
];

/// ----------------------------------------------------------------------------
/// Test cases for the kanji meta bank
final kanjiMetaBankTetsCases = ["打"];
/// kanjiMetaBankV3 test case expected values
final kanjiMetaBankTetsCaseExpectations = [
  KanjiMetaBankV3Entry(kanji: "打", type: "freq", freqValue: 1, freqDisplayValue: null),
  KanjiMetaBankV3Entry(kanji: "打", type: "freq", freqValue: null, freqDisplayValue: "three"),
  KanjiMetaBankV3Entry(kanji: "打", type: "freq", freqValue: 5, freqDisplayValue: null),
];

/// ----------------------------------------------------------------------------
/// Test cases for the kanji meta bank
final termMetaBankTetsCases = [
  // TODO add tests
];
/// kanjiMetaBankV3 test case expected values
final termMetaBankTetsCaseExpectations = [
  // TODO add tests
];
