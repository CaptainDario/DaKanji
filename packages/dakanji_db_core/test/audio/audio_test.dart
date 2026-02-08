
import 'package:dakanji_db_core/database/audio/audio_entry.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/audio/in_memory_cache/audio_parser.dart' as in_memory_audio_parser;
import 'package:dakanji_db_shared/paths.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

import '../dictionary_test_variables.dart';
import '../test_utils/db_files.dart';
import 'audio_entries_format_test_cases.dart';
import 'audio_file_name_format_test_cases.dart';
import 'audio_index_format_test_cases.dart';



List<({
  String format,
  String dataSource,
  List<(String, String?, int?)> searchTerms,
  List<List<AudioEntry>> testCases
})> tests = [
  (
    format: "file name format",
    dataSource: devExampleAudioFileNameFormatPath,
    searchTerms: audioFileNameFormatTestCaseSearchTerms,
    testCases: audioFileNameFormatTestCases,
  ),
  (
    format: "index format",
    dataSource: devExampleAudioIndexFormatPath,
    searchTerms: audioIndexFormatTestCaseSearchTerms,
    testCases: audioIndexFormatTestCases,
  ),
  (
    format: "entries format",
    dataSource: devExampleAudioEntriesFormatPath,
    searchTerms: audioEntriesFormatTestCaseSearchTerms,
    testCases: audioEntriesFormatTestCases,
  )
];

void main() async {

  print(devExampleAudioFileNameFormatPath);
  
  for (int l=0; l < tests.length; l++) {
    group("Test importing audios from Audio Format: ${tests[l].format}", () {

      late DaKanjiDB db;
      setUpAll(() async{
        db = await setupFreshDB(tests[l].dataSource, false);
      },);
      tearDownAll(() async {
        await db.close();
      },);

      // Check some kanji bank queries
      for (int i = 0; i < tests[l].testCases.length; i++) {
        test('Searching: ${tests[l].searchTerms[i]}', () async {

          Stopwatch s = Stopwatch()..start();
          final results = await db.audioDao.audioSearch([(
            term: tests[l].searchTerms[i].$1,
            reading: tests[l].searchTerms[i].$2,
            pitchAccentPattern: tests[l].searchTerms[i].$3,
          )]);
          print("Lookup took ${s.elapsedMilliseconds}ms");

          expect(results.length, tests[l].testCases[i].length, reason: "Number of results mismatch");
          for (var j = 0; j < results.length; j++) {
            final r = results[j]; final e = tests[l].testCases[i][j];
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
  DaKanjiDB db = DaKanjiDB(
    dbPath: dakanjiDbPath, inMemory: true, languageProcessor: await japaneseProcessor);

  // parse the test files
  Stopwatch s = Stopwatch()..start();
  String dataSourceZipPath = await createTmpZip(Directory(dataSourcePath));
  print(dataSourceZipPath);

  //final parse = staging_audio_parser.par;
  final parse = in_memory_audio_parser.parseAudioDataSource;
  Stream importProgress = await parse(
    audioDataSourceFile: dataSourceZipPath,
    db: db,
    isDefaultDictionary: isDefaultDictionary
  );
  await for (final event in importProgress) {
    print(event);
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");
  return db;

}
