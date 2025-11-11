import 'dart:typed_data';

import 'package:dakanji_db_core/database/audio/audio_entry.dart';

import '../dictionary_test_variables.dart';



final placeholderAudioData = Uint8List.fromList([1, 2, 3]);

List<String> audioFormat3TestCaseSearchTerms = [
  '画像',
  '日本人',
  '打つ',
  '番号',
  '詠む',
];

List<List<AudioEntry>> audioFormat3TestCases = [
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat3ExampleDictionaryIndexEntry,
      pitchAccentPattern: 0,
      terms: ['画像'],
      reading: 'ガゾー',
      filePath: 'media',
      fileName: '20170706125624.opus',
      fileData: placeholderAudioData,
    ),
  ],
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat3ExampleDictionaryIndexEntry,
      pitchAccentPattern: 5,
      terms: ['日本人'],
      reading: 'ニッポンジン',
      filePath: 'media',
      fileName: '20170720144825.opus',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      id: 0,
      indexEntry: audioFormat3ExampleDictionaryIndexEntry,
      pitchAccentPattern: 4,
      terms: ['日本人'],
      reading: 'ニホンジン',
      filePath: 'media',
      fileName: '20170720152242.opus',
      fileData: placeholderAudioData,
    ),
  ],
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat3ExampleDictionaryIndexEntry,
      pitchAccentPattern: 1,
      terms: ['打つ', '討つ', '撃つ'],
      reading: 'ウツ',
      filePath: 'media',
      fileName: '20170928151250.opus',
      fileData: placeholderAudioData,
    ),
  ],
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat3ExampleDictionaryIndexEntry,
      pitchAccentPattern: 3,
      terms: ['番号'],
      reading: 'バンコ゚ー',
      filePath: 'media',
      fileName: '20171129110054.opus',
      fileData: placeholderAudioData,
    ),
  ],
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat3ExampleDictionaryIndexEntry,
      pitchAccentPattern: 1,
      terms: ['詠む', '読む'],
      reading: 'ヨム',
      filePath: 'media',
      fileName: '20180221161451.opus',
      fileData: placeholderAudioData,
    ),
  ]
];