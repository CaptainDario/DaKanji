import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_ipa_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_pitch_entry.dart';

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
final termMetaBankTestCaseExpectations = [
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