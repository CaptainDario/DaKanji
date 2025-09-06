// Package imports:
import 'package:language_processing/iso/iso_table.dart';
import 'package:dakanji_db_core/parsing/example_parser.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'example_sentences_test_expected_values.dart';



void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  db.clearDB();

  // init mecab
  final mecab = Mecab();
  await mecab.init("mecab.dylib", "ipadic", true);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseExampleSentenceFolder(Directory(devExampleSentencesPath), db, mecab);
  print("Conversion took ${s.elapsedMilliseconds} ms");

  test('Test importing examples', () async {
    await testExamplesV3(db);
  });

}

/// tests the termMetaBankV3 import of the sample database from the yomitan dictionary
Future testExamplesV3(DaKanjiDB db) async {

  // Check some kanji bank queries
  for (int i = 0; i < exampleSentencesTestQueries.length; i++) {

    Stopwatch s = Stopwatch()..start();
    final results = (await db.exampleDao.searchExamples(
      exampleSentencesTestQueries[i], [Iso639_1.en, Iso639_1.de]
    ));
    print("Looking up ${exampleSentencesTestQueries[i]} took ${s.elapsedMilliseconds}ms");

    bool allFound = true;
    for (var result in results) {
      if(!exampleSentenceTestExpectedValues[i].contains(result)) allFound = false; 
    }
    expect(allFound, true);

  }

}
