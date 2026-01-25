import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:unorm_dart/unorm_dart.dart' as unorm;



Future<int> importMediaFile(
  String filePath, Uint8List mediaContent, int indexId, DaKanjiDB db, int? insertId
) async {

  // get raw paths
  String name = p.basename(filePath);
  String path = p.dirname(filePath);
  
  // Normalize path and name to NFC
  String cleanName = unorm.nfc(name); 
  String cleanPath = unorm.nfc(path);

  return await db.into(db.mediaTable).insert(MediaTableCompanion(
    id: insertId != null ? Value(insertId) : Value.absent(),
    indexId: Value(indexId),
    path: Value(cleanPath),
    name: Value(cleanName),
    data: Value(mediaContent),
  ));

}
