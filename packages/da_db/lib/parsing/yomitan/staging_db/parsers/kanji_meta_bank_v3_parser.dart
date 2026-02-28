import 'dart:convert';

import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/db_file_parser.dart';
import 'package:da_db/parsing/util/parsing_constants.dart';
import 'package:drift/drift.dart';
import 'package:language_processing/language_processing.dart';



class KanjiMetaBankV3Parser implements DbFileParser {
  @override
  bool canHandle(String fileName) => fileName.startsWith(kanjiMetaBankPrefix);

  @override
  Future<int> parseFileContent(
    List<Uint8List> inputBytes,
    StagingDatabase db,
    LanguageProcessor? lp,
    ProcessorOptions options,
    int startId,
  ) async {
    
    List jsonInput = jsonDecode(utf8.decode(inputBytes[0]));
    int localId = startId;
    var rows = <List<Object?>>[];
    const int batchSize = 1000;

    for (final entry in jsonInput) {
      if (entry is! List) continue;

      localId++;
      
      final String kanji = entry[0];
      final String type = entry[1];
      final dynamic data = entry[2];

      int? freqValue;
      String? freqDisplayValue;

      // Parse payload (int, string, or map)
      if (data is int) {
        freqValue = data;
      } else if (data is String) {
        freqDisplayValue = data;
      } else if (data is Map) {
        if (data['value'] is int) freqValue = data['value'];
        if (data['displayValue'] is String) freqDisplayValue = data['displayValue'];
      }

      rows.add([localId, kanji, type, freqValue, freqDisplayValue]);

      if (rows.length >= batchSize) {
        await _flush(db, rows);
        rows.clear();
      }
    }

    if (rows.isNotEmpty) {
      await _flush(db, rows);
    }

    return localId;
  }

  Future<void> _flush(StagingDatabase db, List<List<Object?>> rows) async {
    final sql = 'INSERT INTO ${db.kanjiMetaStagingTable.actualTableName} '
        '(local_id, kanji, type, freq_value, freq_display_value) '
        'VALUES ${List.filled(rows.length, '(?, ?, ?, ?, ?)').join(', ')}';
    await db.customStatement(sql, rows.expand((i) => i).toList());
  }
}