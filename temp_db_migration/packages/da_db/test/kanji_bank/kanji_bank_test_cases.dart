
import 'package:da_db/database/kanji/kanji_bank_v3_entry.dart';
import 'package:da_db/database/kanji/kanji_bank_v3_entry_stat.dart';
import 'package:da_db/database/tag/tag_bank_v3_entry.dart';

import '../dictionary_test_variables.dart';


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
          value: "kanji stat 1 value",
          tag: kstat1Tag
        ), 
        KanjiBankV3EntryStat(
          value: "kanji stat 2 value",
          tag: kstat2Tag,
        ),
        KanjiBankV3EntryStat(
          value: "kanji stat 3 value",
          tag: kstat3Tag,
        ),
        KanjiBankV3EntryStat(
          value: "kanji stat 4 value",
          tag: kstat4Tag,
        ),
        KanjiBankV3EntryStat(
          value: "kanji stat 5 value",
          tag: kstat5Tag
        )
      ]
  )

];
