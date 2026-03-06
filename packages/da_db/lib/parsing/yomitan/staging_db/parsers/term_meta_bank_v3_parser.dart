import 'dart:convert';
import 'dart:typed_data';

import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/db_file_parser.dart';
import 'package:da_db/parsing/util/parsing_constants.dart';
import 'package:da_db/parsing/util/staging_utils.dart';
import 'package:language_processing/language_processing.dart';



class TermMetaBankV3Parser implements DbFileParser {
  @override
  bool canHandle(String fileName) => fileName.startsWith(termMetaBankPrefix);

  @override
  Future<int> parseFileContent(
    List<Uint8List> inputBytes,
    StagingDatabase db,
    LanguageProcessor? lp,
    ProcessorOptions options,
    int startId,
  ) async {

    if (lp == null) throw Exception("LanguageProcessor is required for parsing term_meta_bank");

    List jsonInput = jsonDecode(utf8.decode(inputBytes[0]));
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

    for (final entry in jsonInput) {
      if (entry is! List) continue;

      localId++;
      
      final String term = entry[0];
      final String mode = entry[1];
      final dynamic data = entry[2];

      // --- Term processing ---
      String? termNormalized = lp.normalize(term, options).firstOrNull;
      if (termNormalized == term) termNormalized = null;

      String? termTokens = lp.parse(term, const ProcessorOptions()).segments.nonNulls.join(" ");
      String? termTokensNormalized;
      termTokensNormalized = lp.normalize(termTokens, options).firstOrNull;
      if (termTokensNormalized == termTokens) termTokensNormalized = null;

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

        if (pitches is List && reading != null) {
          for (var p in pitches) {
            pitchLocalId++;
            
            try {
              // Ensure this method name matches your LanguageProcessor interface!
              final String positionPattern = lp.parseYomitanPitch({
                'position': p['position'],
                'reading': reading,
              });

              // Handle nasal/devoice using the local normalizer
              List<int>? nasalList = normalizePositions(p['nasal']);
              List<int>? devoiceList = normalizePositions(p['devoice']);

              // Encode the arrays for the DB
              String? nasalStr = nasalList != null ? jsonEncode(nasalList) : null;
              String? devoiceStr = devoiceList != null ? jsonEncode(devoiceList) : null;

              pitchRows.add([pitchLocalId, localId, positionPattern, nasalStr, devoiceStr]);
              
            } catch (e) {
              // If the pitch is malformed, skip it and don't insert its tags
              continue; 
            }

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

  /// 2. Normalizes Yomitan's nasal/devoice fields into a consistent `List<int>`
  List<int>? normalizePositions(dynamic value) {
    if (value == null) return null;
    if (value is int) return [value];
    if (value is List) return value.cast<int>();
    return null;
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
    await db.transaction(() async {
      await insertChunked(db, db.termMetaStagingTable.actualTableName, 
          ['local_id', 'term', 'term_normalized', 'term_tokens', 'term_tokens_normalized', 'mode', 'reading', 'reading_normalized', 'freq_value', 'freq_display'], 
          metaRows);

      await insertChunked(db, db.termMetaPitchStagingTable.actualTableName, 
          ['pitch_local_id', 'meta_local_id', 'position', 'nasal', 'devoice'], 
          pitchRows);

      await insertChunked(db, db.termMetaIpaStagingTable.actualTableName, 
          ['ipa_local_id', 'meta_local_id', 'ipa'], 
          ipaRows);

      await insertChunked(db, db.termMetaTagStagingTable.actualTableName, 
          ['parent_local_id', 'parent_type', 'tag_name'], 
          tagRows);
    });
  }
}