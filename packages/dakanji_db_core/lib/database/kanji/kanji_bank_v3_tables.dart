// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import '/database/general_tables/kanji_tables.dart';
import '/database/index/index_tables.dart';

/// Contains the main Kanji entries to which the other tables link
class KanjiBankV3Table extends Table {

  @override
  Set<Column> get primaryKey => {id};
  
  /// id of this entry
  IntColumn get id => integer()();

  /// id of the kanji character of this entry
  IntColumn get kanjiId => integer().references(KanjiTable, #id)();

  /// The id of the dictionary this entry belongs to
  IntColumn get indexId => integer().references(IndexTable, #id)();
  
}

/// Contains all kanji stat's. Each entry links to a
/// [KanjiBankV3StatValuesTable] and a [KanjiBankV3StatNamesTable]
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
