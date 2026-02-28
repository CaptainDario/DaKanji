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
        final queryTerm = exampleTextTestQueries[i].$1;
        
        final results = await db.exampleDao.searchExamples(
          queryTerm, 
          exampleTextTestQueries[i].$2
        );
        
        print("Looking up '$queryTerm' took ${s.elapsedMilliseconds}ms");

        // 1. Assert we found AT LEAST one result 
        expect(results.isNotEmpty, true, reason: "DAO returned empty results for query $queryTerm");

        // 2. Safely grab ONLY the first result to avoid RangeErrors from duplicated file contents
        final result = results.first;
        final expected = exampleTextTestExpectedValues[i].first; // Grab the single expected item

        // 3. Strip out DB-generated IDs for a clean comparison
        final resultForTesting = exampleEntryIgnoreDatabaseGeneratedData(result);

        // 4. Compare the first result to our expected object
        if (resultForTesting != expected) {
          print("--- MISMATCH FOUND ---");
          print("EXPECTED: $expected");
          print("ACTUAL:   $resultForTesting");
        }
        
        expect(resultForTesting, expected, reason: "The parsed entry did not match the expected values.");
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