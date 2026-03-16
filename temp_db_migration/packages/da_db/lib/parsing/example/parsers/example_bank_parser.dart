import 'dart:convert';
import 'dart:typed_data';

import 'package:da_db/database/index/yomitan_index.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/db_file_parser.dart';
import 'package:da_db/parsing/util/parsing_constants.dart';
import 'package:da_db/parsing/util/staging_utils.dart';
import 'package:language_processing/language_processing.dart';

class ExampleBankParser implements DbFileParser {
  
  @override
  bool canHandle(String fileName) => fileName.startsWith(exampleBankPrefix);

  @override
  Future<int> parseFileContent(
    List<Uint8List> inputBytes,
    StagingDatabase db,
    LanguageProcessor? lp,
    ProcessorOptions options,
    int startId,
    YomitanIndex index,
  ) async {
    if (lp == null) throw Exception("LanguageProcessor is required for parsing examples");
    
    List jsonInput = jsonDecode(utf8.decode(inputBytes[0]));
    
    int exampleLocalId = startId;
    int audioLocalId = startId; 
    
    var exampleRows = <List<Object?>>[];
    var tagRows = <List<Object?>>[];
    var statRows = <List<Object?>>[];
    var audioRows = <List<Object?>>[];
    var audioTagRows = <List<Object?>>[];
    var audioStatRows = <List<Object?>>[];
    
    const int batchSize = 1000;

    for (final entry in jsonInput) {
      if (entry is! Map<String, dynamic>) continue;

      final sentence = entry['sentence'] as String?;
      if (sentence == null || sentence.trim().isEmpty) continue;

      exampleLocalId++;

      final groupId = entry['groupId'] as int? ?? 0;

      // apply the language processor if the language matches
      String? exampleTokenized;
      if(index.sourceLanguage == lp.languageCode) {
        // 1. Analyze sentence with the Language Processor to extract tokens
        final parseResult = lp.parse(sentence, ProcessorOptions());

        // 2. Terms 
        exampleTokenized = parseResult.tokens.join(" ");
      }

      // Add 5 columns to the main table
      exampleRows.add([exampleLocalId, groupId, sentence, exampleTokenized]);

      // Tags
      final tags = (entry['tags'] as List<dynamic>?)?.cast<String>() ?? [];
      for (final t in tags) {
        if (t.trim().isEmpty) continue;
        tagRows.add([exampleLocalId, t.trim()]);
      }

      // Stats
      final stats = (entry['stats'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];
      for (final s in stats) {
        statRows.add([
          exampleLocalId, 
          s['statName'] as String,
          s['displayName'] as String?,
          s['value'] != null ? (s['value'] as num).toDouble() : null,
          s['displayValue'] as String?
        ]);
      }

      // Audios
      final audios = (entry['audios'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];
      for (final audio in audios) {
        audioLocalId++;
        final path = audio['url'] as String? ?? '';
        final name = path.split('/').last;

        audioRows.add([audioLocalId, exampleLocalId, path, name]);

        final aTags = (audio['tags'] as List<dynamic>?)?.cast<String>() ?? [];
        for (final t in aTags) {
          if (t.trim().isEmpty) continue;
          audioTagRows.add([audioLocalId, t.trim()]);
        }

        final aStats = (audio['stats'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];
        for (final s in aStats) {
          audioStatRows.add([
            audioLocalId, 
            s['statName'] as String,
            s['displayName'] as String?,
            s['value'] != null ? (s['value'] as num).toDouble() : null,
            s['displayValue'] as String?
          ]);
        }
      }

      if (exampleRows.length >= batchSize) {
        await _flush(db, exampleRows, tagRows, statRows, audioRows, audioTagRows, audioStatRows);
        exampleRows.clear(); tagRows.clear(); statRows.clear(); 
        audioRows.clear(); audioTagRows.clear(); audioStatRows.clear();
      }
    }

    if (exampleRows.isNotEmpty) {
      await _flush(db, exampleRows, tagRows, statRows, audioRows, audioTagRows, audioStatRows);
    }
    
    return exampleLocalId;
  }

  Future<void> _flush(
    StagingDatabase db, 
    List<List<Object?>> exampleRows,
    List<List<Object?>> tagRows,
    List<List<Object?>> statRows,
    List<List<Object?>> audioRows,
    List<List<Object?>> audioTagRows,
    List<List<Object?>> audioStatRows,
  ) async {
    await db.transaction(() async {
      if (exampleRows.isNotEmpty) {
        await insertChunked(
          db, db.exampleStagingTable.actualTableName,
          ['local_id', 'group_id', 'example_sentence', 'example_sentence_tokenized'],
          exampleRows
        );
      }
      if (tagRows.isNotEmpty) {
        await insertChunked(
          db, db.exampleTagStagingTable.actualTableName,
          ['example_local_id', 'tag_name'],
          tagRows
        );
      }
      if (statRows.isNotEmpty) {
        await insertChunked(
          db, db.exampleStatStagingTable.actualTableName,
          ['example_local_id', 'stat_name', 'display_name', 'stat_value', 'display_value'],
          statRows
        );
      }
      if (audioRows.isNotEmpty) {
        await insertChunked(
          db, db.exampleAudioStagingTable.actualTableName,
          ['local_id', 'example_local_id', 'path', 'name'],
          audioRows
        );
      }
      if (audioTagRows.isNotEmpty) {
        await insertChunked(
          db, db.exampleAudioTagStagingTable.actualTableName,
          ['audio_local_id', 'tag_name'],
          audioTagRows
        );
      }
      if (audioStatRows.isNotEmpty) {
        await insertChunked(
          db, db.exampleAudioStatStagingTable.actualTableName,
          ['audio_local_id', 'stat_name', 'display_name', 'stat_value', 'display_value'],
          audioStatRows
        );
      }
    });
  }
}