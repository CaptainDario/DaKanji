import 'dart:convert';

import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/term/definition_parser.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/parsers/yomitan_file_parser.dart';
import 'package:dakanji_db_core/staging_database/staging_db.dart';
import 'package:language_processing/language_processor.dart';
import 'package:language_processing/language_processor_options.dart';


class TermBankV3Parser implements YomitanFileParser {
  @override
  bool canHandle(String fileName) => fileName.contains("term_bank");

  @override
  Future<int> parseFileContent(
    List<dynamic> jsonContent,
    StagingDatabase db,
    LanguageProcessor? lp,
    ProcessorOptions options,
    bool saveJson,
    int startId,
  ) async {
    
    int localId = startId;
    var termRows = <List<Object?>>[];
    var defRows = <List<Object?>>[];
    var tagRows = <List<Object?>>[];
    var ruleRows = <List<Object?>>[];
    
    const int batchSize = 1000;

    for (final entry in jsonContent) {
      if (entry is! List) continue;

      localId++; 

      final term = entry[0] as String;
      final reading = entry[1] as String;
      final defTags = entry[2] as String; 
      final ruleIds = entry[3] as String; 
      final popularity = entry[4] as int;
      final definitionBlock = entry[5] as List;
      final sequence = entry[6] as int;
      final termTags = entry[7] as String; 

      String? termNormalized;
      String? termTokens;
      String? termTokensNormalized;
      String? readingNormalized;

      if (lp != null) {
        termNormalized = lp.normalize(term, options).firstOrNull;
        if (termNormalized == term) termNormalized = null;
        
        termTokens = lp.segment(term);
        if (termTokens != null) {
          termTokensNormalized = lp.normalize(termTokens, options).firstOrNull;
          if (termTokensNormalized == termTokens) termTokensNormalized = null;
        }
        
        readingNormalized = lp.normalize(reading, options).firstOrNull;
        if (readingNormalized == reading) readingNormalized = null;
      }

      termRows.add([
        localId, term, reading, termNormalized, termTokens, 
        termTokensNormalized, readingNormalized, popularity, sequence,
        saveJson ? jsonEncode(definitionBlock) : null
      ]);

      final parsedDefs = YomitanDefinitionParser.parse(definitionBlock);
      for (final def in parsedDefs.definitions) {
         final text = def.replaceAll(RegExp(r'[\s\u00A0]+'), ' ').trim();
         defRows.add([localId, text]);
      }

      if (defTags.isNotEmpty) {
        for (var t in defTags.split(' ')) {
          tagRows.add([localId, t, 1]); 
        }
      }
      
      if (termTags.isNotEmpty) {
        for (var t in termTags.split(' ')) {
          tagRows.add([localId, t, 0]); 
        }
      }

      if (ruleIds.isNotEmpty) {
         for (var r in ruleIds.split(' ')) {
           ruleRows.add([localId, r]);
         }
      }

      if (termRows.length >= batchSize) {
        await _flushToDb(db, termRows, defRows, tagRows, ruleRows);
        termRows.clear(); defRows.clear(); tagRows.clear(); ruleRows.clear();
      }
    }

    if (termRows.isNotEmpty) {
      await _flushToDb(db, termRows, defRows, tagRows, ruleRows);
    }
    
    return localId;
  }

  Future<void> _flushToDb(
    StagingDatabase db, 
    List<List<Object?>> termRows,
    List<List<Object?>> defRows,
    List<List<Object?>> tagRows,
    List<List<Object?>> ruleRows
  ) async {
    String placeholders(int count) => '(${List.filled(count, '?').join(', ')})';
  
    await db.transaction(() async {
      if (termRows.isNotEmpty) {
        final sql = 'INSERT INTO staging_term_table (local_id, term, reading, term_normalized, term_tokens, term_tokens_normalized, reading_normalized, popularity, sequence_number, original_json) VALUES ${List.filled(termRows.length, placeholders(10)).join(', ')}';
        await db.customStatement(sql, termRows.expand((i) => i).toList());
      }
      if (defRows.isNotEmpty) {
        final sql = 'INSERT INTO staging_definition_table (term_local_id, definition) VALUES ${List.filled(defRows.length, placeholders(2)).join(', ')}';
        await db.customStatement(sql, defRows.expand((i) => i).toList());
      }
      if (tagRows.isNotEmpty) {
        final sql = 'INSERT INTO staging_tag_table (term_local_id, tag_name, is_definition_tag) VALUES ${List.filled(tagRows.length, placeholders(3)).join(', ')}';
        await db.customStatement(sql, tagRows.expand((i) => i).toList());
      }
      if (ruleRows.isNotEmpty) {
        final sql = 'INSERT INTO staging_rule_table (term_local_id, rule_id) VALUES ${List.filled(ruleRows.length, placeholders(2)).join(', ')}';
        await db.customStatement(sql, ruleRows.expand((i) => i).toList());
      }
    });
  }
}