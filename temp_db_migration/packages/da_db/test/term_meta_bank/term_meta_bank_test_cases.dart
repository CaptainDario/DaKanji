import 'package:da_db/data/term_meta_entry_types.dart';
import 'package:da_db/database/term_meta/term_meta_bank_entry.dart';
import 'package:da_db/database/term_meta/term_meta_bank_ipa_entry.dart';
import 'package:da_db/database/term_meta/term_meta_bank_pitch_entry.dart';

import '../dictionary_test_variables.dart';

/// Test cases for the kanji meta bank queries
final termMetaBankTestCases = [
  "打",
  "打",
  "打つ",
  "打ち込む",
  "打",
  "打つ",
  "打ち込む",
  "打ち込む",
  "打ち込む",
  "お手前",
  "番号",
  "中腰",
  "所業",
  "土木工事",
  "好き",
  "土木工事"
];

/// kanjiMetaBankV3 test case expected values
final termMetaBankTestCaseExpectations = [
  // --- Frequencies ---
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打",
    type: TermMetaBankEntryTypes.freq,
    frequency: 1, 
    pitchs: [],
    ipas: []
  ),
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打",
    type: TermMetaBankEntryTypes.freq,
    frequencyDisplayValue: "four", 
    pitchs: [],
    ipas: []
  ),
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打つ",
    type: TermMetaBankEntryTypes.freq,
    frequency: 2, 
    pitchs: [],
    ipas: []
  ),
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打ち込む",
    type: TermMetaBankEntryTypes.freq,
    frequency: 3, 
    pitchs: [],
    ipas: []
  ),
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打",
    type: TermMetaBankEntryTypes.freq,
    reading: "だ",
    frequency: 8, 
    pitchs: [],
    ipas: []
  ),
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打つ",
    type: TermMetaBankEntryTypes.freq,
    reading: "うつ",
    frequency: 10, 
    pitchs: [],
    ipas: []
  ),

  // --- Pitches ---
  
  // 1. Array parsed from the raw integers "0" and "3" into strings
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打ち込む",
    type: TermMetaBankEntryTypes.pitch,
    reading: "うちこむ",
    ipas: [],
    pitchs: [
      TermMetaBankV3PitchEntry(position: "LHHH", tags: []),
      TermMetaBankV3PitchEntry(position: "LHHL", tags: []),
    ]
  ),

  // 2. The massive array populated directly from the explicit string format in the JSON
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打ち込む",
    type: TermMetaBankEntryTypes.pitch,
    reading: "うちこむ",
    ipas: [],
    pitchs: [
      TermMetaBankV3PitchEntry(position: "HHHHH", tags: []),
      TermMetaBankV3PitchEntry(position: "HHHHL", tags: []),
      TermMetaBankV3PitchEntry(position: "HHHH", tags: []),
      TermMetaBankV3PitchEntry(position: "HHHL", tags: []),
      TermMetaBankV3PitchEntry(position: "HHLH", tags: []),
      TermMetaBankV3PitchEntry(position: "HHLL", devoice: [2], tags: []),
      TermMetaBankV3PitchEntry(position: "HLHH", tags: []),
      TermMetaBankV3PitchEntry(position: "HLHL", tags: []),
      TermMetaBankV3PitchEntry(position: "HLLH", tags: []),
      TermMetaBankV3PitchEntry(position: "HLLL", nasal: [3], tags: []),
      TermMetaBankV3PitchEntry(position: "LHHH", tags: []),
      TermMetaBankV3PitchEntry(position: "LHHL", tags: []),
      TermMetaBankV3PitchEntry(position: "LHLH", tags: []),
      TermMetaBankV3PitchEntry(position: "LHLL", devoice: [2], nasal: [3], tags: []),
      // --- NEW ARRAY TESTS ---
      TermMetaBankV3PitchEntry(position: "LLHH", devoice: [1, 2], tags: []), 
      TermMetaBankV3PitchEntry(position: "LLHL", nasal: [3, 4], tags: []), 
      TermMetaBankV3PitchEntry(position: "LLLH", devoice: [2], nasal: [1, 3], tags: []), 
      TermMetaBankV3PitchEntry(position: "LLLL", tags: [])
    ]
  ),

  // 3. Alternative reading parsed from integers
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "打ち込む",
    type: TermMetaBankEntryTypes.pitch,
    reading: "ぶちこむ",
    ipas: [],
    pitchs: [
      TermMetaBankV3PitchEntry(position: "LHHH", tags: []),
      TermMetaBankV3PitchEntry(position: "LHHL", tags: []),
    ]
  ),

  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "お手前",
    type: TermMetaBankEntryTypes.pitch,
    reading: "おてまえ",
    ipas: [],
    pitchs: [
      TermMetaBankV3PitchEntry(position: "LHLL", tags: [p1Tag]),
      TermMetaBankV3PitchEntry(position: "LHLL", tags: [p2Tag]),
      TermMetaBankV3PitchEntry(position: "LHHH", tags: [p2Tag]),
    ]
  ),

  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "番号",
    type: TermMetaBankEntryTypes.pitch,
    reading: "ばんごう",
    ipas: [],
    pitchs: [
      TermMetaBankV3PitchEntry(position: "LHHL", nasal: [3], tags: []),
    ]
  ),

  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "中腰",
    type: TermMetaBankEntryTypes.pitch,
    reading: "ちゅうごし",
    ipas: [],
    pitchs: [
      TermMetaBankV3PitchEntry(position: "LHHH", nasal: [3], tags: []),
    ]
  ),

  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "所業",
    type: TermMetaBankEntryTypes.pitch,
    reading: "しょぎょう",
    ipas: [],
    pitchs: [
      TermMetaBankV3PitchEntry(position: "LHH", nasal: [2], tags: []),
    ]
  ),

  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "土木工事",
    type: TermMetaBankEntryTypes.pitch,
    reading: "どぼくこうじ",
    ipas: [],
    pitchs: [
      // Matches: ["position": 1, "devoice": 12]
      TermMetaBankV3PitchEntry(position: "HLLLLL", devoice: [12], tags: []),
      // Matches: ["position": 2, "nasal": 23, "tags": ["P1"]]
      TermMetaBankV3PitchEntry(position: "LHLLLL", nasal: [23], tags: [p1Tag]),
      // Matches: ["position": 3, "devoice": 34]
      TermMetaBankV3PitchEntry(position: "LHHLLL", devoice: [34], tags: []),
      // Matches: ["position": 4, "devoice": 45, "tags": ["P1", "P2"]]
      TermMetaBankV3PitchEntry(position: "LHHHLL", devoice: [45], tags: [p1Tag, p2Tag]),
    ]
  ),

  // --- IPA ---
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "好き",
    type: TermMetaBankEntryTypes.ipa,
    reading: "すき",
    pitchs: [],
    ipas: [
      TermMetaBankV3IpaEntry(
        ipa: "[sɨᵝkʲi]",
        tags: [tokyoTag]
      ),
    ]
  ),
  TermMetaBankV3Entry(
    indexEntry: testDictionaryIndexEntry,
    id: 0,
    term: "土木工事",
    type: TermMetaBankEntryTypes.ipa,
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