// Package imports:
import "package:drift/drift.dart";

// Project imports:
import "/database/radicals/radical_relation_tables.dart";
import "/database/radicals/radical_tables.dart";
import "../dakanji_db.dart";

part 'radical_dao.g.dart';



@DriftAccessor(tables: [
  RadicalsTable, Radical_X_KanjiRelationsTable
])
class RadicalDao extends DatabaseAccessor<DaKanjiDB> with _$RadicalDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  RadicalDao(super.db);


  /// Gets all radicals that are associated with the given kanji
  Future<List<String>> getKanjiRadicals(String kanji) async {

    // Query the database
    final query = db.select(kanjiTable)
      .join([
        innerJoin(
          radicalXKanjiRelationsTable,
          radicalXKanjiRelationsTable.kanjiId.equalsExp(kanjiTable.id)
        ),
        innerJoin(
          radicalsTable,
          radicalXKanjiRelationsTable.radicalId.equalsExp(radicalsTable.id)
        ),
      ])
      ..where(db.kanjiTable.kanji.equals(kanji));

    // Map the results to get only the radical characters
    final result = await query.map((row) {
      final radical = row.readTable(db.radicalsTable);
      return radical.radical;
    }).get();

    return result;

  }

  /// Gets all kanjis that use *all* of the given radicals
  Future<List<String>> getKanjisThatUseRadicals(List<String> radicals) async {
    
    if (radicals.isEmpty) { return []; }

    // Get the kanji characters that use all the specified radicals
    final kanjiQuery = selectOnly(kanjiTable).join(
      [
        innerJoin(
          radicalXKanjiRelationsTable,
          radicalXKanjiRelationsTable.kanjiId.equalsExp(kanjiTable.id)
        ),
        innerJoin(
          radicalsTable,
          radicalXKanjiRelationsTable.radicalId.equalsExp(radicalsTable.id)
        ),
      ],
    )
    ..addColumns([
      kanjiTable.kanji, radicalsTable.radical, radicalsTable.strokeCount
    ])
    ..groupBy(
      [kanjiTable.kanji],
      having: countAll().equals(radicals.length)
    )
    ..where(
      radicalsTable.radical.isIn(radicals)
    );

    final results = (await kanjiQuery.get())
      .map((e) => e.read(kanjiTable.kanji)!,)
      .toList();

    return results;

  }

  
}
