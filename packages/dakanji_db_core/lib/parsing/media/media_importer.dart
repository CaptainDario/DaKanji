import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:drift/drift.dart';



Future importMediaFile(String path, Uint8List mediaContent, DaKanjiDB db) async {
  
  await db.into(db.mediaTable).insert(MediaTableCompanion(
    path: Value(path),
    data: Value(mediaContent.toList()),
  ));
  
}