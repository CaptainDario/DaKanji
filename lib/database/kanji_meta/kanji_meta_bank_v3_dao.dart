import "package:drift/drift.dart";

import "../dakanji_db.dart";
import "package:dakanji_db/database/kanji_meta/kanji_meta_bank_v3_tables.dart";

part 'kanji_meta_bank_v3_dao.g.dart';



// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [
    KanjiMetaBankV3Table,
])
class KanjiMetaBankV3Dao extends DatabaseAccessor<DaKanjiDB> with _$KanjiMetaBankV3DaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  KanjiMetaBankV3Dao(super.db);
  


}