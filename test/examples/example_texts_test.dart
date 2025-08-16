// Package imports:
import 'package:dakanji_db/iso/iso_table.dart';
import 'package:dakanji_db/parsing/example/example_text_parser.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';
import '../../bin/paths.dart';
import 'example_texts_test_values.dart';



void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  db.clearDB();

  // init mecab
  final mecab = Mecab();
  await mecab.init("mecab.dylib", "ipadic", true);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseExampleTextFolder(Directory(devExampleTextsPath), db, mecab);
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  test('Test importing examples', () async {
    await testExampleTextsV3(db);
  });

}

/// tests the termMetaBankV3 import of the sample database from the yomitan dictionary
Future testExampleTextsV3(DaKanjiDB db) async {

  // Check some kanji bank queries
  for (int i = 0; i < exampleTextsTestQueries.length; i++) {

    Stopwatch s = Stopwatch()..start();
    final result = (await db.exampleDao.searchExamples(
      exampleTextsTestQueries[i], [Iso639_1.en, Iso639_1.de]
    ));
    print("Looking up ${exampleTextsTestQueries[i]} took ${s.elapsedMilliseconds}ms");
    print("Result: $result");
    print("Actual: ${exampleTextsTestExpected[0]}");

    expect(result.isNotEmpty, true);
    expect(result[0] == exampleTextsTestExpected[0], true);

  }

}
