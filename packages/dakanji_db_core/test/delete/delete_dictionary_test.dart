import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/dakanji_db_shared.dart';
import 'package:drift/drift.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

import '../util/db_files.dart';



void main() {
  late DaKanjiDB db;
  late Mecab mecab;
  late String dataSourceZipPath;

  // Set up the DB, Mecab, and Zipped Dictionary Path ONCE for all tests
  setUpAll(() async {
    db = DaKanjiDB(dbPath: dakanjiDbPath, inMemory: true);
    
    mecab = Mecab();
    await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

    dataSourceZipPath =
        await createTmpZip(Directory(yomitanSampleDictionaryPath));
  });

  tearDownAll(() async {
    await db.close();
  });

  // --- New Deletion Test Group ---
  group('Dictionary Import and Deletion Tests', () {
    // Before EACH test in this group, clear the DB
    setUp(() async {
      await db.clearDB();
    });

    test('importing twice and deleting sequentially works as intended',
        () async {
      // 1. --- VERIFY DB IS EMPTY ---
      var indexes = await (db.select(db.indexTable)).get();
      expect(indexes, isEmpty);

      // 2. --- IMPORT FIRST DICTIONARY ---
      print("Importing dictionary 1...");
      await importDictionary(db, mecab, dataSourceZipPath);
      
      indexes = await (db.select(db.indexTable)).get();
      expect(indexes, hasLength(1));
      final int indexId1 = indexes.first.id;

      // 3. --- VERIFY DATA EXISTS FOR ID 1 ---
      final int termCount1 = await countTerms(db, indexId1);
      final int kanjiCount1 = await countKanji(db, indexId1);
      // You can add other counts here (examples, audio) if needed
      
      expect(termCount1, greaterThan(0));
      expect(kanjiCount1, greaterThan(0));
      print("Import 1 complete. Terms: $termCount1, Kanji: $kanjiCount1");


      // 4. --- IMPORT SECOND DICTIONARY ---
      print("Importing dictionary 2...");
      await importDictionary(db, mecab, dataSourceZipPath);

      indexes = await (db.select(db.indexTable)).get();
      expect(indexes, hasLength(2));
      final int indexId2 = indexes.last.id;
      expect(indexId2, isNot(indexId1));

      // 5. --- VERIFY DATA EXISTS FOR ID 2 (and ID 1 is unchanged) ---
      final int termCount2 = await countTerms(db, indexId2);
      final int kanjiCount2 = await countKanji(db, indexId2);

      expect(termCount2, equals(termCount1)); // Should be same data
      expect(kanjiCount2, equals(kanjiCount1));
      
      // Check ID 1 is still there
      expect(await countTerms(db, indexId1), equals(termCount1));
      expect(await countKanji(db, indexId1), equals(kanjiCount1));
      print("Import 2 complete. Terms: $termCount2, Kanji: $kanjiCount2");


      // 6. --- DELETE FIRST DICTIONARY (ID 1) ---
      print("Deleting dictionary 1 (ID: $indexId1)...");
      await deleteAllDataForIndex(db, indexId1); // This now calls your REAL functions

      // 7. --- VERIFY ID 1 IS GONE, ID 2 REMAINS ---
      print("Verifying deletion of ID 1...");
      expect(await countTerms(db, indexId1), equals(0));
      expect(await countKanji(db, indexId1), equals(0));
      // Add other counts to verify all data is gone
      expect(await countExamples(db, indexId1), equals(0));
      expect(await countAudio(db, indexId1), equals(0));
      expect(await countKanjiMeta(db, indexId1), equals(0));
      expect(await countTermMeta(db, indexId1), equals(0));


      // Check ID 2 is untouched
      expect(await countTerms(db, indexId2), equals(termCount2));
      expect(await countKanji(db, indexId2), equals(kanjiCount2));

      indexes = await (db.select(db.indexTable)).get();
      expect(indexes, hasLength(1));
      expect(indexes.first.id, equals(indexId2));


      // 8. --- DELETE SECOND DICTIONARY (ID 2) ---
      print("Deleting dictionary 2 (ID: $indexId2)...");
      await deleteAllDataForIndex(db, indexId2);

      // 9. --- VERIFY ALL DATA IS GONE ---
      print("Verifying deletion of ID 2...");
      expect(await countTerms(db, indexId2), equals(0));
      expect(await countKanji(db, indexId2), equals(0));
      
      indexes = await (db.select(db.indexTable)).get();
      expect(indexes, isEmpty);
      print("Deletion test complete.");

    });
  });
}

// --- HELPER FUNCTIONS ---

/// Imports a dictionary from the given path
Future importDictionary(
    DaKanjiDB db, Mecab mecab, String dataSourceZipPath) async {
  Stopwatch s = Stopwatch()..start();
  Stream<String> progress = await parseDictionaryDataSource(
      dataSourcePath: dataSourceZipPath,
      db: db,
      addFullJsonDefinitions: false,
      mecab: mecab);
  
  // Consume the stream
  await for (var line in progress) {
    // print(line); // Optional: for debugging
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");
}

/// Top-level delete function that calls all other delete functions
/// This function **assumes you have imported** all the individual delete functions
Future deleteAllDataForIndex(DaKanjiDB db, int indexId) async {
  await db.transaction(() async {
    // Call all the delete functions we've created
    // These functions are now imported from your app's code
    await db.deletion.deleteDictionary(indexId);

    // Finally, delete the main IndexTable entry
    await (db.delete(db.indexTable)..where((tbl) => tbl.id.equals(indexId)))
        .go();
  });
}

// --- Count Helpers for Verification (Test-Specific) ---

Future<int> countTerms(DaKanjiDB db, int indexId) async {
  final count = db.termBankV3Table.indexId.count();
  final query = db.selectOnly(db.termBankV3Table)
    ..addColumns([count])
    ..where(db.termBankV3Table.indexId.equals(indexId));
  return await query.map((row) => row.read(count)).getSingle() ?? 0;
}

Future<int> countKanji(DaKanjiDB db, int indexId) async {
  final count = db.kanjiBankV3Table.indexId.count();
  final query = db.selectOnly(db.kanjiBankV3Table)
    ..addColumns([count])
    ..where(db.kanjiBankV3Table.indexId.equals(indexId));
  return await query.map((row) => row.read(count)).getSingle() ?? 0;
}

Future<int> countExamples(DaKanjiDB db, int indexId) async {
  final count = db.exampleTable.indexId.count();
  final query = db.selectOnly(db.exampleTable)
    ..addColumns([count])
    ..where(db.exampleTable.indexId.equals(indexId));
  return await query.map((row) => row.read(count)).getSingle() ?? 0;
}

Future<int> countAudio(DaKanjiDB db, int indexId) async {
  final count = db.audioTable.indexId.count();
  final query = db.selectOnly(db.audioTable)
    ..addColumns([count])
    ..where(db.audioTable.indexId.equals(indexId));
  return await query.map((row) => row.read(count)).getSingle() ?? 0;
}

Future<int> countKanjiMeta(DaKanjiDB db, int indexId) async {
  final count = db.kanjiMetaBankV3Table.indexId.count();
  final query = db.selectOnly(db.kanjiMetaBankV3Table)
    ..addColumns([count])
    ..where(db.kanjiMetaBankV3Table.indexId.equals(indexId));
  return await query.map((row) => row.read(count)).getSingle() ?? 0;
}

Future<int> countTermMeta(DaKanjiDB db, int indexId) async {
  final count = db.termMetaBankV3Table.indexId.count();
  final query = db.selectOnly(db.termMetaBankV3Table)
    ..addColumns([count])
    ..where(db.termMetaBankV3Table.indexId.equals(indexId));
  return await query.map((row) => row.read(count)).getSingle() ?? 0;
}