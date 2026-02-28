import 'dart:convert';
import 'dart:typed_data';

import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/db_file_parser.dart';
import 'package:da_db/parsing/util/parsing_constants.dart';
import 'package:language_processing/language_processing.dart';


class TagBankParser implements DbFileParser {
  @override
  bool canHandle(String fileName) => fileName.contains(tagBankPrefix);

  @override
  Future<int> parseFileContent(
    List<Uint8List> inputBytes,
    StagingDatabase db,
    LanguageProcessor? lp,
    ProcessorOptions options,
    int startId,
  ) async {

    List jsonInput = jsonDecode(utf8.decode(inputBytes[0]));
    
    // Format: [tagName, category, order, notes, score]
    var rows = <List<Object?>>[];
    const int batchSize = 1000;

    for (final entry in jsonInput) {
      if (entry is! List) continue;

      final name = entry[0] as String;
      final category = entry[1] as String;
      final order = entry[2] as int;
      final notes = entry[3] as String;
      final score = entry[4] as int;

      rows.add([name, category, order, notes, score]);

      if (rows.length >= batchSize) {
        await _flush(db, rows);
        rows.clear();
      }
    }

    if (rows.isNotEmpty) {
      await _flush(db, rows);
    }

    // return startId because tags don't affect the "Local ID" counter used by terms.
    return startId; 
  }

  Future<void> _flush(StagingDatabase db, List<List<Object?>> rows) async {
    final placeholders = rows.map((_) => '(?, ?, ?, ?, ?)').join(', ');
    
    final sql = 'INSERT INTO ${db.tagStagingTable.actualTableName} (tag_name, category, sorting_order, notes, score) VALUES $placeholders';
    
    await db.customStatement(sql, rows.expand((i) => i).toList());
  }
}