// Package imports:
import 'package:dakanji_db_core/parsing/example_parser.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'example_sentences_test_cases.dart';



void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  db.clearDB();

  // init mecab
  final mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  Stream<String> stream = await parseExampleDataSource(devExampleSentencesZipPath, db, mecab);
  await for (final event in stream) {
    print(event);
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");

  await testExamplesV3(db);

}

/// tests the termMetaBankV3 import of the sample database from the yomitan dictionary
Future testExamplesV3(DaKanjiDB db) async {

  group("Test importing example sentences", () {
    // Check some kanji bank queries
    for (int i = 0; i < exampleSentencesTestQueries.length; i++) {
      test('${exampleSentencesTestQueries[i]} ', () async {
      
        Stopwatch s = Stopwatch()..start();
        final results = (await db.exampleDao.searchExamples(
          exampleSentencesTestQueries[i].$1, exampleSentencesTestQueries[i].$2
        ));
        print("Looking up ${exampleSentencesTestQueries[i]} took ${s.elapsedMilliseconds}ms");

        bool allFound = true;
        for (var result in results) {
          if(!exampleSentenceTestExpectedValues[i].contains(result)) allFound = false; 
        }
        expect(allFound, true);
      });
    }
  });

}
