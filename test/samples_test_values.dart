// Project imports:
import 'package:dakanji_db/database/kanji/kanji_bank_v3_entry.dart';
import 'package:dakanji_db/database/kanji/kanji_bank_v3_entry_stat.dart';
import 'package:dakanji_db/database/kanji_meta/kanji_meta_bank_v3_entry.dart';
import 'package:dakanji_db/database/tag/tag_bank_v3_entry.dart';
import 'package:dakanji_db/database/term/term_bank_v3_entry.dart';
import 'package:dakanji_db/database/term_meta/term_meta_bank_entry.dart';
import 'package:dakanji_db/database/term_meta/term_meta_bank_ipa_entry.dart';
import 'package:dakanji_db/database/term_meta/term_meta_bank_pitch_entry.dart';

/// ----------------------------------------------------------------------------
/// Test cases for the kanji bank
final kanjiBankTetsCases = [
  "打"
];

/// kanji bank test case expected values
final kanjiBankTetsCaseExpectations = [
  KanjiBankV3Entry(
    kanji: "打",
    onyomis: ["ダ", "ダアス"],
    kunyomis: ["う.つ", "う.ち-", "ぶ.つ"],
    tags: [
      TagBankV3Entry(
        name: "K1",
        categories: "default",
        sortingOrder: 0,
        notes: "example kanji tag 1",
        score: 0),
      TagBankV3Entry(
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
  "打",
  "打",
  "打つ",
  "打ち込む",

  "打",

  "打つ",

  "打ち込む",
  "お手前",
  "番号",
  "土木工事",

  "好き",
  "土木工事"
];
/// kanjiMetaBankV3 test case expected values
final termMetaBankTetsCaseExpectations = [
  TermMetaBankV3Entry(
    term: "打",
    type: "freq",
    frequency: 1,
  ),
  TermMetaBankV3Entry(
    term: "打",
    type: "freq",
    frequencyDisplayValue: "four",
  ),
  TermMetaBankV3Entry(
    term: "打つ",
    type: "freq",
    frequency: 6,
  ),
  TermMetaBankV3Entry(
    term: "打ち込む",
    type: "freq",
    frequency: 7,
    frequencyDisplayValue: "seven"
  ),

  TermMetaBankV3Entry(
    term: "打",
    type: "freq",
    reading: "だ",
    frequency: 8,
  ),

  TermMetaBankV3Entry(
    term: "打つ",
    type: "freq",
    reading: "ぶつ",
    frequencyDisplayValue: "seventeen",
  ),

  TermMetaBankV3Entry(
    term: "打ち込む",
    type: "pitch",
    reading: "うちこむ",
    pitchs: [
      TermMetaBankV3PitchEntry(
        position: 0,
      ),
      TermMetaBankV3PitchEntry(
        position: 3,
      ),
    ]
  ),
  TermMetaBankV3Entry(
    term: "お手前",
    type: "pitch",
    reading: "おてまえ",
    pitchs: [
      TermMetaBankV3PitchEntry(
        position: 2,
        tags: ["P1"]
      ),
      TermMetaBankV3PitchEntry(
        position: 2,
        tags: ["P2"]
      ),
      TermMetaBankV3PitchEntry(
        position: 0,
        tags: ["P1", "P2"]
      ),
    ]
  ),
  TermMetaBankV3Entry(
    term: "番号",
    type: "pitch",
    reading: "ばんごう",
    pitchs: [
      TermMetaBankV3PitchEntry(
        position: 3,
        nasal: 3
      ),
    ]
  ),
  TermMetaBankV3Entry(
    term: "土木工事",
    type: "pitch",
    reading: "どぼくこうじ",
    pitchs: [
      TermMetaBankV3PitchEntry(
        position: 1,
        devoice: 12
      ),
      TermMetaBankV3PitchEntry(
        position: 2,
        nasal: 23,
        tags: ["P1"]
      ),
      TermMetaBankV3PitchEntry(
        position: 3,
        devoice: 34
      ),
      TermMetaBankV3PitchEntry(
        position: 4,
        devoice: 45,
        tags: ["P1", "P2"]
      ),
    ]
  ),

  TermMetaBankV3Entry(
    term: "好き",
    type: "ipa",
    reading: "すき",
    ipas: [
      TermMetaBankV3IpaEntry(
        ipa: "[sɨᵝkʲi]",
        tags: ["東京", "京東"]
      ),
    ]
  ),
  TermMetaBankV3Entry(
    term: "土木工事",
    type: "ipa",
    reading: "どぼくこうじ",
    ipas: [
      TermMetaBankV3IpaEntry(
        ipa: "[sɨᵝkʲi]",
        tags: ["東京", "京東"]
      ),
      TermMetaBankV3IpaEntry(
        ipa: "[laerglaeh]",
      ),
      TermMetaBankV3IpaEntry(
        ipa: "[alsjega]",
        tags: ["東京"]
      ),
      TermMetaBankV3IpaEntry(
        ipa: "[laheig]",
        tags: ["test", "asd"]
      ),
    ]
  ),
];

/// ----------------------------------------------------------------------------
/// Test cases for the kanji meta bank
final termBankTetsCases = ["打"];
/// kanjiMetaBankV3 test case expected values
final termBankTetsCaseExpectations = [
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