import 'package:dakanji_db_core/parsing/staging_db/staging_db.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/parsers/yomitan_file_parser.dart';
import 'package:language_processing/language_processing.dart';


class TagBankParser implements YomitanFileParser {
  @override
  bool canHandle(String fileName) => fileName.contains("tag_bank");

  @override
  Future<int> parseFileContent(
    List<dynamic> jsonContent,
    StagingDatabase db,
    LanguageProcessor? lp,
    ProcessorOptions options,
    int startId,
  ) async {
    // Format: [tagName, category, order, notes, score]
    var rows = <List<Object?>>[];
    const int batchSize = 1000;

    for (final entry in jsonContent) {
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