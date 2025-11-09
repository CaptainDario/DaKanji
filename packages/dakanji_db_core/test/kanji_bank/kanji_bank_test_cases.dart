
import 'package:dakanji_db_core/database/kanji/kanji_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/kanji/kanji_bank_v3_entry_stat.dart';
import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';

import '../test_dictionary_variables.dart';


/// Test cases for the kanji bank
final kanjiBankTestCases = [
  "打"
];

/// kanji bank test case expected values
final kanjiBankTestCaseExpectations = [
  KanjiBankV3Entry(
    id: 0,
    indexEntry: testDictionaryIndexEntry,
    kanji: "打",
    onyomis: ["ダ", "ダアス"],
    kunyomis: ["う.つ", "う.ち-", "ぶ.つ"],
    tags: [
      TagBankV3Entry(
        id: 0,
        indexEntry: testDictionaryIndexEntry,
        name: "K1",
        category: "default",
        sortingOrder: 0,
        notes: "example kanji tag 1",
        score: 0),
      TagBankV3Entry(
        id: 0,
        indexEntry: testDictionaryIndexEntry,
        name: "K2",
        category: "default",
        sortingOrder: 0, 
        notes: "example kanji tag 2",
        score: 0)
    ],
    definitions: [
      "utsu meaning 1",
      "utsu meaning 2",
      "utsu meaning 3",
      "utsu meaning 4",
      "utsu meaning 5"
    ],
    stats: [
      KanjiBankV3EntryStat(
        name: "kstat1",
        value: "kanji stat 1 value"
      ), 
      KanjiBankV3EntryStat(
        name: "kstat2",
        value: "kanji stat 2 value"
      ),
      KanjiBankV3EntryStat(
        name: "kstat3",
        value: "kanji stat 3 value"
      ),
      KanjiBankV3EntryStat(
        name: "kstat4",
        value: "kanji stat 4 value"
      ),
      KanjiBankV3EntryStat(
        name: "kstat5",
        value: "kanji stat 5 value"
      )
    ]
  )

];
