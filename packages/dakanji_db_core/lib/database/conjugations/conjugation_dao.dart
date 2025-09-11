// Package imports:
import "package:dakanji_db_core/database/conjugations/conjugation_tables.dart";

import "package:drift/drift.dart";

// Project imports:
import "../dakanji_db.dart";

part 'conjugation_dao.g.dart';



///
@DriftAccessor(
  tables: [
    ConjugationTable
  ],
)
class ConjugationDao extends DatabaseAccessor<DaKanjiDB> with _$ConjugationDaoMixin {


  ConjugationDao(super.db);

  
  // ---------------------------------------------------------------------------
  /// Get all conjugations
  Future<List<ConjugationTableData>> getAllConjugations() async {
    return await select(conjugationTable).get();
  }

  // ---------------------------------------------------------------------------
  /// Get the maximum conjugation id
  Future<int> maxConjugationsId() async {
    final query = await (selectOnly(conjugationTable)
        ..addColumns([conjugationTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(conjugationTable.id.max()) ?? 0;
  }

}
