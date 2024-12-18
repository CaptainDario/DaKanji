import "package:dakanji_db/database/kanji_vg/kanji_vg_tables.dart";
import "package:drift/drift.dart";

import "../dakanji_db.dart";

part 'kanji_vg_dao.g.dart';



// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [
  KanjiVGTable
])
class KanjiVGDao extends DatabaseAccessor<DaKanjiDB> with _$KanjiVGDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  KanjiVGDao(super.db);


  /// Gets the KanjiVG of the given kanji
  Future<String?> getKanjiVG(String kanji) async {

    // TODO update this function
    /*final result = await db.managers.kanjiVGTable
      .filter((f) => f.kanjiVGKanji(kanji))
      .getSingleOrNull();

    return result?.kanjiVGSVG;*/

  }
  
}