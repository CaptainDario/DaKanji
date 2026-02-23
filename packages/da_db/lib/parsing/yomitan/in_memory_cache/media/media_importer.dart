import 'package:da_db/database/da_db.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:unorm_dart/unorm_dart.dart' as unorm;



Future importMediaFiles(
  DaDb db,
  List<({String filePath, Uint8List mediaContent, int indexId, int? insertId})> files
) async {

  List<MediaTableCompanion> companions = [];

  for (var file in files) {
    // get raw paths
    String name = p.basename(file.filePath);
    String path = p.dirname(file.filePath);
    
    // Normalize path and name to NFC
    String cleanName = unorm.nfc(name); 
    String cleanPath = unorm.nfc(path);

    companions.add(MediaTableCompanion(
      id: file.insertId != null ? Value(file.insertId!) : Value.absent(),
      indexId: Value(file.indexId),
      path: Value(cleanPath),
      name: Value(cleanName),
      data: Value(file.mediaContent),
    ));
  }

  // bulk insert all media files
  return await db.batch((batch) {
    batch.insertAll(db.mediaTable, companions);
  },);

}
