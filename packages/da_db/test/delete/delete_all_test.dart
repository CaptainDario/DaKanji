import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db_shared/paths.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

import '../dictionary_test_variables.dart';
import '../test_utils/db_files.dart';
import 'delete_dictionary_test_util.dart';

void main() {
  late DaDb db;
  late String zipYomitan; 
  late String zipAudio; 
  late String zipExample;

  setUpAll(() async {
    if (File(daDbTestPath).existsSync()) {
      print("Deleting existing database file at $daDbTestPath...");
      File(daDbTestPath).deleteSync();
    }

    db = DaDb(
      dbPath: daDbTestPath,
      inMemory: false,
      languageProcessor: await japaneseProcessor,
    );

    final testDataDir = p.joinAll([daDbDataFilesPath, "deletion_test_data"]);
    
    // We use the specific dictionaries from our suite that all share "猫"
    zipYomitan = await createTmpZip(Directory(p.joinAll([testDataDir, "yomitan_2"])));
    zipAudio = await createTmpZip(Directory(p.joinAll([testDataDir, "audio_1"])));
    zipExample = await createTmpZip(Directory(p.joinAll([testDataDir, "example_2"])));
  });

  tearDownAll(() async {
    await db.close();
  });

  test('Cross-Format Garbage Collection: Core data survives across different types', () async {
    print("\n--- TEST: Cross-Format Integration ---");
    
    // 1. Import all three formats
    await importDictionary(db, zipYomitan, DictionaryTypes.yomitan);
    await importDictionary(db, zipAudio, DictionaryTypes.audio);
    await importDictionary(db, zipExample, DictionaryTypes.examples);

    final indexes = await db.indexDao.getAllIndexes();
    final yomitanId = indexes.firstWhere((i) => i.dictionaryType == DictionaryTypes.yomitan).id;
    final audioId = indexes.firstWhere((i) => i.dictionaryType == DictionaryTypes.audio).id;
    final exampleId = indexes.firstWhere((i) => i.dictionaryType == DictionaryTypes.examples).id;

    // Helper to run the type-safe query
    Future<List> getSharedTerm() => 
      (db.select(db.termTable)..where((t) => t.term.equals('猫'))).get();

    // Prove the shared term "猫" exists in the central term_table
    expect(await getSharedTerm(), isNotEmpty);

    // 2. Delete the Example Dictionary
    print("Deleting Example Dict...");
    await runDeletion(db, exampleId);

    // Verify Examples are gone, but the shared Term SURVIVES for Yomitan/Audio
    expect(await db.select(db.exampleSentenceTable).get(), isEmpty, 
      reason: "Example sentence should be deleted");
    expect(await getSharedTerm(), isNotEmpty, 
      reason: "FAIL: Term '猫' was wrongly GC'd! Yomitan and Audio dicts still need it.");

    // 3. Delete the Audio Dictionary
    print("Deleting Audio Dict...");
    await runDeletion(db, audioId);

    // Verify Audio is gone, but the Term STILL SURVIVES for Yomitan
    expect(await db.select(db.audioTable).get(), isEmpty, 
      reason: "Audio entries should be deleted");
    expect(await getSharedTerm(), isNotEmpty, 
      reason: "FAIL: Term '猫' was wrongly GC'd! Yomitan dict still needs it.");

    // 4. Delete the Yomitan Dictionary (The Final Dictionary)
    print("Deleting Yomitan Dict...");
    await runDeletion(db, yomitanId);

    // NOW the term and all tokens should finally be garbage collected
    await assertAbsoluteDatabaseEmptiness(db);
  });
}