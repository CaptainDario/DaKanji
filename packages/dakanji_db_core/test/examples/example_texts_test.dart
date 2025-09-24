// Package imports:
import 'package:language_processing/iso/iso_table.dart';
import 'package:dakanji_db_core/parsing/example/example_text_parser.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';
import 'package:path/path.dart' as p;

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'example_texts_test_cases.dart';



void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  db.clearDB();

  // init mecab
  final mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseExampleTextFolder(Directory(devExampleTextsPath), db, mecab);
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  test('Test importing examples', () async {
    await testExampleTexts(db);
  });

}

/// tests the termMetaBankV3 import of the sample database from the yomitan dictionary
Future testExampleTexts(DaKanjiDB db) async {

  // Check some kanji bank queries
  for (int i = 0; i < exampleTextsTestQueries.length; i++) {

    Stopwatch s = Stopwatch()..start();
    final results = (await db.exampleDao.searchExamples(
      exampleTextsTestQueries[i], [Iso639_1.en, Iso639_1.de]
    ));
    print("Looking up ${exampleTextsTestQueries[i]} took ${s.elapsedMilliseconds}ms");

    Directory(p.join(testsPath, "examples")).listSync();
    expect(results.first, equals(exampleTextTestsExpectedValues[i]));

  }

}
