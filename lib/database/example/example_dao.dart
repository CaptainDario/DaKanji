// Package imports:
import "package:dakanji_db/database/example/example_tables.dart";
import "package:drift/drift.dart";

// Project imports:
import "../dakanji_db.dart";

part 'example_dao.g.dart';



// Dao class that contains all queries related to the `ExampleTable`
@DriftAccessor(tables: [
  ExampleTable
])
class ExampleDao extends DatabaseAccessor<DaKanjiDB> with _$ExampleDaoMixin {
  
  ExampleDao(super.db);

}
