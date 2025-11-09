
import 'package:dakanji_db_core/database/kanji/kanji_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/kanji/kanji_bank_v3_entry_stat.dart';
import 'package:dakanji_db_core/database/kanji_meta/kanji_meta_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';

import '../../test_dictionary_variables.dart';
import 'kanji_dictionary_search_result_helper_classes.dart';


/// Test cases for the kanji bank
final kanjiDictionaryTestCases = [
  ["打", "込"]
];

/// kanji bank test case expected values
final List<KanjiDictionarySearchResultTestCaseExpectation> kanjiDictionarySearchTestCaseExpectations = [
  KanjiDictionarySearchResultTestCaseExpectation(
    kanjiBankEntry: KanjiBankV3Entry(
      indexId: -999,
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
    ),
    kanjiMetaBankEntries: [
      KanjiMetaBankV3Entry(
        kanji: "打",
        indexId: 1,
        type: "freq",
        freqValue: 1,
        freqDisplayValue: null
      ),
      KanjiMetaBankV3Entry(
        kanji: "打",
        indexId: 1,
        type: "freq",
        freqValue: null,
        freqDisplayValue: "three"
      ),
      KanjiMetaBankV3Entry(
        kanji: "打",
        indexId: 1,
        type: "freq",
        freqValue: 5,
        freqDisplayValue: null
      )
    ]
  ),
  KanjiDictionarySearchResultTestCaseExpectation(
  kanjiBankEntry: KanjiBankV3Entry(
    kanji: "込",
    indexId: 1,
    onyomis: [],
    kunyomis: [
      "-こ.む",
      "こ.む",
      "こ.み",
      "-こ.み",
      "こ.める"
    ],
    tags: [
      TagBankV3Entry(
        id: 0,
        indexEntry: testDictionaryIndexEntry,
        name: "K1",
        category: "default",
        sortingOrder: 0,
        notes: "example kanji tag 1",
        score: 0
      ),
      TagBankV3Entry(
        id: 0,
        indexEntry: testDictionaryIndexEntry,
        name: "K2",
        category: "default",
        sortingOrder: 0,
        notes: "example kanji tag 2",
        score: 0
      )
    ],
    definitions: [
      "komu meaning 1",
      "komu meaning 2",
      "komu meaning 3",
      "komu meaning 4",
      "komu meaning 5"
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
  ),
  kanjiMetaBankEntries: [
    KanjiMetaBankV3Entry(
      kanji: "込",
      indexId: 1,
      type: "freq",
      freqValue: 2,
      freqDisplayValue: null
    ),
    KanjiMetaBankV3Entry(
      kanji: "込",
      indexId: 1,
      type: "freq",
      freqValue: null,
      freqDisplayValue: "four (4)"
    ),
    KanjiMetaBankV3Entry(
      kanji: "込",
      indexId: 1,
      type: "freq",
      freqValue: 6,
      freqDisplayValue: "six"
    )
  ]
)
];
