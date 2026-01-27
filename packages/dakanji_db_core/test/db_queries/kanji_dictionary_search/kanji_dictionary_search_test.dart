
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/kanji_dictionary_search/kanji_dictionary_search_result.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

import '../../test_utils/db_files.dart';
import '../../test_utils/ignore_database_generated_data.dart';
import 'kanji_dictionary_search_test_cases.dart';

void main() {
  
  late DaKanjiDB db;
  setUpAll(() async {
    db = await setupFreshDB();
  },);
  tearDownAll(() async {
    await db.close();
  },);

  group('KanjiBankV3 Tests', () {
    // Check some kanji bank queries
    for (var testCase in kanjiDictionaryTestCases) {
      test('Looking up $testCase', () async {
        Stopwatch s = Stopwatch()..start();
        List<KanjiDictionarySearchResult> result =
          (await db.kanjiSearchDao.kanjiDictionarySearch(testCase))
          .map((e) => kanjiDictionarySearchResultIgnoreDatabaseGeneratedData(e))
          .toList();
        print("Looking up $testCase took ${s.elapsedMilliseconds}ms");

        // 1. First, check that the number of results we got from the DB
        expect(result.length, equals(kanjiDictionarySearchTestCaseExpectations.length));

        for (int i = 0; i < result.length; i++) {
          final actualResult = result[i];
          final expectedResult = kanjiDictionarySearchTestCaseExpectations[i];
          print("Actual result: $actualResult");
          print("Expected kanji result: ${expectedResult.kanjiBankEntry}");
          print("Expected kanji meat result: ${expectedResult.kanjiMetaBankEntries}");

          // Compare the kanji bank entry
          expect(
            actualResult.kanjiBankEntry, 
            equals(expectedResult.kanjiBankEntry),
            reason: "KanjiBankV3Entry for '${actualResult.kanjiBankEntry.kanji}' did not match expectation."
          );

          // Compare the list of meta entries
          for (var i = 0; i < expectedResult.kanjiMetaBankEntries.length; i++) {
            expect(
              actualResult.kanjiMetaBankEntries[i],
              equals(expectedResult.kanjiMetaBankEntries[i]),
              reason: "KanjiMetaBankV3Entry at index $i for '${actualResult.kanjiBankEntry.kanji}' did not match expectation."
            ); 
          }
        }
      });
    }
  });

}

Future<DaKanjiDB> setupFreshDB() async {

  // create the testing database (delete any existing database)
  if (File(dakanjiDbPath).existsSync()) File(dakanjiDbPath).deleteSync();
  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath, inMemory: true);

  final mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  String dataSourceZipPath = await createTmpZip(Directory(yomitanSampleDictionaryPath));
  Stream<String> progress = await parseDictionaryDataSource(
    dataSourcePath: dataSourceZipPath,
    db: db,
    addStructuredContentJsonDefs: false,
    mecab: mecab,
    isDefaultDictionary: false
  );
  await for (var line in progress) {
    print(line);
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");

  return db;

}
