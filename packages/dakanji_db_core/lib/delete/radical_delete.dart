import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:drift/drift.dart';



/// Deletes all entries in the radicals and radical- kanji relation tables
Future deleteRadicals(DaKanjiDB db) async {

  await db.radicalsTable.deleteAll();
  await db.radicalXKanjiRelationsTable.deleteAll();

}