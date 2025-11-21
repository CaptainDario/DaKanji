
import 'package:dakanji_db_core/database/audio/audio_entry.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/audio/audio_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

import '../util/db_files.dart';
import 'audio_format_1_test_cases.dart';
import 'audio_format_2_test_cases.dart';
import 'audio_format_3_test_cases.dart';



List<String> dataSources = [
  devExampleAudio1Path, 
  devExampleAudio2Path,
  devExampleAudio3Path,
];

List<List<String>> searchTerms = [
  audioFormat1TestCaseSearchTerms,
  audioFormat2TestCaseSearchTerms,
  audioFormat3TestCaseSearchTerms,
];

List<List<List<AudioEntry>>> testCases = [
  audioFormat1TestCases,
  audioFormat2TestCases,
  audioFormat3TestCases,
];

void main() async {

  print(devExampleAudio1Path);
  
  for (int l=0; l < dataSources.length; l++) {
    group("Test importing audios from Audio Format ${l+1}", () {

      late DaKanjiDB db;
      setUpAll(() async{
        db = await setupFreshDB(dataSources[l], false);
      },);
      tearDownAll(() async {
        await db.close();
      },);

      // Check some kanji bank queries
      for (int i = 0; i < testCases[l].length; i++) {
        test('Searching: ${searchTerms[l][i]}', () async {

          Stopwatch s = Stopwatch()..start();
          final results = await db.dBQueriesDao.audioSearch(searchTerms[l][i]);
          print("Lookup took ${s.elapsedMilliseconds}ms");

          expect(results.length, testCases[l][i].length, reason: "Number of results mismatch");
          for (var j = 0; j < results.length; j++) {
            final r = results[j]; final e = testCases[l][i][j];
            expect(r.terms, e.terms, reason: "Terms mismatch");
            expect(r.reading, e.reading, reason: "Reading mismatch");
            expect(r.pitchAccentPattern, e.pitchAccentPattern, reason: "Pitch accent pattern mismatch");
            expect(r.filePath, e.filePath, reason: "File path mismatch");
            expect(r.fileName, e.fileName, reason: "File name mismatch"); 
          }
        });
      }
    });
  }

}

Future<DaKanjiDB> setupFreshDB(
  String dataSourcePath, bool isDefaultDictionary) async {

  // create the testing database (delete any existing database)
  if(File(dakanjiDbPath).existsSync()) File(dakanjiDbPath).deleteSync();
  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath, inMemory: true);

  Mecab mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  // parse the test files
  Stopwatch s = Stopwatch()..start();
  String dataSourceZipPath = await createTmpZip(Directory(dataSourcePath));
  print(dataSourceZipPath);
  Stream importProgress = await parseAudioDataSource(
    audioDataSourceFile: dataSourceZipPath,
    db: db,
    audioSourceName: p.basenameWithoutExtension(dataSourcePath),
    mecab: mecab,
    isDefaultDictionary: isDefaultDictionary
  );
  await for (final event in importProgress) {
    print(event);
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");
  return db;

}
