import 'package:da_db/parsing/staging_db/staging_db.dart';


const int sqliteVariableLimit = 990; // Buffer below 999

/// Inserts large amounts of data by automatically chunking them to stay 
/// within SQLite's variable limits.
Future<void> insertChunked(
  StagingDatabase db,
  String tableName,
  List<String> columns,
  List<List<Object?>> rows,
) async {
  if (rows.isEmpty) return;

  final columnCount = columns.length;
  // Calculate how many rows can fit in one statement based on column count
  final maxRowsPerChunk = (sqliteVariableLimit / columnCount).floor();

  for (int i = 0; i < rows.length; i += maxRowsPerChunk) {
    final end = (i + maxRowsPerChunk > rows.length) ? rows.length : i + maxRowsPerChunk;
    final chunk = rows.sublist(i, end);
    
    final placeholders = List.filled(chunk.length, 
      '(${List.filled(columnCount, '?').join(', ')})'
    ).join(', ');
    
    final sql = 'INSERT INTO $tableName (${columns.join(', ')}) VALUES $placeholders';
    
    // Flatten the list of lists into a single list of arguments
    await db.customStatement(sql, chunk.expand((row) => row).toList());
  }
}
