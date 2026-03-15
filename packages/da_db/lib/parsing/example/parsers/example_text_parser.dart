import 'dart:convert';
import 'dart:typed_data';

import 'package:da_db/database/index/yomitan_index.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/db_file_parser.dart';
import 'package:da_db/parsing/util/parsing_constants.dart';
import 'package:da_db/parsing/util/staging_utils.dart';
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
    YomitanIndex index,
  ) async {
    if (lp == null) throw Exception("LanguageProcessor is required for parsing plain text examples.");

    // 1. Decode the main text file
    final rawText = utf8.decode(inputBytes[0]);
    Map<String, dynamic> fileMetadata = {};

    // 2. Decode the companion metadata file if the worker passed it
    if (inputBytes.length > 1) {
      try {
        fileMetadata = jsonDecode(utf8.decode(inputBytes[1]));
      }
      catch (e) {
        print("Warning: Failed to parse companion metadata JSON: $e");
      }
    }

    // Extract file-level metadata 
    final groupId = fileMetadata['groupId'];
    
    final tags = (fileMetadata['tags'] as List<dynamic>?)?.cast<String>() ?? [];
    final stats = (fileMetadata['stats'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];

    int exampleLocalId = startId;
    var exampleRows = <List<Object?>>[];
    var tagRows = <List<Object?>>[];
    var statRows = <List<Object?>>[];

    const int batchSize = 1000;

    // Extract sentences using the Language Processor
    final extractedSentences = lp.findSentences(rawText, const ProcessorOptions());

    // Iterate and parse using MeCab
    for (var textSegment in extractedSentences) {
      final sentence = textSegment.text.trim();
      if (sentence.isEmpty) continue;

      exampleLocalId++;

      // tokenize the sentence with the Language Processor to extract terms
      String? exampleTokenized = lp.parse(sentence, const ProcessorOptions()).tokens.join(" ");

      // Add 5 columns to the main table
      exampleRows.add([exampleLocalId, groupId, sentence, exampleTokenized]);

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

      if (exampleRows.length >= batchSize) {
        await _flush(db, exampleRows, tagRows, statRows);
        exampleRows.clear(); tagRows.clear(); statRows.clear();
      }
    }

    if (exampleRows.isNotEmpty) {
      await _flush(db, exampleRows, tagRows, statRows);
    }
    
    return exampleLocalId;
  }

  Future<void> _flush(
    StagingDatabase db, 
    List<List<Object?>> exampleRows,
    List<List<Object?>> tagRows,
    List<List<Object?>> statRows,
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
    });
  }
}