// Package imports:
import "package:dakanji_db/database/general_tables/term_tables.dart";
import "package:dakanji_db/database/term/term_bank_v3_tables.dart";
import "package:drift/drift.dart";

// Project imports:
import "../dakanji_db.dart";

part 'term_bank_v3_dao.g.dart';



///
@DriftAccessor(tables: [
  TermTable,
  TermBankV3Table
])
class TermBankV3Dao extends DatabaseAccessor<DaKanjiDB> with _$TermBankV3DaoMixin {
  
  
  TermBankV3Dao(super.db);
  
}
