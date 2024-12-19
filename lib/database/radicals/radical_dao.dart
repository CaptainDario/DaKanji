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
    // TODO update function
    return [];
    /*
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
    */
  }

  /// Gets all kanjis that ues the given radicals
  Future<List<String>> getKanjisThatUseRadicals(List<String> radicals) async {

    // TODO update function
    /*
    // First, get the radical IDs for the provided radical characters
    final radicalQuery = select(radicalsTable)
      ..where((tbl) => tbl.radical.isIn(radicals));
    final radicalIds = await radicalQuery.map((row) => row.id).get();

    // If no matching radicals found, return empty list
    if (radicalIds.isEmpty) {
      return [];
    }

    // Create a subquery to count how many of the requested radicals each kanji uses
    final relationSubquery = selectOnly(radicalKanjiRelationsTable)
      ..addColumns([radicalKanjiRelationsTable.kanjiId])
      ..where(radicalKanjiRelationsTable.radicalId.isIn(radicalIds))
      ..groupBy(
        [radicalKanjiRelationsTable.kanjiId,],
        having: countAll().equals(radicalIds.length)
      );

    // Get the kanji characters that use all the specified radicals
    final kanjiQuery = select(radicalsKanjiTable)
      ..where((tbl) => tbl.id.isInQuery(relationSubquery));

    final results = await kanjiQuery.map((row) => row.radicalKanji).get();
    return results;
    */

    return [];

  }
  
}