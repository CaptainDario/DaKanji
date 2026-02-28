import 'dart:convert';

import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/db_file_parser.dart';
import 'package:language_processing/language_processing.dart';

class ExampleBankParser implements DbFileParser {
  
  @override
  bool canHandle(String fileName) => fileName.contains("example_bank");

  @override
  Future<int> parseFileContent(
    List<int> inputBytes,
    StagingDatabase db,
    LanguageProcessor? lp,
    ProcessorOptions options,
    int startId,
  ) async {
    if (lp == null) throw Exception("LanguageProcessor is required for parsing examples");
    
    List jsonInput = jsonDecode(utf8.decode(inputBytes));
    
    int exampleLocalId = startId;
    int audioLocalId = startId; 
    
    var exampleRows = <List<Object?>>[];
    var tagRows = <List<Object?>>[];
    var statRows = <List<Object?>>[];
    var termRows = <List<Object?>>[];
    var audioRows = <List<Object?>>[];
    var audioTagRows = <List<Object?>>[];
    var audioStatRows = <List<Object?>>[]; // New for audio stats
    
    const int batchSize = 1000;

    for (final entry in jsonInput) {
      if (entry is! Map<String, dynamic>) continue;

      exampleLocalId++; 

      final groupId = entry['groupId'] as int? ?? 0;
      final sentence = entry['sentence'] as String;
      // Using langIso3Code matching your new JSON
      final langIsoCode = entry['langIso3Code'] as String? ?? 'jpn';
      final reading = entry['sentenceReading'] as String?;

      // NLP Processing
      final String tokens = entry['tokens'] ?? lp.tokenize(sentence) ?? ""; 

      // Hardcoded quality, difficulty, and source are gone!
      exampleRows.add([
        exampleLocalId, groupId, langIsoCode, sentence, reading, tokens
      ]);

      // Tags
      final tags = (entry['tags'] as List<dynamic>?)?.cast<String>() ?? [];
      for (final t in tags) {
        if (t.trim().isEmpty) continue;
        tagRows.add([exampleLocalId, t.trim()]);
      }

      // Stats (Updated to match the new 4-field schema)
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

      // Terms
      final termList = tokens.split(' ').where((t) => t.trim().isNotEmpty).toSet();
      for (final term in termList) {
        termRows.add([exampleLocalId, term]);
      }

      // Audios
      final audios = (entry['audios'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];
      for (final audio in audios) {
        audioLocalId++;
        final path = audio['url'] as String? ?? '';
        final name = path.split('/').last;

        // Speaker, quality, and notes are gone!
        audioRows.add([audioLocalId, exampleLocalId, path, name]);

        // Audio Tags
        final aTags = (audio['tags'] as List<dynamic>?)?.cast<String>() ?? [];
        for (final t in aTags) {
          if (t.trim().isEmpty) continue;
          audioTagRows.add([audioLocalId, t.trim()]);
        }

        // Audio Stats
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
        await _flush(db, exampleRows, tagRows, statRows, termRows, audioRows, audioTagRows, audioStatRows);
        exampleRows.clear(); tagRows.clear(); statRows.clear(); 
        termRows.clear(); audioRows.clear(); audioTagRows.clear(); audioStatRows.clear();
      }
    }

    if (exampleRows.isNotEmpty) {
      await _flush(db, exampleRows, tagRows, statRows, termRows, audioRows, audioTagRows, audioStatRows);
    }
    
    return exampleLocalId;
  }

  Future<void> _flush(
    StagingDatabase db, 
    List<List<Object?>> exampleRows,
    List<List<Object?>> tagRows,
    List<List<Object?>> statRows,
    List<List<Object?>> termRows,
    List<List<Object?>> audioRows,
    List<List<Object?>> audioTagRows,
    List<List<Object?>> audioStatRows,
  ) async {
    String placeholders(int count) => '(${List.filled(count, '?').join(', ')})';

    await db.transaction(() async {
      if (exampleRows.isNotEmpty) {
        // Reduced to 6 columns
        final sql = 'INSERT INTO ${db.exampleStagingTable.actualTableName} (local_id, group_id, language_code, example_sentence, example_sentence_reading, example_sentence_tokenized) VALUES ${List.filled(exampleRows.length, placeholders(6)).join(', ')}';
        await db.customStatement(sql, exampleRows.expand((i) => i).toList());
      }
      if (tagRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.exampleTagStagingTable.actualTableName} (example_local_id, tag_name) VALUES ${List.filled(tagRows.length, placeholders(2)).join(', ')}';
        await db.customStatement(sql, tagRows.expand((i) => i).toList());
      }
      if (statRows.isNotEmpty) {
        // Expanded to 5 columns
        final sql = 'INSERT INTO ${db.exampleStatStagingTable.actualTableName} (example_local_id, stat_name, display_name, stat_value, display_value) VALUES ${List.filled(statRows.length, placeholders(5)).join(', ')}';
        await db.customStatement(sql, statRows.expand((i) => i).toList());
      }
      if (termRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.exampleTermStagingTable.actualTableName} (example_local_id, term) VALUES ${List.filled(termRows.length, placeholders(2)).join(', ')}';
        await db.customStatement(sql, termRows.expand((i) => i).toList());
      }
      if (audioRows.isNotEmpty) {
        // Reduced to 4 columns
        final sql = 'INSERT INTO ${db.exampleAudioStagingTable.actualTableName} (local_id, example_local_id, path, name) VALUES ${List.filled(audioRows.length, placeholders(4)).join(', ')}';
        await db.customStatement(sql, audioRows.expand((i) => i).toList());
      }
      if (audioTagRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.exampleAudioTagStagingTable.actualTableName} (audio_local_id, tag_name) VALUES ${List.filled(audioTagRows.length, placeholders(2)).join(', ')}';
        await db.customStatement(sql, audioTagRows.expand((i) => i).toList());
      }
      if (audioStatRows.isNotEmpty) {
        // New table mapping for audio stats
        final sql = 'INSERT INTO ${db.exampleAudioStatStagingTable.actualTableName} (audio_local_id, stat_name, display_name, stat_value, display_value) VALUES ${List.filled(audioStatRows.length, placeholders(5)).join(', ')}';
        await db.customStatement(sql, audioStatRows.expand((i) => i).toList());
      }
    });
  }
}