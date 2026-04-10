import 'dart:io';

import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/unified_staging_parser.dart';
import '../../../shared_utils/lib/da_db_paths.dart';

import '../dictionary_test_variables.dart';
import '../test_utils/db_files.dart';

Future<DaDb> setupFreshDb(
  String dictionaryPath,
  bool isDefaultDictionary,
  {
    bool inMemory = true,
    DaDb? existingDb,
  }
) async {

  late DaDb db;

  // if no db is given create the testing database (delete any existing database)
  if(existingDb == null) {
    if(File(daDbTestPath).existsSync()) File(daDbTestPath).deleteSync();
    db = DaDb(
      dbPath: daDbTestPath, 
      inMemory: inMemory,
      languageProcessor: await japaneseProcessor
    );
  }
  else {
    db = existingDb;
  }

  // convert the test files directly from devExampleSentencesPath
  Stopwatch s = Stopwatch()..start();
  String dataSourceZipPath = await createTmpZip(Directory(dictionaryPath));
  
  Stream<String> stream = await parseDaDbDataSource(
    dataSourcePath: dataSourceZipPath,
    db: db,
    isDefaultDictionary: isDefaultDictionary,
  );
  
  await for (final event in stream) {
    print("Parser: $event");
  }
  
  print("Conversion took ${s.elapsedMilliseconds} ms");

  return db;
}