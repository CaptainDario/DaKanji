import 'package:dakanji_db/database/index/index_tables.dart';
import 'package:drift/drift.dart';



/// Contains the main Kanji entries to which the other tables link
@TableIndex(name: 'kanji', columns: {#kanji})
class KanjiBankV3Table extends Table {

  @override
  Set<Column> get primaryKey => {id};
  
  /// id of this entry
  IntColumn get id => integer()();

  /// the kanji character of this entry
  /// this column is indexed
  TextColumn get kanji => text().withLength(min: 1)();
}

/// Contains all onyomi reading elements and each entry links to
/// `KanjiBankV3Table` elements
class KanjiBankV3OnyomisTable extends Table {

  /// id of this meaning
  IntColumn get id => integer().autoIncrement()();

  /// The id of the dictionary this entry belongs to
  IntColumn get dictId => integer().references(IndexTable, #id)();

  /// The onyomi reading of this entry
  TextColumn get onyomi => text().unique()();

}

/// Contains all kunyomi reading elements and each entry links to
/// `KanjiBankV3Table` elements
class KanjiBankV3KunyomisTable extends Table {

  /// id of this meaning
  IntColumn get id => integer().autoIncrement()();

  /// The id of the dictionary this entry belongs to
  IntColumn get dictId => integer().references(IndexTable, #id)();

  /// The kunyomi reading of this entry
  TextColumn get kunyomi => text()();

}

/// Contains all tags and each entry links to a `KanjiBankV3Table` elements
class KanjiBankV3TagsTable extends Table {

  /// id of this meaning
  IntColumn get id => integer().autoIncrement()();

  /// The id of the dictionary this entry belongs to
  IntColumn get dictId => integer().references(IndexTable, #id)();

  /// The kunyomi reading of this entry
  TextColumn get tag => text()();

}

/// Contains all kanji meaning elements and each entry links to
/// `KanjiBankV3Table` elements
class KanjiBankV3MeaningsTable extends Table {

  /// id of this meaning
  IntColumn get id => integer().autoIncrement()();

  /// The id of the dictionary this entry belongs to
  IntColumn get dictId => integer().references(IndexTable, #id)();

  /// The meaning of this entry
  TextColumn get meaning => text()();

}

/// Contains all kanji stat's. Each entry links to a
/// [KanjiBankV3StatValuesTable] and a [KanjiBankV3StatNamesTable]
class KanjiBankV3StatsTable extends Table {

  /// id of this meaning
  IntColumn get id => integer().autoIncrement()();

  /// The id of the dictionary this entry belongs to
  IntColumn get dictId => integer().references(IndexTable, #id)();

  /// `KanjiBankV3StatsName` entry of this meaning
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