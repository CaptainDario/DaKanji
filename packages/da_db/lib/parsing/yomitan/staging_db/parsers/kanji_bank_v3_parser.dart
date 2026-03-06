import 'dart:convert';

import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/db_file_parser.dart';
import 'package:da_db/parsing/util/parsing_constants.dart';
import 'package:da_db/parsing/util/staging_utils.dart';
import 'package:language_processing/language_processing.dart';

class KanjiBankV3Parser implements DbFileParser {
  @override
  bool canHandle(String fileName) => fileName.startsWith(kanjiBankPrefix);

  @override
  Future<int> parseFileContent(
    inputBytes,
    StagingDatabase db,
    LanguageProcessor? lp,
    ProcessorOptions options,
    int startId,
  ) async {
    if (lp == null) throw Exception("LanguageProcessor required for kanji parser");

    List jsonInput = jsonDecode(utf8.decode(inputBytes[0]));
    int localId = startId;
    
    var kanjiRows = <List<Object?>>[];
    var readingRows = <List<Object?>>[];
    var defRows = <List<Object?>>[];
    var tagRows = <List<Object?>>[];
    var statRows = <List<Object?>>[];

    const int batchSize = 1000;

    for (final entry in jsonInput) {
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
    await db.transaction(() async {
      await insertChunked(db, db.kanjiStagingTable.actualTableName, 
        ['local_id', 'kanji', 'original_onyomi', 'original_kunyomi'], kanjiRows);
          
      await insertChunked(db, db.kanjiReadingStagingTable.actualTableName, 
        ['kanji_local_id', 'reading', 'reading_normalized', 'type', 'position'], readingRows);

      await insertChunked(db, db.kanjiDefinitionStagingTable.actualTableName, 
        ['kanji_local_id', 'definition', 'position'], defRows);

      await insertChunked(db, db.kanjiTagStagingTable.actualTableName, 
        ['kanji_local_id', 'tag_name'], tagRows);

      await insertChunked(db, db.kanjiStatStagingTable.actualTableName, 
        ['kanji_local_id', 'tag_name', 'value'], statRows);
    });
  }
}