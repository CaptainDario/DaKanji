import "package:dakanji_db/database/radicals/radical_relation_tables.dart";
import "package:dakanji_db/database/radicals/radical_tables.dart";
import "package:drift/drift.dart";

import "../dakanji_db.dart";

part 'radical_dao.g.dart';



// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [
  RadicalsKanjiTable, RadicalsTable, RadicalKanjiRelationsTable
])
class RadicalDao extends DatabaseAccessor<DaKanjiDB> with _$RadicalDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  RadicalDao(super.db);


  /// Gets all radicals that are associated with the given kanji
  Future<List<String>> getKanjiRadicals(String kanji) async {
    // Query the database
    final query = db.select(db.radicalsTable)
      .join([
        innerJoin(
          db.radicalKanjiRelationsTable,
          db.radicalKanjiRelationsTable.radicalId.equalsExp(db.radicalsTable.id),
        ),
        innerJoin(
          db.radicalsKanjiTable,
          db.radicalKanjiRelationsTable.kanjiId.equalsExp(db.radicalsKanjiTable.id),
        ),
      ])
      ..where(db.radicalsKanjiTable.radicalKanji.equals(kanji));

    // Map the results to get only the radical characters
    final result = await query.map((row) {
      final radical = row.readTable(db.radicalsTable);
      return radical.radical;
    }).get();

    return result;
  }
  
}