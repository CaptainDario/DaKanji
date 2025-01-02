// Package imports:
import "package:dakanji_db/database/example/example_tables.dart";
import "package:drift/drift.dart";

// Project imports:
import "../dakanji_db.dart";

part 'example_dao.g.dart';



// Dao class that contains all queries related to the `ExampleTable`
@DriftAccessor(tables: [
  ExampleTable, ExampleTranslationTable
])
class ExampleDao extends DatabaseAccessor<DaKanjiDB> with _$ExampleDaoMixin {
  
  ExampleDao(super.db);

  // ---------------------------------------------------------------------------
  /// Get the maximum id of the [ExampleTable]
  Future<int> maxExampleId() async {
    
    final query = await (selectOnly(exampleTable)
        ..addColumns([exampleTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(exampleTable.id.max()) ?? 0;

  }

  /// Get the maximum id of the [ExampleTranslationTable]
  Future<int> maxExampleTranslationId() async {
    
    final query = await (selectOnly(exampleTranslationTable)
        ..addColumns([exampleTranslationTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(exampleTranslationTable.id.max()) ?? 0;

  }

}
