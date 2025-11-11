import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_ipa_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_pitch_entry.dart';

import '../dictionary_test_variables.dart';


/// Test cases for the kanji meta bank
final termMetaBankTestCases = [
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
final termMetaBankTestCaseExpectations = [
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打",
    type: "freq",
    frequency: 1,
    pitchs: [],
    ipas: []
  ),
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打",
    type: "freq",
    frequencyDisplayValue: "four",
    pitchs: [],
    ipas: []
  ),
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打つ",
    type: "freq",
    frequency: 6,
    pitchs: [],
    ipas: []
  ),
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打ち込む",
    type: "freq",
    frequency: 7,
    frequencyDisplayValue: "seven",
    pitchs: [],
    ipas: []
  ),

  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打",
    type: "freq",
    reading: "だ",
    frequency: 8,
    pitchs: [],
    ipas: []
  ),

  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打つ",
    type: "freq",
    reading: "ぶつ",
    frequencyDisplayValue: "seventeen",
    pitchs: [],
    ipas: []
  ),

  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打ち込む",
    type: "pitch",
    reading: "うちこむ",
    ipas: [],
    pitchs: [
      TermMetaBankV3PitchEntry(
        position: 0,
        tags: []
      ),
      TermMetaBankV3PitchEntry(
        position: 3,
        tags: []
      ),
    ]
  ),
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "お手前",
    type: "pitch",
    reading: "おてまえ",
    ipas: [],
    pitchs: [
      TermMetaBankV3PitchEntry(
        position: 2,
        tags: [p1Tag]
      ),
      TermMetaBankV3PitchEntry(
        position: 2,
        tags: [p2Tag]
      ),
      TermMetaBankV3PitchEntry(
        position: 0,
        tags: [p1Tag, p2Tag]
      ),
    ]
  ),
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "番号",
    type: "pitch",
    reading: "ばんごう",
    ipas: [],
    pitchs: [
      TermMetaBankV3PitchEntry(
        position: 3,
        nasal: 3,
        tags: []
      ),
    ]
  ),
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "土木工事",
    type: "pitch",
    reading: "どぼくこうじ",
    ipas: [],
    pitchs: [
      TermMetaBankV3PitchEntry(
        position: 1,
        devoice: 12,
        tags: []
      ),
      TermMetaBankV3PitchEntry(
        position: 2,
        nasal: 23,
        tags: [p1Tag]
      ),
      TermMetaBankV3PitchEntry(
        position: 3,
        devoice: 34,
        tags: []
      ),
      TermMetaBankV3PitchEntry(
        devoice: 45,
        position: 4,
        tags: [p1Tag, p2Tag]
      ),
    ]
  ),

  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "好き",
    type: "ipa",
    reading: "すき",
    pitchs: [],
    ipas: [
      TermMetaBankV3IpaEntry(
        ipa: "[sɨᵝkʲi]",
        tags: [tokyoTag, kyotoTag]
      ),
    ]
  ),
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "土木工事",
    type: "ipa",
    reading: "どぼくこうじ",
    pitchs: [],
    ipas: [
      TermMetaBankV3IpaEntry(
        ipa: "[sɨᵝkʲi]",
        tags: [tokyoTag, kyotoTag]
      ),
      TermMetaBankV3IpaEntry(
        ipa: "[laerglaeh]",
        tags: []
      ),
      TermMetaBankV3IpaEntry(
        ipa: "[alsjega]",
        tags: [tokyoTag]
      ),
      TermMetaBankV3IpaEntry(
        ipa: "[laheig]",
        tags: [testTag, asdTag]
      ),
    ]
  ),
];