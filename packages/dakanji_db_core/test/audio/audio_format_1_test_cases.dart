import 'dart:typed_data';

import 'package:dakanji_db_core/database/audio/audio_entry.dart';

import '../dictionary_test_variables.dart';



final placeholderAudioData = Uint8List.fromList([1, 2, 3]);

List<String> audioFormat1TestCaseSearchTerms = [
  'お手前',
  '強み',
  '所業',
  '打ち込む',
  '日本人',
  '打つ',
  '画像',
  '番号',
  '読む',
];

List<List<AudioEntry>> audioFormat1TestCases = [
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
];