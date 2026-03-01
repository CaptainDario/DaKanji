import 'dart:convert';
import 'dart:typed_data';

import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/db_file_parser.dart';
import 'package:da_db/parsing/util/parsing_constants.dart';
import 'package:language_processing/language_processing.dart';

class ExampleTextParser implements DbFileParser {
  
  @override
  bool canHandle(String fileName) => fileName.startsWith(exampleTextBankPrefix);

  @override
  Future<int> parseFileContent(
    List<Uint8List> inputBytes,
    StagingDatabase db,
    LanguageProcessor? lp,
    ProcessorOptions options,
    int startId,
  ) async {
    if (lp == null) throw Exception("LanguageProcessor is required for parsing plain text examples.");

    // 1. Decode the main text file
    final rawText = utf8.decode(inputBytes[0]);
    Map<String, dynamic> fileMetadata = {};

    // 2. Decode the companion metadata file if the worker passed it
    if (inputBytes.length > 1) {
      try {
        fileMetadata = jsonDecode(utf8.decode(inputBytes[1]));
      } catch (e) {
        print("Warning: Failed to parse companion metadata JSON: $e");
      }
    }

    // Extract file-level metadata 
    final langIsoCode = fileMetadata['langIso3Code'] as String? ?? 'jpn';
    final groupId = fileMetadata['groupId'] as int? ?? 0;
    
    final tags = (fileMetadata['tags'] as List<dynamic>?)?.cast<String>() ?? [];
    final stats = (fileMetadata['stats'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];

    int exampleLocalId = startId;
    var exampleRows = <List<Object?>>[];
    var tagRows = <List<Object?>>[];
    var statRows = <List<Object?>>[];
    var termRows = <List<Object?>>[];

    const int batchSize = 1000;

    // --- STEP 1: Extract sentences using the Language Processor ---
    final extractedSentences = lp.findSentences(rawText, const ProcessorOptions());

    // --- STEP 2: Iterate and parse using MeCab ---
    for (var sentence in extractedSentences) {
      sentence = sentence.trim();
      if (sentence.isEmpty) continue;

      exampleLocalId++;

      // 1. ONE PASS NLP PROCESSING
      final parseResult = lp.parse(sentence, ProcessorOptions());

      // 2. Build the Surface Form string for FTS5 exact matching
      final segmentString = parseResult.segments
          .where((s) => s != null && s.trim().isNotEmpty)
          .join(' ');
      
      final finalSegments = segmentString.isEmpty ? sentence : segmentString;

      // Add 5 columns to the main table
      exampleRows.add([exampleLocalId, groupId, langIsoCode, sentence, finalSegments]);

      for (final t in tags) {
        if (t.trim().isEmpty) continue;
        tagRows.add([exampleLocalId, t.trim()]);
      }

      for (final s in stats) {
        statRows.add([
          exampleLocalId, 
          s['statName'] as String, 
          s['displayName'] as String?,
          s['value'] != null ? (s['value'] as num).toDouble() : null, 
          s['displayValue'] as String?
        ]);
      }

      // 3. Extract dictionary terms from parseResult.tokens
      final termSet = parseResult.tokens
          .where((t) => t != null && t.trim().isNotEmpty)
          .toSet();
          
      for (final term in termSet) {
        termRows.add([exampleLocalId, term]);
      }

      if (exampleRows.length >= batchSize) {
        await _flush(db, exampleRows, tagRows, statRows, termRows);
        exampleRows.clear(); tagRows.clear(); statRows.clear(); termRows.clear();
      }
    }

    if (exampleRows.isNotEmpty) {
      await _flush(db, exampleRows, tagRows, statRows, termRows);
    }
    
    return exampleLocalId;
  }

  Future<void> _flush(
    StagingDatabase db, 
    List<List<Object?>> exampleRows,
    List<List<Object?>> tagRows,
    List<List<Object?>> statRows,
    List<List<Object?>> termRows,
  ) async {
    String placeholders(int count) => '(${List.filled(count, '?').join(', ')})';

    await db.transaction(() async {
      if (exampleRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.exampleStagingTable.actualTableName} (local_id, group_id, language_code, example_sentence, example_sentence_tokenized) VALUES ${List.filled(exampleRows.length, placeholders(5)).join(', ')}';
        await db.customStatement(sql, exampleRows.expand((i) => i).toList());
      }
      if (tagRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.exampleTagStagingTable.actualTableName} (example_local_id, tag_name) VALUES ${List.filled(tagRows.length, placeholders(2)).join(', ')}';
        await db.customStatement(sql, tagRows.expand((i) => i).toList());
      }
      if (statRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.exampleStatStagingTable.actualTableName} (example_local_id, stat_name, display_name, stat_value, display_value) VALUES ${List.filled(statRows.length, placeholders(5)).join(', ')}';
        await db.customStatement(sql, statRows.expand((i) => i).toList());
      }
      if (termRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.exampleTermStagingTable.actualTableName} (example_local_id, term) VALUES ${List.filled(termRows.length, placeholders(2)).join(', ')}';
        await db.customStatement(sql, termRows.expand((i) => i).toList());
      }
    });
  }
}