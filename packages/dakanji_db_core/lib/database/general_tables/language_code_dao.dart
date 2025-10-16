
import "package:drift/drift.dart";

import "/database/general_tables/language_code_table.dart";
import "../dakanji_db.dart";

part 'language_code_dao.g.dart';



// Dao class that contains all queries related to the `KanjiTable`
@DriftAccessor(tables: [
  LanguageCodeTable
])
class LanguageCodeDao extends DatabaseAccessor<DaKanjiDB> with _$LanguageCodeDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  LanguageCodeDao(super.db);

  /// Get all language codes and their ids 
  Future<List<LanguageCodeTableData>> getAllLanguageCodes() async {
    return await select(languageCodeTable).get();
  }

  /// Get the maximum id of the [LanguageCodeTable]
  Future<int> maxExampleTranslationId() async {
    
    final query = await (selectOnly(languageCodeTable)
        ..addColumns([languageCodeTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(languageCodeTable.id.max()) ?? 0;

  }
  
}
