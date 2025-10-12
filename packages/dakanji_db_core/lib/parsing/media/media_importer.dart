import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:drift/drift.dart';



Future<int> importMediaFile(String path, Uint8List mediaContent, int indexId, DaKanjiDB db) async {
  
  return await db.customInsert(
    'INSERT INTO media_table_view (path, data, index_id) VALUES (?, ?, ?)',
    variables: [
      Variable.withString(path),
      Variable.withBlob(mediaContent),
      Variable.withInt(indexId),
    ],
  );
  
}