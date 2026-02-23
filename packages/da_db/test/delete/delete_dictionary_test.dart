import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/audio_parser.dart' as audio_parser;
import 'package:da_db/parsing/yomitan_staging_db_parser.dart' as yomitan_parser;
import 'package:da_db_shared/paths.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

import '../dictionary_test_variables.dart'; // Adjust imports as needed
import '../test_utils/db_files.dart';

void main() {
  late DaDb db;
  
  // Zipped paths for the tiny text dicts
  late String zipDict1; // Tiny Dict A (Shares "猫")
  late String zipDict2; // Tiny Dict B (Shares "猫")
  late String zipDict3; // Tiny Dict C (Unique "犬")

  // Zipped paths for ALL audio formats
  late String zipAudioEntries; 
  late String zipAudioIndex; 
  late String zipAudioFileName;
  

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
    final testDataDir = p.joinAll([dataFilesPath, "deletion_test_data"]);
    
    zipDict1 = await createTmpZip(Directory(p.joinAll([testDataDir, "yomitan_1"])));
    zipDict2 = await createTmpZip(Directory(p.joinAll([testDataDir, "yomitan_2"])));
    zipDict3 = await createTmpZip(Directory(p.joinAll([testDataDir, "yomitan_3"])));
    
    // Using entries_format for the audio test
    zipAudioEntries = await createTmpZip(Directory(devExampleAudioEntriesFormatPath));
    zipAudioIndex = await createTmpZip(Directory(devExampleAudioIndexFormatPath));
    zipAudioFileName = await createTmpZip(Directory(devExampleAudioFileNameFormatPath));
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Dictionary Deletion & Garbage Collection:', () {
    
    test('1. Deleting the only dictionary completely removes it', () async {
      print("\n--- TEST 1: Unique Dictionary (Dict 3) ---");
      await _importDictionary(db, zipDict3, DictionaryTypes.yomitan);
      
      final indexes = await db.indexDao.getAllIndexes();
      final indexId = indexes.first.id;

      // Ensure "犬" is in the shared tables
      expect(await db.customSelect("SELECT * FROM term_table WHERE term = '犬'").get(), isNotEmpty);

      print("Deleting Dict 3 (ID: $indexId)...");
      await _runDeletion(db, indexId);

      // Verify absolute absence (Cascades + GC worked)
      await _assertAbsoluteDatabaseEmptiness(db);
    });

    test('2. Shared data survives when one dictionary is deleted, but dies when both are', () async {
      print("\n--- TEST 2: Shared Overlap (Dict 1 & 2) ---");
      // Import Dict 1 and Dict 2 (Both share the term "猫" and kanji "猫")
      await _importDictionary(db, zipDict1, DictionaryTypes.yomitan);
      await _importDictionary(db, zipDict2, DictionaryTypes.yomitan);

      final indexes = await db.indexDao.getAllIndexes();
      expect(indexes, hasLength(2));
      final dict1Id = indexes[0].id;
      final dict2Id = indexes[1].id;

      // Delete ONLY Dict 1
      print("Deleting Dict 1 (ID: $dict1Id)...");
      await _runDeletion(db, dict1Id);

      // --- ASSERTIONS FOR PRESERVED SHARED DATA ---
      // Dict 1 specific data should be gone
      expect(await (db.select(db.termBankV3Table)..where((t) => t.indexId.equals(dict1Id))).get(), isEmpty);
      
      // Shared Data MUST survive because Dict 2 still needs it!
      expect(await db.customSelect("SELECT * FROM term_table WHERE term = '猫'").get(), isNotEmpty, 
        reason: "FAIL: Shared term '猫' was wrongly garbage collected!");
      expect(await db.customSelect("SELECT * FROM kanji_table WHERE kanji = '猫'").get(), isNotEmpty, 
        reason: "FAIL: Shared kanji '猫' was wrongly garbage collected!");
      expect(await db.customSelect("SELECT * FROM term_meta_bank_v3_type_table WHERE type = 'freq'").get(), isNotEmpty, 
        reason: "FAIL: Shared metadata type 'freq' was wrongly garbage collected!");

      // Delete Dict 2
      print("Deleting Dict 2 (ID: $dict2Id)...");
      await _runDeletion(db, dict2Id);

      // Now the database should be completely empty again
      await _assertAbsoluteDatabaseEmptiness(db);
    });

    test('3. Single Audio dictionary deletion correctly cleans media and audio tables', () async {
      print("\n--- TEST 3: Single Audio Dictionary Cleanup ---");
      await _importDictionary(db, zipAudioEntries, DictionaryTypes.audio);

      final indexes = await db.indexDao.getAllIndexes();
      expect(indexes, hasLength(1));
      final audioDictId = indexes.first.id;

      expect(await db.select(db.audioTable).get(), isNotEmpty);
      expect(await db.select(db.mediaTable).get(), isNotEmpty);

      print("Deleting Audio Dict (ID: $audioDictId)...");
      await _runDeletion(db, audioDictId);
      
      await _assertAbsoluteDatabaseEmptiness(db);
    });

    test('4. Multiple Audio dictionary formats share data and clean up correctly', () async {
      print("\n--- TEST 4: Comprehensive Audio Sharing & Cleanup ---");
      
      // Import ALL THREE audio formats!
      await _importDictionary(db, zipAudioEntries, DictionaryTypes.audio);
      await _importDictionary(db, zipAudioIndex, DictionaryTypes.audio);
      await _importDictionary(db, zipAudioFileName, DictionaryTypes.audio);

      final indexes = await db.indexDao.getAllIndexes();
      expect(indexes, hasLength(3), reason: "FAIL: Not all audio dictionaries imported!");

      final entriesDictId = indexes[0].id;
      final indexDictId = indexes[1].id;
      final fileNameDictId = indexes[2].id;

      // "日本人" is shared across all three audio dictionaries. Prove it exists!
      final sharedTermQuery = "SELECT * FROM term_table WHERE term = '日本人'";
      expect(await db.customSelect(sharedTermQuery).get(), isNotEmpty, 
        reason: "Shared term '日本人' should exist in the term_table");

      // 1. Delete Entries Format
      print("Deleting Entries Dict (ID: $entriesDictId)...");
      await _runDeletion(db, entriesDictId);

      expect(await db.customSelect(sharedTermQuery).get(), isNotEmpty,
        reason: "FAIL: '日本人' was wrongly GC'd! It is still used by Index and FileName dicts.");

      // 2. Delete Index Format
      print("Deleting Index Dict (ID: $indexDictId)...");
      await _runDeletion(db, indexDictId);

      expect(await db.customSelect(sharedTermQuery).get(), isNotEmpty,
        reason: "FAIL: '日本人' was wrongly GC'd! It is still used by FileName dict.");

      // 3. Delete File Name Format (The Final Audio Dict)
      print("Deleting FileName Dict (ID: $fileNameDictId)...");
      await _runDeletion(db, fileNameDictId);

      // Now that all dictionaries holding "日本人" are gone, the DB should be 100% empty!
      await _assertAbsoluteDatabaseEmptiness(db);
    });

  });
}

// --- Helper Functions ---

/// Imports a dictionary from a zip path
Future<void> _importDictionary(DaDb db, String zipPath, DictionaryTypes t) async {

  late var parse;
  if(t == DictionaryTypes.audio) {
    parse = audio_parser.parseAudioDataSource;
  }
  else if (t == DictionaryTypes.yomitan) {
    parse = yomitan_parser.parseDictionaryDataSource;
  }
  else if (t == DictionaryTypes.examples) {

  }

  final stream = await parse(
    dataSourcePath: zipPath,
    db: db,
    isDefaultDictionary: false,
  );
  await for (final message in stream) {
    print("  -> $message");
  }
}

/// Executes the deletion stream and prints progress
Future<void> _runDeletion(DaDb db, int indexId) async {
  final stream = db.deletionDao.deleteDictionary(indexId);
  await for (final message in stream) {
    print("  -> $message");
  }
}

/// A highly strict, dynamic assertion that ensures EVERY defined table in the DB is empty.
Future<void> _assertAbsoluteDatabaseEmptiness(DaDb db) async {
  // db.allTables contains every table defined in your Drift schema!
  for (final table in db.allTables) {
    final tableName = table.actualTableName;
    
    int count = 0;
    
    try {
      // First try standard COUNT(*) which works for 99% of tables
      final result = await db.customSelect('SELECT COUNT(*) as c FROM $tableName').getSingle();
      count = result.read<int>('c');
    } catch (e) {
      // Fallback for strict contentless FTS5 tables which sometimes require explicit rowid counting
      final result = await db.customSelect('SELECT COUNT(rowid) as c FROM $tableName').getSingle();
      count = result.read<int>('c');
    }

    // The assertion! If any table fails, the reason will tell you EXACTLY which one it was.
    expect(
      count, 
      equals(0), 
      reason: "FAIL: Table '$tableName' is NOT empty! It left behind $count orphaned rows."
    );
  }
}