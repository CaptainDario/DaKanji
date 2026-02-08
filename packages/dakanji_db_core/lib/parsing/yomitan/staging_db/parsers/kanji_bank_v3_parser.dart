import 'package:dakanji_db_core/parsing/staging_db/staging_db.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/parsers/yomitan_file_parser.dart';
import 'package:language_processing/language_processing.dart';

class KanjiBankV3Parser implements YomitanFileParser {
  @override
  bool canHandle(String fileName) => fileName.contains("kanji_bank");

  @override
  Future<int> parseFileContent(
    List<dynamic> jsonContent,
    StagingDatabase db,
    LanguageProcessor? lp,
    ProcessorOptions options,
    bool saveJson,
    int startId,
  ) async {
    if (lp == null) throw Exception("LanguageProcessor required for kanji parser");

    int localId = startId;
    
    var kanjiRows = <List<Object?>>[];
    var readingRows = <List<Object?>>[];
    var defRows = <List<Object?>>[];
    var tagRows = <List<Object?>>[];
    var statRows = <List<Object?>>[];

    const int batchSize = 1000;

    for (final entry in jsonContent) {
      if (entry is! List) continue;

      localId++;

      // JSON Structure: [kanji, onyomi, kunyomi, tags, definitions, stats]
      final kanji = entry[0] as String;
      final onyomiStr = entry[1] as String;
      final kunyomiStr = entry[2] as String;
      final tagsStr = entry[3] as String;
      final definitions = (entry[4] as List).cast<String>();
      final stats = (entry[5] as Map).cast<String, String>();

      kanjiRows.add([localId, kanji, onyomiStr, kunyomiStr]);

      // --- 1. Onyomi ---
      if (onyomiStr.isNotEmpty) {
        int pos = 0;
        for (final r in onyomiStr.split(' ')) {
          if (r.isEmpty) continue;
          String? norm = lp.normalize(r, options).firstOrNull;
          if (norm == r) norm = null;
          readingRows.add([localId, r, norm, 'onyomi', pos++]);
        }
      }

      // --- 2. Kunyomi ---
      if (kunyomiStr.isNotEmpty) {
        int pos = 0;
        for (final r in kunyomiStr.split(' ')) {
          if (r.isEmpty) continue;
          String? norm = lp.normalize(r, options).firstOrNull;
          if (norm == r) norm = null;
          readingRows.add([localId, r, norm, 'kunyomi', pos++]);
        }
      }

      // --- 3. Tags ---
      if (tagsStr.isNotEmpty) {
        for (final t in tagsStr.split(' ')) {
          if (t.isEmpty) continue;
          tagRows.add([localId, t]);
        }
      }

      // --- 4. Definitions ---
      int defPos = 0;
      for (final d in definitions) {
        defRows.add([localId, d, defPos++]);
      }

      // --- 5. Stats ---
      for (final entry in stats.entries) {
        statRows.add([localId, entry.key, entry.value]);
      }

      if (kanjiRows.length >= batchSize) {
        await _flush(db, kanjiRows, readingRows, defRows, tagRows, statRows);
        kanjiRows.clear(); readingRows.clear(); defRows.clear(); tagRows.clear(); statRows.clear();
      }
    }

    if (kanjiRows.isNotEmpty) {
      await _flush(db, kanjiRows, readingRows, defRows, tagRows, statRows);
    }

    return localId;
  }

  Future<void> _flush(
    StagingDatabase db,
    List<List<Object?>> kanjiRows,
    List<List<Object?>> readingRows,
    List<List<Object?>> defRows,
    List<List<Object?>> tagRows,
    List<List<Object?>> statRows,
  ) async {
    String placeholders(int count) => '(${List.filled(count, '?').join(', ')})';

    await db.transaction(() async {
      if (kanjiRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.kanjiStagingTable.actualTableName} (local_id, kanji, original_onyomi, original_kunyomi) VALUES ${List.filled(kanjiRows.length, placeholders(4)).join(', ')}';
        await db.customStatement(sql, kanjiRows.expand((i) => i).toList());
      }
      if (readingRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.kanjiReadingStagingTable.actualTableName} (kanji_local_id, reading, reading_normalized, type, position) VALUES ${List.filled(readingRows.length, placeholders(5)).join(', ')}';
        await db.customStatement(sql, readingRows.expand((i) => i).toList());
      }
      if (defRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.kanjiDefinitionStagingTable.actualTableName} (kanji_local_id, definition, position) VALUES ${List.filled(defRows.length, placeholders(3)).join(', ')}';
        await db.customStatement(sql, defRows.expand((i) => i).toList());
      }
      if (tagRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.kanjiTagStagingTable.actualTableName} (kanji_local_id, tag_name) VALUES ${List.filled(tagRows.length, placeholders(2)).join(', ')}';
        await db.customStatement(sql, tagRows.expand((i) => i).toList());
      }
      if (statRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.kanjiStatStagingTable.actualTableName} (kanji_local_id, tag_name, value) VALUES ${List.filled(statRows.length, placeholders(3)).join(', ')}';
        await db.customStatement(sql, statRows.expand((i) => i).toList());
      }
    });
  }
}