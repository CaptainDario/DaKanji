import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:drift/drift.dart';




/// Deletes all entries in the kanji vg table
Future<int> deleteKanjiVG(DaKanjiDB db) async {

    return await db.kanjiVGTable.deleteAll();

}