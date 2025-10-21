
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/kanji_dictionary_search/kanji_dictionary_search_result.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

import '../../util/db_files.dart';
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
          (await db.dBQueriesDao.kanjiDictionarySearch(testCase));
        print("Looking up $testCase took ${s.elapsedMilliseconds}ms");
        print(result);

        expect(result.isNotEmpty, true);
        for (var entry in result) {
          //print(JsonEncoder.withIndent("  ").convert(entry));
          expect(kanjiDictionarySearchTestCaseExpectations.contains(entry), true);
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
    addFullJsonDefinitions: false,
    mecab: mecab
  );
  await for (var line in progress) {
    print(line);
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");

  return db;

}
