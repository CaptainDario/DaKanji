import 'dart:io';

import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/unified_staging_parser.dart';
import 'package:da_db_shared/paths.dart';

import '../dictionary_test_variables.dart';
import '../test_utils/db_files.dart';

Future<DaDb> setupFreshDb(String dictionaryPath) async {

  if(File(daDbTestPath).existsSync()) File(daDbTestPath).deleteSync();

  // create the testing database (delete any existing database)
  DaDb db = DaDb(
    dbPath: daDbTestPath, 
    inMemory: false,
    languageProcessor: await japaneseProcessor
  );

  // convert the test files directly from devExampleSentencesPath
  Stopwatch s = Stopwatch()..start();
  String dataSourceZipPath = await createTmpZip(Directory(dictionaryPath));
  
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