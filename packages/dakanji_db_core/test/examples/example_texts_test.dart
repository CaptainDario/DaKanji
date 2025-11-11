
import 'dart:io';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/example_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'package:language_processing/iso/iso_table.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';

import '../util/db_files.dart';
import 'example_texts_test_cases.dart';



void main() async {

  print(coreTestsPath);
  
  late DaKanjiDB db;
  setUpAll(() async {
    db = await setupFreshDB();
  });
  tearDownAll(() async {
    await db.close();
  });

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

        expect(
          results.first.copyWith(
            id: 0,
            indexEntry: results.first.indexEntry.copyWith(
              id: 0,
              currentSortingOrder: 0
            )
          ),
          equals(exampleTextTestsExpectedValues[i])
        );
      });
    }
  });

}

Future<DaKanjiDB> setupFreshDB() async {

  // create the testing database (delete any existing database)
  if(File(dakanjiDbPath).existsSync()) File(dakanjiDbPath).deleteSync();
  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath, inMemory: false);

  // init mecab
  final mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  String dataSourceZipPath = await createTmpZip(Directory(devExampleTextsPath));
  Stream<String> stream = await parseExampleDataSource(dataSourceZipPath, db, mecab);
  await for (final event in stream) {
    print(event);
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");

  return db;

}
