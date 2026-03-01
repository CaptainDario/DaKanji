import 'dart:io';

import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/unified_staging_parser.dart';
import 'package:da_db_shared/paths.dart';
import 'package:test/test.dart';

import '../dictionary_test_variables.dart';
import '../test_utils/db_files.dart';
import '../test_utils/ignore_database_generated_data.dart';
import 'example_bank_test_cases.dart';

void main() {
  late DaDb db;

  setUpAll(() async {
    db = await setupFreshDB();
  });

  tearDownAll(() async {
    await db.close();
  });

  group("Test importing example sentences", () {
    for (int i = 0; i < exampleSentencesTestQueries.length; i++) {
      test('Query: ${exampleSentencesTestQueries[i].$1}', () async {
      
        Stopwatch s = Stopwatch()..start();
        
        final results = await db.exampleDao.searchExamples(
          exampleSentencesTestQueries[i].$1, 
          exampleSentencesTestQueries[i].$2
        );
        
        print("Looking up '${exampleSentencesTestQueries[i].$1}' took ${s.elapsedMilliseconds}ms");

        bool allFound = true;
        expect(results.isNotEmpty, true, reason: "DAO returned empty results for query ${exampleSentencesTestQueries[i].$1}");

        for (int j = 0; j < results.length; j++) {
          final result = results[j];
          final expected = exampleSentenceTestExpectedValues[i][j];

          // Use the utility to strip out DB-generated IDs!
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

  // create the testing database (delete any existing database)
  DaDb db = DaDb(
    dbPath: daDbTestPath, 
    inMemory: false,
    languageProcessor: await japaneseProcessor
  );

  // convert the test files directly from devExampleSentencesPath
  Stopwatch s = Stopwatch()..start();
  String dataSourceZipPath = await createTmpZip(Directory(devExampleSentencesPath));
  
  Stream<String> stream = await parseDaDbDataSource(
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