import 'package:dakanji_db_core/parsing/staging_db/staging_db.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/parsers/yomitan_file_parser.dart';
import 'package:language_processing/language_processing.dart';

class TermMetaBankV3Parser implements YomitanFileParser {
  @override
  bool canHandle(String fileName) => fileName.contains("term_meta_bank");

  @override
  Future<int> parseFileContent(
    List<dynamic> jsonContent,
    StagingDatabase db,
    LanguageProcessor? lp,
    ProcessorOptions options,
    bool saveJson,
    int startId,
  ) async {
    if (lp == null) throw Exception("LanguageProcessor is required for parsing term_meta_bank");

    int localId = startId;
    
    // Retrieve current max IDs for sub-tables to ensure uniqueness across batches
    int pitchLocalId = await _getMaxId(db, 'term_meta_pitch_staging_table', 'pitch_local_id');
    int ipaLocalId = await _getMaxId(db, 'term_meta_ipa_staging_table', 'ipa_local_id');

    // Buffers
    var metaRows = <List<Object?>>[];
    var pitchRows = <List<Object?>>[];
    var ipaRows = <List<Object?>>[];
    var tagRows = <List<Object?>>[];

    const int batchSize = 1000;

    for (final entry in jsonContent) {
      if (entry is! List) continue;

      localId++;
      
      final String term = entry[0];
      final String mode = entry[1];
      final dynamic data = entry[2];

      // --- NLP Processing (Term) ---
      String? termNormalized = lp.normalize(term, options).firstOrNull;
      if (termNormalized == term) termNormalized = null;

      String? termTokens = lp.segment(term);
      String? termTokensNormalized;
      if (termTokens != null) {
        termTokensNormalized = lp.normalize(termTokens, options).firstOrNull;
        if (termTokensNormalized == termTokens) termTokensNormalized = null;
      }

      String? reading;
      String? readingNormalized;
      int? freqValue;
      String? freqDisplayValue;

      // Extract Reading if present in Map data
      if (data is Map && data.containsKey('reading')) {
        reading = data['reading'];
        if (reading != null) {
          readingNormalized = lp.normalize(reading, options).firstOrNull;
          if (readingNormalized == reading) readingNormalized = null;
        }
      }

      // --- Mode Handling ---
      if (mode == 'freq') {
        if (data is int) {
          freqValue = data;
        } else if (data is String) {
          freqDisplayValue = data;
        } else if (data is Map) {
          // Handle complex freq objects
          if (data['frequency'] is int) freqValue = data['frequency'];
          if (data['frequency'] is String) freqDisplayValue = data['frequency'];
          if (data['value'] is int) freqValue = data['value'];
          if (data['displayValue'] is String) freqDisplayValue = data['displayValue'];
          
          // Handle nested frequency map
          final innerFreq = data['frequency'];
          if (innerFreq is Map) {
             if (innerFreq['value'] is int) freqValue = innerFreq['value'];
             if (innerFreq['displayValue'] is String) freqDisplayValue = innerFreq['displayValue'];
          }
        }
      } 
      else if (mode == 'pitch' && data is Map) {
        final pitches = data['pitches'];
        if (pitches is List) {
          for (var p in pitches) {
            pitchLocalId++;
            // Parse fields
            final position = p['position'] as int? ?? 0;
            // Handle nasal/devoice loosely (could be bool or int)
            int? nasal;
            if (p['nasal'] is int) nasal = p['nasal'];
            else if (p['nasal'] is bool) nasal = (p['nasal'] as bool) ? 1 : 0;
            
            int? devoice;
            if (p['devoice'] is int) devoice = p['devoice'];
            else if (p['devoice'] is bool) devoice = (p['devoice'] as bool) ? 1 : 0;

            pitchRows.add([pitchLocalId, localId, position, nasal, devoice]);

            // Pitch Tags
            if (p['tags'] is List) {
              for (var t in p['tags']) {
                tagRows.add([pitchLocalId, 'pitch', t]);
              }
            }
          }
        }
      }
      else if (mode == 'ipa' && data is Map) {
        final transcriptions = data['transcriptions'];
        if (transcriptions is List) {
          for (var tr in transcriptions) {
            ipaLocalId++;
            final ipaStr = tr['ipa'] as String? ?? "";
            
            ipaRows.add([ipaLocalId, localId, ipaStr]);

            // IPA Tags
            if (tr['tags'] is List) {
              for (var t in tr['tags']) {
                tagRows.add([ipaLocalId, 'ipa', t]);
              }
            }
          }
        }
      }

      // Add main meta row
      metaRows.add([
        localId, term, termNormalized, termTokens, termTokensNormalized,
        mode, reading, readingNormalized, freqValue, freqDisplayValue
      ]);

      if (metaRows.length >= batchSize) {
        await _flush(db, metaRows, pitchRows, ipaRows, tagRows);
        metaRows.clear(); pitchRows.clear(); ipaRows.clear(); tagRows.clear();
      }
    }

    if (metaRows.isNotEmpty) {
      await _flush(db, metaRows, pitchRows, ipaRows, tagRows);
    }

    return localId;
  }

  Future<int> _getMaxId(StagingDatabase db, String table, String col) async {
    final result = await db.customSelect('SELECT MAX($col) as m FROM $table').getSingleOrNull();
    return (result?.read<int?>('m') ?? 0);
  }

  Future<void> _flush(
    StagingDatabase db,
    List<List<Object?>> metaRows,
    List<List<Object?>> pitchRows,
    List<List<Object?>> ipaRows,
    List<List<Object?>> tagRows,
  ) async {
    String placeholders(int count) => '(${List.filled(count, '?').join(', ')})';

    await db.transaction(() async {
      if (metaRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.termMetaStagingTable.actualTableName} '
            '(local_id, term, term_normalized, term_tokens, term_tokens_normalized, mode, reading, reading_normalized, freq_value, freq_display) '
            'VALUES ${List.filled(metaRows.length, placeholders(10)).join(', ')}';
        await db.customStatement(sql, metaRows.expand((i) => i).toList());
      }
      if (pitchRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.termMetaPitchStagingTable.actualTableName} '
            '(pitch_local_id, meta_local_id, position, nasal, devoice) '
            'VALUES ${List.filled(pitchRows.length, placeholders(5)).join(', ')}';
        await db.customStatement(sql, pitchRows.expand((i) => i).toList());
      }
      if (ipaRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.termMetaIpaStagingTable.actualTableName} '
            '(ipa_local_id, meta_local_id, ipa) '
            'VALUES ${List.filled(ipaRows.length, placeholders(3)).join(', ')}';
        await db.customStatement(sql, ipaRows.expand((i) => i).toList());
      }
      if (tagRows.isNotEmpty) {
        final sql = 'INSERT INTO ${db.termMetaTagStagingTable.actualTableName} '
            '(parent_local_id, parent_type, tag_name) '
            'VALUES ${List.filled(tagRows.length, placeholders(3)).join(', ')}';
        await db.customStatement(sql, tagRows.expand((i) => i).toList());
      }
    });
  }
}