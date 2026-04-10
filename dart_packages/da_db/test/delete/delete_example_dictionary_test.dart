import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/da_db.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

import '../../../shared_utils/lib/da_db_paths.dart';
import '../dictionary_test_variables.dart';
import '../test_utils/db_files.dart';
import 'delete_dictionary_test_util.dart';

void main() {
  late DaDb db;
  late String zipEx1; 
  late String zipEx2; 
  late String zipEx3;

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
    
    zipEx1 = await createTmpZip(Directory(p.joinAll([testDataDir, "example_1"])));
    zipEx2 = await createTmpZip(Directory(p.joinAll([testDataDir, "example_2"])));
    zipEx3 = await createTmpZip(Directory(p.joinAll([testDataDir, "example_3"])));
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Example Dictionary Deletion & GC:', () {
    test('1. Deleting a unique Example Dictionary completely removes it', () async {
      await importDictionary(db, zipEx3, DictionaryTypes.examples);
      final indexes = await db.indexDao.getAllIndexes();
      expect(indexes, isNotEmpty);

      await runDeletion(db, indexes.first.id);
      await assertAbsoluteDatabaseEmptiness(db);
    });

    test('2. Shared Example data (Lang, Stats, Audio) survives when one dict is deleted', () async {
      await importDictionary(db, zipEx1, DictionaryTypes.examples);
      await importDictionary(db, zipEx2, DictionaryTypes.examples);

      final indexes = await db.indexDao.getAllIndexes();
      final dict1Id = indexes[0].id;
      final dict2Id = indexes[1].id;

      // Delete ONLY Dict 1
      await runDeletion(db, dict1Id);

      // --- CHECK PRESERVED SHARED DATA ---

      // 1. Dict 1's unique sentence should be deleted
      final sentenceQuery = await (db.select(db.exampleSentenceTable)
        ..where((t) => t.exampleSentence.equals('リンゴを食べる'))).get();
      expect(sentenceQuery, isEmpty, 
        reason: "FAIL: Dict 1's unique sentence was left behind!");

      // 2. Shared stat name must survive
      // Note: Change 't.name' to 't.statName' if that is what your Dart getter is named in StatNameTable
      final statQuery = await (db.select(db.statNameTable)
        ..where((t) => t.name.equals('quality'))).get();
      expect(statQuery, isNotEmpty, 
        reason: "FAIL: Shared stat name 'quality' was wrongly garbage collected!");

      // 3. Shared audio must survive
      final audioQuery = await (db.select(db.exampleAudioTable)
        ..where((t) => t.path.equals('media/apple.mp3'))).get();
      expect(audioQuery, isNotEmpty, 
        reason: "FAIL: Shared example audio 'media/apple.mp3' was wrongly garbage collected!");

      // Delete Dict 2
      await runDeletion(db, dict2Id);
      await assertAbsoluteDatabaseEmptiness(db);
    });
  });
}