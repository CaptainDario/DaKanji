
import 'package:dakanji_db_core/database/index/index_tables.dart';
import 'package:dakanji_db_core/helper/sql_json_converter.dart';
import 'package:dakanji_db_core/helper/zlib_text_converter_io.dart';
import 'package:drift/drift.dart';

import '/database/general_tables/reading_tables.dart';
import '/database/general_tables/term_tables.dart';



/// Table that stores term bank entries to which other tables link
@TableIndex(name: 'TermBankV3Table_indexIdIndex', columns: {#indexId})
@TableIndex(name: 'TermBankV3Table_termId', columns: {#termId})
@TableIndex(name: 'TermBankV3Table_readingIdIndex', columns: {#readingId})
@TableIndex(name: 'TermBankV3Table_definitionJsonIdIndex', columns: {#definitionJsonId})
@TableIndex(name: 'TermBankV3Table_sequenceNumberIndex', columns: {#sequenceNumber})
class TermBankV3Table extends Table {

  @override
  Set<Column> get primaryKey => {id};
  
  /// id of this entry
  IntColumn get id => integer()();

  /// The id of the dictionary this entry belongs to
  IntColumn get indexId => integer().references(IndexTable, #id)();

  /// The ID of the text for the term.
  IntColumn get termId => integer().references(TermTable, #id)();

  /// The order of the definitions, used to sort them in the order they were
  /// provided by the dictionary. This is a JSON array of integers, where each
  /// integer corresponds to `termId`.
  TextColumn get definitionOrder => text().map(const JsonConverter())();

  /// The ID of the JSON representation of the definition
  IntColumn get definitionJsonId => integer().references(TermBankV3DefinitionJsonTable, #id)();

  /// ID reading of the term, or an empty string if the reading is the same as
  /// the term.
  IntColumn get readingId => integer().references(ReadingTable, #id)();

  /// Score used to determine popularity. Negative values are more rare and
  /// positive values are more frequent. This score is also used to sort search
  /// results.
  IntColumn get popularity => integer()();

  /// Sequence number for the term. Terms with the same sequence number can be
  /// shown together when the "resultOutputMode" option is set to "merge".
  IntColumn get sequenceNumber => integer()();

}

/// Table that stores the json of a definition (important for structured content)
class TermBankV3DefinitionJsonTable extends Table {

  @override
  Set<Column> get primaryKey => {id};
  
  /// id of this entry
  IntColumn get id => integer()();

  /// JSON representation of the term
  BlobColumn get definitionJson => blob().map(const ZlibStringConverter())();

}

/// Table that stores rule identifiers for definitions
class TermBankV3RuleIdentifierTable extends Table {

  @override
  Set<Column> get primaryKey => {id};
  
  /// id of this entry
  IntColumn get id => integer()();

  /// Rule identifiers for the definition which is used to validate
  /// deinflection. An empty string should be used for words which aren't inflected.
  TextColumn get ruleIdentifier => text()();

}