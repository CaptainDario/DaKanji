// Package imports:
import 'package:dakanji_db_core/parsing/example_parser.dart';
import 'package:language_processing/iso/iso_table.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'example_texts_test_cases.dart';



void main() async {

  print(coreTestsPath);
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath);
  db.clearDB();

  // init mecab
  final mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  Stream<String> stream = await parseExampleDataSource(devExampleTextsZipPath, db, mecab);
  await for (final event in stream) {
    print(event);
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");

  await testExampleTexts(db);

}

/// tests the termMetaBankV3 import of the sample database from the yomitan dictionary
Future testExampleTexts(DaKanjiDB db) async {

  group("Test importing example texts", () {
    // Check some kanji bank queries
    for (int i = 0; i < exampleTextsTestQueries.length; i++) {
      test('Searching: ${exampleTextsTestQueries[i]}', () async {

        Stopwatch s = Stopwatch()..start();
        final results = (await db.exampleDao.searchExamples(
          exampleTextsTestQueries[i], [Iso639_1.en]
        ));
        print("This are my results: $results");
        print("Looking up ${exampleTextsTestQueries[i]} took ${s.elapsedMilliseconds}ms");

        expect(results.first, equals(exampleTextTestsExpectedValues[i]));

      });
    }
  });
}
