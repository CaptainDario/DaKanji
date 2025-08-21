// Package imports:
import "package:drift/drift.dart";

// Project imports:
import "package:dakanji_db/database/general_tables/definition_tables.dart";
import "../dakanji_db.dart";

part 'definition_dao.g.dart';



// Dao class that contains all queries related to the `KanjiTable`
@DriftAccessor(tables: [
  DefinitionTable
])
class DefinitionDao extends DatabaseAccessor<DaKanjiDB> with _$DefinitionDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  DefinitionDao(super.db);

  /// Get all kanjis and their ids 
  Future<List<DefinitionTableData>> getAllDefinitions() async {
    return await select(definitionTable).get();
  }

  /// Get the maximum id of the kanji table
  Future<int> maxDefinitionId() async {
    
    final query = await (selectOnly(definitionTable)
        ..addColumns([definitionTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(definitionTable.id.max()) ?? 0;

  }
  
}
