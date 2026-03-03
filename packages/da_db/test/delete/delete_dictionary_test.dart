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
  
  // Zipped paths for the tiny Yomitan text dicts ONLY
  late String zipDict1; // Tiny Dict A (Shares "猫")
  late String zipDict2; // Tiny Dict B (Shares "猫")
  late String zipDict3; // Tiny Dict C (Unique "犬")

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

    // Setup paths based on your global dataFilesPath tree
    final testDataDir = p.joinAll([daDbDataFilesPath, "deletion_test_data"]);
    
    zipDict1 = await createTmpZip(Directory(p.joinAll([testDataDir, "yomitan_1"])));
    zipDict2 = await createTmpZip(Directory(p.joinAll([testDataDir, "yomitan_2"])));
    zipDict3 = await createTmpZip(Directory(p.joinAll([testDataDir, "yomitan_3"])));
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Yomitan Dictionary Deletion & Garbage Collection:', () {
    
    test('1. Deleting the only dictionary completely removes it', () async {
      print("\n--- TEST 1: Unique Dictionary (Dict 3) ---");
      await importDictionary(db, zipDict3, DictionaryTypes.yomitan);
      
      final indexes = await db.indexDao.getAllIndexes();
      final indexId = indexes.first.id;

      // Ensure "犬" is in the shared tables
      final inuTerm = await (db.select(db.termTable)..where((t) => t.term.equals('犬'))).get();
      expect(inuTerm, isNotEmpty);

      print("Deleting Dict 3 (ID: $indexId)...");
      await runDeletion(db, indexId);

      // Verify absolute absence (Cascades + GC worked)
      await assertAbsoluteDatabaseEmptiness(db);
    });

    test('2. Shared data survives when one dictionary is deleted, but dies when both are', () async {
      print("\n--- TEST 2: Shared Overlap (Dict 1 & 2) ---");
      // Import Dict 1 and Dict 2 (Both share the term "猫" and kanji "猫")
      await importDictionary(db, zipDict1, DictionaryTypes.yomitan);
      await importDictionary(db, zipDict2, DictionaryTypes.yomitan);

      final indexes = await db.indexDao.getAllIndexes();
      expect(indexes, hasLength(2));
      final dict1Id = indexes[0].id;
      final dict2Id = indexes[1].id;

      // Delete ONLY Dict 1
      print("Deleting Dict 1 (ID: $dict1Id)...");
      await runDeletion(db, dict1Id);

      // --- ASSERTIONS FOR PRESERVED SHARED DATA ---
      // Dict 1 specific data should be gone
      expect(await (db.select(db.termBankV3Table)..where((t) => t.indexId.equals(dict1Id))).get(), isEmpty);
      
      // Shared Data MUST survive because Dict 2 still needs it!
      final sharedTerm = await (db.select(db.termTable)..where((t) => t.term.equals('猫'))).get();
      expect(sharedTerm, isNotEmpty, 
        reason: "FAIL: Shared term '猫' was wrongly garbage collected!");
        
      final sharedKanji = await (db.select(db.kanjiTable)..where((t) => t.kanji.equals('猫'))).get();
      expect(sharedKanji, isNotEmpty, 
        reason: "FAIL: Shared kanji '猫' was wrongly garbage collected!");
        
      final sharedMeta = await (db.select(db.termMetaBankV3TypeTable)..where((t) => t.type.equals('freq'))).get();
      expect(sharedMeta, isNotEmpty, 
        reason: "FAIL: Shared metadata type 'freq' was wrongly garbage collected!");

      // Delete Dict 2
      print("Deleting Dict 2 (ID: $dict2Id)...");
      await runDeletion(db, dict2Id);

      // Now the database should be completely empty again
      await assertAbsoluteDatabaseEmptiness(db);
    });
  });
}