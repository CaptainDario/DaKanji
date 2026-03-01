import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/db_file_parser.dart';
import 'package:da_db/parsing/util/parsing_constants.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/term/definition_parser.dart';
import 'package:da_db/util/data_converters/zlib_text_converter_io.dart';
import 'package:language_processing/language_processing.dart';


class TermBankV3Parser implements DbFileParser {
  @override
  bool canHandle(String fileName) => fileName.contains(termBankPrefix);

  @override
  Future<int> parseFileContent(
    List<Uint8List> inputBytes,
    StagingDatabase db,
    LanguageProcessor? lp,
    ProcessorOptions options,
    int startId,
  ) async {
    if (lp == null) throw Exception("LanguageProcessor is required for parsing term_bank");

    List jsonInput = jsonDecode(utf8.decode(inputBytes[0]));
    int localId = startId;
    
    var termRows = <List<Object?>>[];
    var defRows = <List<Object?>>[];
    var tagRows = <List<Object?>>[];
    var ruleRows = <List<Object?>>[];
    
    const int batchSize = 1000;
    const ZlibStringConverter zlib = ZlibStringConverter();

    for (final entry in jsonInput) {
      if (entry is! List) continue;

      localId++; 

      final term = entry[0] as String;
      final reading = entry[1] as String;
      final defTags = entry[2] as String; 
      final ruleIds = entry[3] as String; 
      final popularity = entry[4] as int;
      final definitionBlock = entry[5]; 
      final sequence = entry[6] as int;
      final termTags = entry[7] as String; 

      // --- 1. NLP Processing ---
      String? termNormalized = lp.normalize(term, options).firstOrNull;
      if (termNormalized == term) termNormalized = null;
      
      String? termTokens = lp.parse(term, const ProcessorOptions()).segments.nonNulls.join(" ");
      String? termTokensNormalized;
      termTokensNormalized = lp.normalize(termTokens, options).firstOrNull;
      if (termTokensNormalized == termTokens) termTokensNormalized = null;
      
      String? readingNormalized = lp.normalize(reading, options).firstOrNull;
      if (readingNormalized == reading) readingNormalized = null;

      // --- 2. Compress & Hash the json definitions ---
      final jsonString = jsonEncode(definitionBlock);
      final jsonHash = md5.convert(utf8.encode(jsonString)).toString();
      final compressedBytes = zlib.toSql(jsonString);

      termRows.add([
        localId, term, reading, termNormalized, termTokens, 
        termTokensNormalized, readingNormalized, popularity,
        sequence, compressedBytes, jsonHash
      ]);

      // --- 3. Definitions ---
      final parsedDefinitions = YomitanDefinitionParser.parse(definitionBlock);
      
      // Initialize rank counter
      int defRank = 0; 
      for (String parsedDefinition in parsedDefinitions.definitions) {
        String text = parsedDefinition.replaceAll(RegExp(r'[\s\u00A0]+'), ' ').trim();
        defRows.add([localId, text, defRank]); 
        defRank++; 
      }

      // --- 4. Tags ---
      for (var t in defTags.split(' ')) {
        if (t.isEmpty) continue;
        tagRows.add([localId, t, 1]);
      }
      for (var t in termTags.split(' ')) {
        if (t.isEmpty) continue;
        tagRows.add([localId, t, 0]);
      }

      // --- 5. Rules ---
      for (var r in ruleIds.split(' ')) {
        if (r.isEmpty) continue;
        ruleRows.add([localId, r]);
      }

      if (termRows.length >= batchSize) {
        await _flush(db, termRows, defRows, tagRows, ruleRows);
        termRows.clear(); defRows.clear(); tagRows.clear(); ruleRows.clear();
      }
    }

    if (termRows.isNotEmpty) {
      await _flush(db, termRows, defRows, tagRows, ruleRows);
    }
    
    return localId;
  }

  Future<void> _flush(
    StagingDatabase db, 
    List<List<Object?>> termRows,
    List<List<Object?>> defRows,
    List<List<Object?>> tagRows,
    List<List<Object?>> ruleRows,
  ) async {
    String placeholders(int count) => '(${List.filled(count, '?').join(', ')})';

    await db.transaction(() async {
      if (termRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.termStagingTable.actualTableName} (local_id, term, reading, term_normalized, term_tokens, term_tokens_normalized, reading_normalized, popularity, sequence_number, original_json, definition_json_hash) VALUES ${List.filled(termRows.length, placeholders(11)).join(', ')}';
        await db.customStatement(sql, termRows.expand((i) => i).toList());
      }

      if (defRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.termDefinitionStagingTable.actualTableName} (term_local_id, definition, rank) VALUES ${List.filled(defRows.length, placeholders(3)).join(', ')}';
        await db.customStatement(sql, defRows.expand((i) => i).toList());
      }

      if (tagRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.termTagStagingTable.actualTableName} (term_local_id, tag_name, is_definition_tag) VALUES ${List.filled(tagRows.length, placeholders(3)).join(', ')}';
        await db.customStatement(sql, tagRows.expand((i) => i).toList());
      }

      if (ruleRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.termRuleStagingTable.actualTableName} (term_local_id, rule_id) VALUES ${List.filled(ruleRows.length, placeholders(2)).join(', ')}';
        await db.customStatement(sql, ruleRows.expand((i) => i).toList());
      }
    });
  }
}