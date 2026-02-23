import 'dart:typed_data';

import 'package:da_db/database/audio/audio_entry.dart';

import '../dictionary_test_variables.dart';



final placeholderAudioData = Uint8List.fromList([1, 2, 3]);

List<(String, String?, int?)> audioFileNameFormatTestCaseSearchTerms = [
  // folder 1
  ('お手前', null, null),
  ('強み', null, null),
  ('所業', null, null),
  ('打ち込む', null, null),
  ('日本人', null, null),
  // folder 2
  ('打つ', null, null),
  ('画像', null, null),
  ('番号', null, null),
  ('読む', null, null),
  // folder 3
  ('主', null, null),
  ('主', 'ぬし', null),
  ('主', 'しぬ', null),
  ('主人', 'しゅじん', null),
  ('主催', 'しゅさい', null),
  ('主催する', 'しゅさいする', null),
  // folder 4
  ('主に', null, null), // 5 results
  ('主に', null, 1,), // 2 results
  ('主に', 'おもに', 0), // 1 result
  ('主に', 'おもに', null), // 3 results
  ('主に', 'おもに', 1), // 1 result
];

List<List<AudioEntry>> audioFileNameFormatTestCases = [
  // FOLDER 1
  // Results for 'お手前'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['お手前'],
      reading: null,
      pitchAccentPattern: null,
      filePath: '1',
      fileName: 'お手前.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '強み'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['強み'],
      reading: null,
      pitchAccentPattern: null,
      filePath: '1',
      fileName: '強み.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '所業'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['所業'],
      reading: null,
      pitchAccentPattern: null,
      filePath: '1',
      fileName: '所業.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '打ち込む'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['打ち込む'],
      reading: null,
      pitchAccentPattern: null,
      filePath: '1',
      fileName: '打ち込む.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '日本人'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['日本人'],
      reading: null,
      pitchAccentPattern: null,
      filePath: '1',
      fileName: '日本人.opus',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['日本人'],
      reading: null,
      pitchAccentPattern: null,
      filePath: '2',
      fileName: '日本人.opus',
      fileData: placeholderAudioData,
    ),
  ],
  
  // FOLDER 2
  // Results for '打つ'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['打つ'],
      reading: null,
      pitchAccentPattern: null,
      filePath: '2',
      fileName: '打つ.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '画像'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['画像'],
      reading: null,
      pitchAccentPattern: null,
      filePath: '2',
      fileName: '画像.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '番号'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['番号'],
      reading: null,
      pitchAccentPattern: null,
      filePath: '2',
      fileName: '番号.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '詠む' (matching '読む' from data)
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['読む'],
      reading: null,
      pitchAccentPattern: null,
      filePath: '2',
      fileName: '読む.opus',
      fileData: placeholderAudioData,
    ),
  ],
  
  // FOLDER 3
  // Results for '主' with various readings
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主'],
      reading: "しぬ",
      pitchAccentPattern: null,
      filePath: '3',
      fileName: '主【しぬ】.mp3',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主'],
      reading: "ぬし",
      pitchAccentPattern: null,
      filePath: '3',
      fileName: '主【ぬし】.mp3',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主'],
      reading: null,
      pitchAccentPattern: null,
      filePath: '3',
      fileName: '主.mp3',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '主' with reading 'ぬし'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主'],
      reading: "ぬし",
      pitchAccentPattern: null,
      filePath: '3',
      fileName: '主【ぬし】.mp3',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '主' with reading 'しぬ'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主'],
      reading: "しぬ",
      pitchAccentPattern: null,
      filePath: '3',
      fileName: '主【しぬ】.mp3',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '主人'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主人'],
      reading: "しゅじん",
      pitchAccentPattern: null,
      filePath: '3',
      fileName: '主人【しゅじん】.mp3',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '主催'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主催'],
      reading: "しゅさい",
      pitchAccentPattern: null,
      filePath: '3',
      fileName: '主催【しゅさい】.mp3',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '主催する'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主催する'],
      reading: "しゅさいする",
      pitchAccentPattern: null,
      filePath: '3',
      fileName: '主催する【しゅさいする】.mp3',
      fileData: placeholderAudioData,
    ),
  ],

  // FOLDER 4
  // Results for '主に', null, null
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主に'],
      reading: 'おもに',
      pitchAccentPattern: 0,
      filePath: '4',
      fileName: '主に[おもに](0).mp3',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主に'],
      reading: 'おもに',
      pitchAccentPattern: 1,
      filePath: '4',
      fileName: '主に[おもに](1).mp3',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主に'],
      reading: 'おもに',
      pitchAccentPattern: null,
      filePath: '4',
      fileName: '主に[おもに].mp3',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主に'],
      reading: null,
      pitchAccentPattern: 1,
      filePath: '4',
      fileName: '主に(1).mp3',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主に'],
      reading: null,
      pitchAccentPattern: null,
      filePath: '4',
      fileName: '主に.mp3',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '主に', null, 1
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主に'],
      reading: 'おもに',
      pitchAccentPattern: 1,
      filePath: '4',
      fileName: '主に[おもに](1).mp3',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主に'],
      reading: null,
      pitchAccentPattern: 1,
      filePath: '4',
      fileName: '主に(1).mp3',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '主に', 'おもに', 0
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主に'],
      reading: 'おもに',
      pitchAccentPattern: 0,
      filePath: '4',
      fileName: '主に[おもに](0).mp3',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '主に', 'おもに', null
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主に'],
      reading: 'おもに',
      pitchAccentPattern: 0,
      filePath: '4',
      fileName: '主に[おもに](0).mp3',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主に'],
      reading: 'おもに',
      pitchAccentPattern: 1,
      filePath: '4',
      fileName: '主に[おもに](1).mp3',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主に'],
      reading: 'おもに',
      pitchAccentPattern: null,
      filePath: '4',
      fileName: '主に[おもに].mp3',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '主に', 'おもに', 1
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat1ExampleDictionaryIndexEntry,
      terms: ['主に'], 
      reading: 'おもに',
      pitchAccentPattern: 1,
      filePath: '4',
      fileName: '主に[おもに](1).mp3',
      fileData: placeholderAudioData,
    ),
  ],
];