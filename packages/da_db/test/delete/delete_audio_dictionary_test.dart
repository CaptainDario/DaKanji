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
  late String zipAud1; 
  late String zipAud2; 
  late String zipAud3;

  setUpAll(() async {
    if (File(daDbTestPath).existsSync()) {
      print("Deleting existing database file at $daDbTestPath...");
      File(daDbTestPath).deleteSync();
    }

    db = DaDb(
      dbPath: daDbTestPath,
      inMemory: true,
      languageProcessor: await japaneseProcessor,
    );

    final testDataDir = p.joinAll([daDbDataFilesPath, "deletion_test_data"]);
    
    zipAud1 = await createTmpZip(Directory(p.joinAll([testDataDir, "audio_1"])));
    zipAud2 = await createTmpZip(Directory(p.joinAll([testDataDir, "audio_2"])));
    zipAud3 = await createTmpZip(Directory(p.joinAll([testDataDir, "audio_3"])));
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Audio Dictionary Deletion & GC:', () {
    test('1. Deleting a unique Audio Dictionary completely removes it', () async {
      await importDictionary(db, zipAud3, DictionaryTypes.audio);
      
      final indexes = await db.indexDao.getAllIndexes();
      final indexId = indexes.first.id;

      // --- DEBUG PRINT: Let's see exactly what got saved! ---
      final allMedia = await db.select(db.mediaTable).get();
      print("DEBUG MEDIA TABLE: $allMedia");
      final allTerms = await db.select(db.termTable).get();
      print("DEBUG TERM TABLE: $allTerms");
      // ------------------------------------------------------

      // Flexible assertion checking if the media table has ANY rows at all
      expect(allMedia, isNotEmpty, reason: "FAIL: The media table is completely empty after import!");

      await runDeletion(db, indexId);
      await assertAbsoluteDatabaseEmptiness(db);
    });

    test('2. Shared Media and Terms survive when one Audio dict is deleted', () async {
      await importDictionary(db, zipAud1, DictionaryTypes.audio);
      await importDictionary(db, zipAud2, DictionaryTypes.audio);

      final indexes = await db.indexDao.getAllIndexes();
      final dict1Id = indexes[0].id;
      final dict2Id = indexes[1].id;

      // Delete ONLY Dict 1
      await runDeletion(db, dict1Id);

      // --- ASSERTIONS FOR PRESERVED SHARED DATA ---
      final survivingMedia = await db.select(db.mediaTable).get();
      print("DEBUG SURVIVING MEDIA: $survivingMedia");
      
      expect(survivingMedia, isNotEmpty, 
        reason: "FAIL: Shared media was wrongly garbage collected!");

      final survivingTerms = await (db.select(db.termTable)
        ..where((t) => t.term.equals('猫'))).get();
      expect(survivingTerms, isNotEmpty, 
        reason: "FAIL: Shared term '猫' was wrongly garbage collected!");

      // Delete Dict 2
      await runDeletion(db, dict2Id);
      await assertAbsoluteDatabaseEmptiness(db);
    });
  });
}