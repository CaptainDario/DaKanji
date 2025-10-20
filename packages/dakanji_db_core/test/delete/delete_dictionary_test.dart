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
      // Verify all data tables are empty (using a non-existent ID)
      await _verifyAllDictionaryData(db, -1, equals(0));

      // 2. --- IMPORT & VERIFY FIRST DICTIONARY ---
      print("Importing dictionary 1...");
      final import1 = await _importAndVerify(db, mecab, dataSourceZipPath);
      final indexId1 = import1.indexId;
      print(
          "Import 1 complete (ID: $indexId1). Terms: ${import1.termCount}, Kanji: ${import1.kanjiCount}");

      indexes = await (db.select(db.indexTable)).get();
      expect(indexes, hasLength(1));

      // 3. --- IMPORT & VERIFY SECOND DICTIONARY ---
      print("Importing dictionary 2...");
      final import2 = await _importAndVerify(db, mecab, dataSourceZipPath);
      final indexId2 = import2.indexId;
      print(
          "Import 2 complete (ID: $indexId2). Terms: ${import2.termCount}, Kanji: ${import2.kanjiCount}");

      // 4. --- VERIFY DATA FOR ID 2 (and ID 1 is unchanged) ---
      expect(indexId2, isNot(indexId1));
      expect(import2.termCount, equals(import1.termCount));
      expect(import2.kanjiCount, equals(import1.kanjiCount));

      // Check ID 1 is still there
      expect(await countTerms(db, indexId1), equals(import1.termCount));
      expect(await countKanji(db, indexId1), equals(import1.kanjiCount));
      indexes = await (db.select(db.indexTable)).get();
      expect(indexes, hasLength(2));

      // 5. --- DELETE FIRST DICTIONARY (ID 1) ---
      print("Deleting dictionary 1 (ID: $indexId1)...");
      await db.deletion.deleteDictionary(indexId1);

      // 6. --- VERIFY ID 1 IS GONE, ID 2 REMAINS ---
      print("Verifying deletion of ID 1...");
      await _verifyAllDictionaryData(db, indexId1, equals(0));

      // Check ID 2 is untouched
      print("Verifying dictionary 2 (ID: $indexId2) remains...");
      expect(await countTerms(db, indexId2), equals(import2.termCount));
      expect(await countKanji(db, indexId2), equals(import2.kanjiCount));
      // You could also re-run the _verifyAllDictionaryData with greaterThan(0)
      // await _verifyAllDictionaryData(db, indexId2, greaterThan(0));

      indexes = await (db.select(db.indexTable)).get();
      expect(indexes, hasLength(1));
      expect(indexes.first.id, equals(indexId2));

      // 7. --- DELETE SECOND DICTIONARY (ID 2) ---
      print("Deleting dictionary 2 (ID: $indexId2)...");
      await db.deletion.deleteDictionary(indexId2);

      // 8. --- VERIFY ALL DATA IS GONE ---
      print("Verifying deletion of ID 2...");
      await _verifyAllDictionaryData(db, indexId2, equals(0));

      indexes = await (db.select(db.indexTable)).get();
      expect(indexes, isEmpty);
      print("Deletion test complete.");
    });
  });
}

// --- HELPER FUNCTIONS ---

/// Imports a dictionary and verifies its main data, returning its new ID and counts.
Future<({int indexId, int termCount, int kanjiCount})> _importAndVerify(
  DaKanjiDB db,
  Mecab mecab,
  String dataSourceZipPath,
) async {
  await importDictionary(db, mecab, dataSourceZipPath);

  final indexes = await (db.select(db.indexTable)).get();
  final newIndexId = indexes.last.id;

  final termCount = await countTerms(db, newIndexId);
  final kanjiCount = await countKanji(db, newIndexId);

  expect(termCount, greaterThan(0));
  expect(kanjiCount, greaterThan(0));

  return (indexId: newIndexId, termCount: termCount, kanjiCount: kanjiCount);
}

/// Checks all data tables for a given indexId against a count matcher.
Future<void> _verifyAllDictionaryData(
    DaKanjiDB db, int indexId, Matcher countMatcher) async {
  expect(await countTerms(db, indexId), countMatcher,
      reason: "Term count mismatch for index $indexId");
  expect(await countKanji(db, indexId), countMatcher,
      reason: "Kanji count mismatch for index $indexId");
  expect(await countExamples(db, indexId), countMatcher,
      reason: "Example count mismatch for index $indexId");
  expect(await countAudio(db, indexId), countMatcher,
      reason: "Audio count mismatch for index $indexId");
  expect(await countKanjiMeta(db, indexId), countMatcher,
      reason: "KanjiMeta count mismatch for index $indexId");
  expect(await countTermMeta(db, indexId), countMatcher,
      reason: "TermMeta count mismatch for index $indexId");
}

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
    print(line); // Optional: for debugging
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");
}

// --- Generic Count Helper ---

/// Generic helper to count rows in a table matching an indexId.
Future<int> _countTableForIndex(
  DaKanjiDB db,
  TableInfo table,
  Expression<int> indexIdColumn,
  int indexId,
) async {
  final count = indexIdColumn.count();
  final query = db.selectOnly(table)
    ..addColumns([count])
    ..where(indexIdColumn.equals(indexId));
  return await query.map((row) => row.read(count)).getSingle() ?? 0;
}

// --- Specific Count Helpers (Refactored) ---

Future<int> countTerms(DaKanjiDB db, int indexId) => _countTableForIndex(
    db, db.termBankV3Table, db.termBankV3Table.indexId, indexId);

Future<int> countKanji(DaKanjiDB db, int indexId) => _countTableForIndex(
    db, db.kanjiBankV3Table, db.kanjiBankV3Table.indexId, indexId);

Future<int> countExamples(DaKanjiDB db, int indexId) => _countTableForIndex(
    db, db.exampleTable, db.exampleTable.indexId, indexId);

Future<int> countAudio(DaKanjiDB db, int indexId) =>
    _countTableForIndex(db, db.audioTable, db.audioTable.indexId, indexId);

Future<int> countKanjiMeta(DaKanjiDB db, int indexId) => _countTableForIndex(
    db, db.kanjiMetaBankV3Table, db.kanjiMetaBankV3Table.indexId, indexId);

Future<int> countTermMeta(DaKanjiDB db, int indexId) => _countTableForIndex(
    db, db.termMetaBankV3Table, db.termMetaBankV3Table.indexId, indexId);