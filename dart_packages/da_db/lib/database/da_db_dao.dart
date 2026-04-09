import 'package:da_db/database/da_db.dart';
import "package:drift/drift.dart";

part 'da_db_dao.g.dart';

// Dao class that contains all queries related to the `KanjiTable`
@DriftAccessor()
class DaDbDao extends DatabaseAccessor<DaDb> with _$DaDbDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  DaDbDao(super.db);


  
}
