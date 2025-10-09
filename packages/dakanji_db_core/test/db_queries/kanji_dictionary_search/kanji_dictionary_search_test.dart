// Package imports:
import 'package:dakanji_db_core/database/db_queries/kanji_dictionary_search/kanji_dictionary_search_result.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'kanji_dictionary_search_test_cases.dart';

void main() async {
  
  // create the testing database (delete any existing database)
  if (File(dakanjiDbPath).existsSync()) File(dakanjiDbPath).deleteSync();
  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath);

  final mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  Stream<String> progress = await parseDictionaryDataSource(
    dataSourcePath: yomitanSampleDictionaryZipPath,
    db: db,
    addFullJsonDefinitions: false,
    mecab: mecab
  );
  await for (var line in progress) {
    print(line);
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  await testKanjiBankV3(db);

}

/// tests the kanjiBankV3 import of the sample database from the yomitan dictionary
Future testKanjiBankV3(DaKanjiDB db) async {
  group('KanjiBankV3 Tests', () {
    // Check some kanji bank queries
    for (var testCase in kanjiDictionaryTestCases) {
      test('Looking up $testCase', () async {
        Stopwatch s = Stopwatch()..start();
        List<KanjiDictionarySearchResult> result =
          (await db.daKanjiDBDao.kanjiDictionarySearch(testCase));
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
