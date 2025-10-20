
import "package:drift/drift.dart";

import "/database/general_tables/reading_tables.dart";
import "/database/general_tables/term_tables.dart";
import "/database/term_meta/term_meta_bank_entry.dart";
import "/database/term_meta/term_meta_bank_relation_tables.dart";
import "/database/term_meta/term_meta_bank_v3_tables.dart";
import "../dakanji_db.dart";

part 'term_meta_bank_v3_dao.g.dart';



// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [
    TermTable, ReadingTable,
    TermMetaBankV3Table,
    TermMetaBankV3PitchTable, TermMetaBankV3_X_PitchTagTable, TermMetaBankV3_X_PitchTable,
    TermMetaBankV3IpaTable, TermMetaBankV3_X_IpaTagTable, TermMetaBankV3_X_IpaTable,
    TermMetaBankV3TagTable
])
class TermMetaBankV3Dao extends DatabaseAccessor<DaKanjiDB> with _$TermMetaBankV3DaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  TermMetaBankV3Dao(super.db);
  

  /// Returns all term entries that match contain any of the given terms
  Future<List<TermMetaBankV3Entry>> searchTermMetaBankV3Entries(String term) async {

    List<TermMetaBankV3EntryViewData> results =
      await db.term_meta_bank_v3_entry_search_drift(term).get();

    return results.map((e) => TermMetaBankV3Entry.fromTermMetaBankV3EntryViewData(e)).toList();

  }



  // ---------------------------------------------------------------------------
  /// Get all types and their ids 
  Future<List<TermMetaBankV3TypeTableData>> getAllTypes() async {
    return await select(termMetaBankV3TypeTable).get();
  }

  /// Get all pitchs and their ids 
  Future<List<TermMetaBankV3PitchTableData>> getAllPitchs() async {
    return await select(termMetaBankV3PitchTable).get();
  }

  /// Get all ipa transcriptions and their ids 
  Future<List<TermMetaBankV3IpaTableData>> getAllIpas() async {
    return await select(termMetaBankV3IpaTable).get();
  }

  /// Get all tags and their ids 
  Future<List<TermMetaBankV3TagTableData>> getAllTags() async {
    return await select(termMetaBankV3TagTable).get();
  }

  // ---------------------------------------------------------------------------
  /// Get the maximum term meta bank v3 id 
  Future<int> maxTermMetaBankV3Id() async {
    
    final query = await (selectOnly(termMetaBankV3Table)
        ..addColumns([termMetaBankV3Table.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termMetaBankV3Table.id.max()) ?? 0;

  }

  /// Get the maximum type id 
  Future<int> maxTermMetaBankV3TypeId() async {
    
    final query = await (selectOnly(termMetaBankV3TypeTable)
        ..addColumns([termMetaBankV3TypeTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termMetaBankV3TypeTable.id.max()) ?? 0;

  }

  /// Get the maximum pitch id 
  Future<int> maxTermMetaBankV3PitchId() async {
    
    final query = await (selectOnly(termMetaBankV3PitchTable)
        ..addColumns([termMetaBankV3PitchTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termMetaBankV3PitchTable.id.max()) ?? 0;

  }

  /// Get the maximum ipa id 
  Future<int> maxTermMetaBankV3IpaId() async {
    
    final query = await (selectOnly(termMetaBankV3IpaTable)
        ..addColumns([termMetaBankV3IpaTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termMetaBankV3IpaTable.id.max()) ?? 0;

  }

  /// Get the maximum tag id 
  Future<int> maxTermMetaBankV3TagId() async {
    
    final query = await (selectOnly(termMetaBankV3TagTable)
        ..addColumns([termMetaBankV3TagTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termMetaBankV3TagTable.id.max()) ?? 0;

  }

}
