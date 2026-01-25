import 'dart:typed_data';

import 'package:dakanji_db_core/database/audio/audio_entry.dart';

import '../dictionary_test_variables.dart';



final placeholderAudioData = Uint8List.fromList([1, 2, 3]);

List<(String, String?, int?)> audioIndexFormatTestCaseSearchTerms = [
  ('お手前', null, null),
  ('強み', null, null),
  ('所業', null, null),
  ('打ち込む', null, null),
  ('日本人', null, null),
  ('日本人', 'にほんじん', null),
  ('日本人', 'にっぽんじん', null),
  ('日本人', null, 0),
  ('日本人', null, 1),
  ('日本人', 'にっぽんじん', 0),
  ('日本人', 'にっぽんじん', 1),
];

List<List<AudioEntry>> audioIndexFormatTestCases = [
  // Results for 'お手前'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat2ExampleDictionaryIndexEntry,
      terms: ['お手前'],
      reading: 'おてまえ',
      pitchAccentPattern: null,
      filePath: 'media',
      fileName: 'a6058cfcec4ac9623bbd2be4bc8e37da.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '強み'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat2ExampleDictionaryIndexEntry,
      terms: ['強み'],
      reading: 'つよみ',
      pitchAccentPattern: null,
      filePath: 'media',
      fileName: '3a3a8b7afa369534474651de4b494876.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '所業'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat2ExampleDictionaryIndexEntry,
      terms: ['所業'],
      reading: 'しょぎょう',
      pitchAccentPattern: null,
      filePath: 'media',
      fileName: 'ef6c910fdf0090a68f67527b79aa92de.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '打ち込む'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat2ExampleDictionaryIndexEntry,
      terms: ['打ち込む'],
      reading: 'うちこむ',
      pitchAccentPattern: null,
      filePath: 'media',
      fileName: 'c8388ad9826d29df1cbfe654412f2020.opus',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      id: 0,
      indexEntry: audioFormat2ExampleDictionaryIndexEntry,
      terms: ['打ち込む'],
      reading: 'ぶちこむ',
      pitchAccentPattern: null,
      filePath: 'media',
      fileName: 'b44ccb3694f0b1b408c193dc87576760.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '日本人'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat2ExampleDictionaryIndexEntry,
      terms: ['日本人'],
      reading: 'にっぽんじん',
      pitchAccentPattern: 0,
      filePath: 'media',
      fileName: 'fe7402f538a9c882806395c6e5a6330c.opus',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      id: 0,
      indexEntry: audioFormat2ExampleDictionaryIndexEntry,
      terms: ['日本人'],
      reading: 'にほんじん',
      pitchAccentPattern: 1,
      filePath: 'media',
      fileName: '4531b4a6ccd1ed9074977599be4d7d0f.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '日本人 (にほんじん)'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat2ExampleDictionaryIndexEntry,
      terms: ['日本人'],
      reading: 'にほんじん',
      pitchAccentPattern: 1,
      filePath: 'media',
      fileName: '4531b4a6ccd1ed9074977599be4d7d0f.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '日本人 (にっぽんじん)'
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat2ExampleDictionaryIndexEntry,
      terms: ['日本人'],
      reading: 'にっぽんじん',
      pitchAccentPattern: 0,
      filePath: 'media',
      fileName: 'fe7402f538a9c882806395c6e5a6330c.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // ('日本人', null, 0),
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat2ExampleDictionaryIndexEntry,
      terms: ['日本人'],
      reading: 'にっぽんじん',
      pitchAccentPattern: 0,
      filePath: 'media',
      fileName: 'fe7402f538a9c882806395c6e5a6330c.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // ('日本人', null, 1),
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat2ExampleDictionaryIndexEntry,
      terms: ['日本人'],
      reading: 'にほんじん',
      pitchAccentPattern: 1,
      filePath: 'media',
      fileName: '4531b4a6ccd1ed9074977599be4d7d0f.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // ('日本人', 'にっぽんじん', 0),
  [
    AudioEntry(
      id: 0,
      indexEntry: audioFormat2ExampleDictionaryIndexEntry,
      terms: ['日本人'],
      reading: 'にっぽんじん',
      pitchAccentPattern: 0,
      filePath: 'media',
      fileName: 'fe7402f538a9c882806395c6e5a6330c.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // ('日本人', 'にっぽんじん', 1),
  [],
];