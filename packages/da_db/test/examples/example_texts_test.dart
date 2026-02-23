
import 'dart:io';

import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/example_parser.dart';
import 'package:da_db_shared/paths.dart';
import 'package:language_processing/language_processing.dart';
import 'package:test/test.dart';

import '../dictionary_test_variables.dart';
import '../test_utils/db_files.dart';
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
          exampleTextsTestQueries[i], [Iso639_3.eng]
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
  if(File(dakanjiDbTestPath).existsSync()) File(dakanjiDbTestPath).deleteSync();
  DaKanjiDB db = DaKanjiDB(
    dbPath: dakanjiDbTestPath, inMemory: true, languageProcessor: await japaneseProcessor);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  String dataSourceZipPath = await createTmpZip(Directory(devExampleTextsPath));
  Stream<String> stream = await parseExampleDataSource(
    examplesZipPath: dataSourceZipPath,
    db: db,
    isDefaultDictionary: false
  );
  await for (final event in stream) {
    print(event);
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");

  return db;

}
