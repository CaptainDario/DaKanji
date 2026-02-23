import 'package:da_db/database/da_db.dart';
import 'package:drift/drift.dart';




/// Deletes all entries in the kanji vg table
Future<int> deleteKanjiVG(DaDb db) async {

  return await db.kanjiVGTable.deleteAll();

}