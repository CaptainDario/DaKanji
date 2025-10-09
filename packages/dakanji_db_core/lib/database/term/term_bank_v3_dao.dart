// Package imports:
import "package:dakanji_db_core/database/term/term_bank_v3_entry.dart";

import "/database/general_tables/term_tables.dart";
import "/database/tag/tag_bank_v3_tables.dart";
import "/database/term/term_bank_v3_tables.dart";
import "package:drift/drift.dart";

// Project imports:
import "../dakanji_db.dart";

part 'term_bank_v3_dao.g.dart';



///
@DriftAccessor(
  tables: [
    TermTable,
    TermBankV3Table,
    TermBankV3DefinitionTagsTable, TermBankV3RuleIdentifierTable,
    TagBankV3Table
  ],
)
class TermBankV3Dao extends DatabaseAccessor<DaKanjiDB> with _$TermBankV3DaoMixin {
  
  
  TermBankV3Dao(super.db);


  /// Searches in the Term Bank for 
  Future<List> search (String term, {int limit=-1, int offset=0}) async {
    return (await db.term_bank_v3_search_drift(term, limit, offset).get())
      .map((r) => TermBankV3Entry.fromTermBankV3EntryViewData(r))
      .toList();
  }

  // ---------------------------------------------------------------------------
  /// Get all definition tags and their ids 
  Future<List<TermBankV3DefinitionTagsTableData>> getAllDefinitionTags() async {
    return await select(termBankV3DefinitionTagsTable).get();
  }

  /// Get all rule identifiers and their ids 
  Future<List<TermBankV3RuleIdentifierTableData>> getAllRuleIdentifiers() async {
    return await select(termBankV3RuleIdentifierTable).get();
  }

  /// Get all tags and their ids 
  Future<List<TagBankV3TableData>> getAllTags() async {
    return await select(tagBankV3Table).get();
  }

  // ---------------------------------------------------------------------------
  /// Get the maximum definition tag id 
  Future<int> maxTermBankV3Id() async {
    
    final query = await (selectOnly(termBankV3Table)
        ..addColumns([termBankV3Table.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termBankV3Table.id.max()) ?? 0;

  }

  /// Get the maximum definition tag id 
  Future<int> maxTermBankV3DefinitionTagId() async {
    
    final query = await (selectOnly(termBankV3DefinitionTagsTable)
        ..addColumns([termBankV3DefinitionTagsTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termBankV3DefinitionTagsTable.id.max()) ?? 0;

  }

  /// Get the maximum definition tag id 
  Future<int> maxTermBankV3DefinitionJsonId() async {

    final query = await (selectOnly(termBankV3DefinitionJsonTable)
        ..addColumns([termBankV3DefinitionJsonTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termBankV3DefinitionJsonTable.id.max()) ?? 0;

  }

  /// Get the maximum definition tag id 
  Future<int> maxTermBankV3RuleIdentifierId() async {
    
    final query = await (selectOnly(termBankV3RuleIdentifierTable)
        ..addColumns([termBankV3RuleIdentifierTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termBankV3RuleIdentifierTable.id.max()) ?? 0;

  }

}
