
import 'package:dakanji_db_core/database/kanji/kanji_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/kanji/kanji_bank_v3_entry_stat.dart';
import 'package:dakanji_db_core/database/kanji_meta/kanji_meta_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';

import '../../dictionary_test_variables.dart';
import 'kanji_dictionary_search_result_helper_classes.dart';


/// Test cases for the kanji bank
final List<({
  List<String> query,
  List<int> enabledIndexes,
  List<int> indexOrder
})> kanjiDictionaryTestCases = [
  (query: ["打", "込"], enabledIndexes: [1]   , indexOrder: [1, 2]),
  (query: ["打"]      , enabledIndexes: [2]   , indexOrder: [1, 2]),
  (query: ["打"]      , enabledIndexes: [1, 2], indexOrder: [1, 2]),
  (query: ["打"]      , enabledIndexes: [1, 2], indexOrder: [2, 1]),
];

/// kanji bank test case expected values
final defaultTestDictionaryIndexEntry =
  testDictionaryIndexEntry.copyWith(isDefaultDictionary: true);

final testDictionary1Utsu = KanjiDictionarySearchResultTestCaseExpectation(
  kanjiBankEntry: KanjiBankV3Entry(
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
  ),
  kanjiMetaBankEntries: [
    KanjiMetaBankV3Entry(
      id: 0,
      indexEntry: testDictionaryIndexEntry,
      kanji: "打",
      type: "freq",
      freqValue: 1,
      freqDisplayValue: null
    ),
    KanjiMetaBankV3Entry(
      id: 0,
      indexEntry: testDictionaryIndexEntry,
      kanji: "打",
      type: "freq",
      freqValue: null,
      freqDisplayValue: "three"
    ),
    KanjiMetaBankV3Entry(
      id: 0,
      indexEntry: testDictionaryIndexEntry,
      kanji: "打",
      type: "freq",
      freqValue: 5,
      freqDisplayValue: null
    )
  ]
);
final testDictionary2Utsu = KanjiDictionarySearchResultTestCaseExpectation(
  kanjiBankEntry: KanjiBankV3Entry(
    id: 0,
    indexEntry: defaultTestDictionaryIndexEntry,
    kanji: "打",
    onyomis: ["ダ", "ダアス"],
    kunyomis: ["う.つ", "う.ち-", "ぶ.つ"],
    tags: [
      TagBankV3Entry(
        id: 0,
        indexEntry: defaultTestDictionaryIndexEntry,
        name: "K1",
        category: "default",
        sortingOrder: 0,
        notes: "example kanji tag 1",
        score: 0),
      TagBankV3Entry(
        id: 0,
        indexEntry: defaultTestDictionaryIndexEntry,
        name: "K2",
        category: "default",
        sortingOrder: 0, 
        notes: "example kanji tag 2",
        score: 0)
    ],
    definitions: [
      "utsu meaning 1 (testing db)"
    ],
    stats: [
      KanjiBankV3EntryStat(
        value: "kanji stat 1 value",
        tag: kstat1Tag.copyWith(indexEntry: defaultTestDictionaryIndexEntry)
      ),
    ]
  ),
  kanjiMetaBankEntries: [
    KanjiMetaBankV3Entry(
      id: 0,
      indexEntry: defaultTestDictionaryIndexEntry,
      kanji: "打",
      type: "freq",
      freqValue: 1,
      freqDisplayValue: null
    ),
    KanjiMetaBankV3Entry(
      id: 0,
      indexEntry: defaultTestDictionaryIndexEntry,
      kanji: "打",
      type: "freq",
      freqValue: null,
      freqDisplayValue: "three"
    ),
    KanjiMetaBankV3Entry(
      id: 0,
      indexEntry: defaultTestDictionaryIndexEntry,
      kanji: "打",
      type: "freq",
      freqValue: 5,
      freqDisplayValue: null
    )
  ]
);

final List<List<KanjiDictionarySearchResultTestCaseExpectation>> kanjiDictionarySearchTestCaseExpectations = [
  [
    testDictionary1Utsu,
    KanjiDictionarySearchResultTestCaseExpectation(
      kanjiBankEntry: KanjiBankV3Entry(
        kanji: "込",
        id: 0,
        indexEntry: testDictionaryIndexEntry,
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
      ),
      kanjiMetaBankEntries: [
        KanjiMetaBankV3Entry(
          id: 0,
          indexEntry: testDictionaryIndexEntry,
          kanji: "込",
          type: "freq",
          freqValue: 2,
          freqDisplayValue: null
        ),
        KanjiMetaBankV3Entry(
          id: 0,
          indexEntry: testDictionaryIndexEntry,
          kanji: "込",
          type: "freq",
          freqValue: null,
          freqDisplayValue: "four (4)"
        ),
        KanjiMetaBankV3Entry(
          id: 0,
          indexEntry: testDictionaryIndexEntry,
          kanji: "込",
          type: "freq",
          freqValue: 6,
          freqDisplayValue: "six"
        )
      ]
    )
  ],
  [
    testDictionary2Utsu
  ],
  [
    // index 1 should come first
    KanjiDictionarySearchResultTestCaseExpectation(
      kanjiBankEntry: testDictionary1Utsu.kanjiBankEntry,
      // as both dictionaries are enabled, we get both meta entries
      kanjiMetaBankEntries: [
         ...testDictionary1Utsu.kanjiMetaBankEntries, 
         ...testDictionary2Utsu.kanjiMetaBankEntries
      ] 
    ),
    
    // index 2 comes second
    KanjiDictionarySearchResultTestCaseExpectation(
      kanjiBankEntry: testDictionary2Utsu.kanjiBankEntry,
      // as both dictionaries are enabled, we get both meta entries
      kanjiMetaBankEntries: [
         ...testDictionary1Utsu.kanjiMetaBankEntries, 
         ...testDictionary2Utsu.kanjiMetaBankEntries
      ]
    ),
  ],
  [
    // index 2 should come first
    KanjiDictionarySearchResultTestCaseExpectation(
      kanjiBankEntry: testDictionary2Utsu.kanjiBankEntry,
      // as both dictionaries are enabled, we get both meta entries
      kanjiMetaBankEntries: [
         ...testDictionary1Utsu.kanjiMetaBankEntries, 
         ...testDictionary2Utsu.kanjiMetaBankEntries
      ]
    ),

    // index 1 comes second
    KanjiDictionarySearchResultTestCaseExpectation(
      kanjiBankEntry: testDictionary1Utsu.kanjiBankEntry,
      // as both dictionaries are enabled, we get both meta entries
      kanjiMetaBankEntries: [
         ...testDictionary1Utsu.kanjiMetaBankEntries, 
         ...testDictionary2Utsu.kanjiMetaBankEntries
      ] 
    ),
  ]
];
