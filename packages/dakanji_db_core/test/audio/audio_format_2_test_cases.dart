import 'dart:typed_data';

import 'package:dakanji_db_core/database/audio/audio_entry.dart';



final placeholderAudioData = Uint8List.fromList([1, 2, 3]);

List<String> audioFormat2TestCaseSearchTerms = [
  'お手前',
  '強み',
  '所業',
  '打ち込む',
  '日本人',
];

List<List<AudioEntry>> audioFormat2TestCases = [
  // Results for 'お手前'
  [
    AudioEntry(
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
      terms: ['打ち込む'],
      reading: 'ぶちこむ',
      pitchAccentPattern: null,
      filePath: 'media',
      fileName: 'b44ccb3694f0b1b408c193dc87576760.opus',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      terms: ['打ち込む'],
      reading: 'うちこむ',
      pitchAccentPattern: null,
      filePath: 'media',
      fileName: 'c8388ad9826d29df1cbfe654412f2020.opus',
      fileData: placeholderAudioData,
    ),
  ],
  // Results for '日本人'
  [
    AudioEntry(
      terms: ['日本人'],
      reading: 'にほんじん',
      pitchAccentPattern: null,
      filePath: 'media',
      fileName: '4531b4a6ccd1ed9074977599be4d7d0f.opus',
      fileData: placeholderAudioData,
    ),
    AudioEntry(
      terms: ['日本人'],
      reading: 'にっぽんじん',
      pitchAccentPattern: null,
      filePath: 'media',
      fileName: 'fe7402f538a9c882806395c6e5a6330c.opus',
      fileData: placeholderAudioData,
    ),
  ],
];