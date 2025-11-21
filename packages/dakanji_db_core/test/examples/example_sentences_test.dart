
import 'dart:io';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/example_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';

import '../util/db_files.dart';
import 'example_sentences_test_cases.dart';



void main() {
  
  late DaKanjiDB db;
  setUpAll(() async {
    db = await setupFreshDB();
  });
  tearDownAll(() async {
    await db.close();
  });

  group("Test importing example sentences", () {
    // Check some kanji bank queries
    for (int i = 0; i < exampleSentencesTestQueries.length; i++) {
      test('${exampleSentencesTestQueries[i]} ', () async {
      
        Stopwatch s = Stopwatch()..start();
        final results = (await db.exampleDao.searchExamples(
          exampleSentencesTestQueries[i].$1, exampleSentencesTestQueries[i].$2
        ));
        print("Looking up ${exampleSentencesTestQueries[i]} took ${s.elapsedMilliseconds}ms");
        print(results);

        bool allFound = true;
        for (var result in results) {
          final resultForTesting = result.copyWith(
            id: 0,
            indexEntry: result.indexEntry.copyWith(id: 0, currentSortingOrder: 0)
          );
          if(!exampleSentenceTestExpectedValues[i].contains(resultForTesting))
            allFound = false; 
        }
        expect(allFound, true);
      });
    }
  });

}

Future<DaKanjiDB> setupFreshDB() async {

  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath, inMemory: true);
  db.clearDB();

  // init mecab
  final mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  String dataSourceZipPath = await createTmpZip(Directory(devExampleSentencesPath));
  Stream<String> stream = await parseExampleDataSource(
    examplesZipPath: dataSourceZipPath,
    db: db,
    mecab: mecab,
    isDefaultDictionary: false
  );
  await for (final event in stream) {
    print(event);
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");

  return db;

}
