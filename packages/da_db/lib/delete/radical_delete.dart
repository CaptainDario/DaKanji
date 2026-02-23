import 'package:da_db/database/da_db.dart';
import 'package:drift/drift.dart';



/// Deletes all entries in the radicals and radical- kanji relation tables
Future deleteRadicals(DaDb db) async {

  await db.transaction(() async {

    await db.radicalsTable.deleteAll();
    await db.radicalXKanjiRelationsTable.deleteAll();

  });

}