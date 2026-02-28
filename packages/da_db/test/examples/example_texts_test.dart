import 'dart:io';

import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/example_parser.dart';
import 'package:da_db_shared/paths.dart';
import 'package:test/test.dart';

import '../dictionary_test_variables.dart';
import '../test_utils/db_files.dart';
import '../test_utils/ignore_database_generated_data.dart';
import 'example_texts_test_cases.dart';

void main() {
  late DaDb db;

  setUpAll(() async {
    db = await setupFreshDB();
  });

  tearDownAll(() async {
    await db.close();
  });

  group("Test importing plain text example sentences", () {
    for (int i = 0; i < exampleTextTestQueries.length; i++) {
      test('Query: ${exampleTextTestQueries[i].$1}', () async {
      
        Stopwatch s = Stopwatch()..start();
        
        final results = await db.exampleDao.searchExamples(
          exampleTextTestQueries[i].$1, 
          exampleTextTestQueries[i].$2
        );
        
        print("Looking up '${exampleTextTestQueries[i].$1}' took ${s.elapsedMilliseconds}ms");

        bool allFound = true;
        expect(results.isNotEmpty, true, reason: "DAO returned empty results for query ${exampleTextTestQueries[i].$1}");

        for (int j = 0; j < results.length; j++) {
          final result = results[j];
          final expected = exampleTextTestExpectedValues[i][j];

          // Strip out DB-generated IDs
          final resultForTesting = exampleEntryIgnoreDatabaseGeneratedData(result);

          if (resultForTesting != expected) {
            allFound = false;
            print("--- MISMATCH FOUND ---");
            print("EXPECTED: $expected");
            print("ACTUAL:   $resultForTesting");
          }
        }
        
        expect(allFound, true);
      });
    }
  });
}

Future<DaDb> setupFreshDB() async {

  if(File(daDbTestPath).existsSync()) File(daDbTestPath).deleteSync();

  // create the testing database
  DaDb db = DaDb(
    dbPath: daDbTestPath, 
    inMemory: false,
    languageProcessor: await japaneseProcessor
  );

  Stopwatch s = Stopwatch()..start();
  
  String dataSourceZipPath = await createTmpZip(Directory(devExampleTextsPath)); 
  
  Stream<String> stream = await parseExampleDataSource(
    dataSourcePath: dataSourceZipPath,
    db: db,
    isDefaultDictionary: true,
  );
  
  await for (final event in stream) {
    print("Parser: $event");
  }
  
  print("Conversion took ${s.elapsedMilliseconds} ms");

  return db;
}