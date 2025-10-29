
import 'package:dakanji_db_core/helper/json_converter.dart';
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
  IntColumn get indexId => integer().references(IndexTable, #id)();

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

/// Contains all kanji stat's. Each entry links to a
/// [KanjiBankV3StatValuesTable] and a [KanjiBankV3StatNamesTable]
@TableIndex(name: 'KanjiBankV3StatsTable_statNameIdIndex', columns: {#statNameId})
@TableIndex(name: 'KanjiBankV3StatsTable_statValueIdIndex', columns: {#statValueId})
class KanjiBankV3StatsTable extends Table {

  /// id of this stat
  IntColumn get id => integer().autoIncrement()();

  /// `KanjiBankV3StatsName` entry that belongs to this entry
  IntColumn get statNameId => integer().references(KanjiBankV3StatNamesTable, #id)();

  /// The value of this entrie's stat
  IntColumn get statValueId => integer().references(KanjiBankV3StatValuesTable, #id)();

}

/// Contains all kanji stat's values, links to a [KanjiBankV3StatsTable]
class KanjiBankV3StatValuesTable extends Table {

  /// id of this stat value
  IntColumn get id => integer().autoIncrement()();

  /// The value of this entrie's stat
  TextColumn get statValue => text()();

}

/// Contains all kanji stat's names, links to a [KanjiBankV3StatsTable]
class KanjiBankV3StatNamesTable extends Table {

  /// id of this stat name
  IntColumn get id => integer().autoIncrement()();

  /// The name of this entrie's stat
  TextColumn get statName => text()();

}
