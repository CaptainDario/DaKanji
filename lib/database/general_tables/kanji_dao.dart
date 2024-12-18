import "package:dakanji_db/database/general_tables/kanji_tables.dart";
import "package:drift/drift.dart";

import "../dakanji_db.dart";

part 'kanji_dao.g.dart';



// Dao class that contains all queries related to the `KanjiTable`
@DriftAccessor(tables: [
  KanjiTable
])
class KanjiDao extends DatabaseAccessor<DaKanjiDB> with _$kanjiDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  KanjiDao(super.db);


  
}