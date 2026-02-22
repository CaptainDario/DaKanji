
import 'package:dakanji_db_core/database/tag/tag_bank_v3_tables.dart';
import 'package:dakanji_db_core/util/data_converters/sql_json_converter.dart';
import 'package:drift/drift.dart';

import '/database/general_tables/kanji_tables.dart';
import '/database/index/index_tables.dart';

/// Contains the main Kanji entries to which the other tables link
@TableIndex(name: 'KanjiBankV3Table_indexIdIndex', columns: {#indexId})
@TableIndex(name: 'KanjiBankV3Table_KanjiIdIndex', columns: {#kanjiId})
class KanjiBankV3Table extends Table {

  @override
  Set<Column> get primaryKey => {id};
  
  /// id of this entry
  IntColumn get id => integer()();

  /// The id of the dictionary this entry belongs to
  IntColumn get indexId => integer()
    .references(IndexTable, #id, onDelete: KeyAction.cascade)();

  /// id of the kanji character of this entry
  IntColumn get kanjiId => integer().references(KanjiTable, #id)();
  
  /// The order of the Onyomi Readins, used to sort them in the order they were
  /// provided by the dictionary. This is a JSON array of integers, where each
  /// integer corresponds to `onyomiReadingId`.
  TextColumn get onyomiOrder => text().map(const JsonConverter())();

  /// The order of the Kunyomi Readins, used to sort them in the order they were
  /// provided by the dictionary. This is a JSON array of integers, where each
  /// integer corresponds to `kunyomiReadingId`.
  TextColumn get kunyomiOrder => text().map(const JsonConverter())();

  /// The order of the definitions, used to sort them in the order they were
  /// provided by the dictionary. This is a JSON array of integers, where each
  /// integer corresponds to `definitionId`.
  TextColumn get definitionOrder => text().map(const JsonConverter())();

}

/// Contains all kanji stat's. Each entry links to a [KanjiBankV3StatNamesTable]
/// row
@TableIndex(name: 'KanjiBankV3StatsTable_kanjiBankEntryIdIndex', columns: {#kanjiBankEntryId})
@TableIndex(name: 'KanjiBankV3StatsTable_statTagIdIndex', columns: {#statTagId})
class KanjiBankV3StatsTable extends Table {

  /// id of this stat
  IntColumn get id => integer().autoIncrement()();

  /// The id of the associated kanji bank v3 entry
  IntColumn get kanjiBankEntryId => integer()
    .references(KanjiBankV3Table, #id, onDelete: KeyAction.cascade)();

  /// The value of this entrie's stat
  TextColumn get statValue => text()();

  /// `TagBankV3Table` entry that belongs to this entry
  IntColumn get statTagId => integer()
    .references(TagBankV3Table, #id)();

}
