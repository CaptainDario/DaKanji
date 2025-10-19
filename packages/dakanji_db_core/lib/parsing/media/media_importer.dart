import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;



Future<int> importMediaFile(
  String filePath, Uint8List mediaContent, int indexId, DaKanjiDB db, int? insertId
) async {

  String name = p.basename(filePath);
  String path = p.dirname(filePath);
  
  return await db.into(db.mediaTable).insert(MediaTableCompanion(
    id: insertId != null ? Value(insertId) : Value.absent(),
    indexId: Value(indexId),
    path: Value(path),
    name: Value(name),
    data: Value(mediaContent),
  ));

}
