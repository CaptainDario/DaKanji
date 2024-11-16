import 'package:drift/drift.dart';



/// Contains the main Kanji entries to which the other tables link
@TableIndex(name: 'kanji', columns: {#kanji})
class KanjiBankV3Table extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();


  /// the kanji character of this entry
  /// this column is indexed
  TextColumn get kanji => text().withLength(min: 1, max: 1)();

  /// the onyomi reading of this character
  // is there a way to reference all entries from the Meanings Table?

  /// the kunyomi readings of this character
  // is there a way to reference all entries from the Meanings Table?

  /// the tags of this character
  // is there a way to reference all entries from the Meanings Table?

  // meanings
  // is there a way to reference all entries from the Meanings Table?

  // stats
  // is there a way to reference all entries from the stats Table?
}

/// Contains all onyomi reading elements and each entry links to
/// `KanjiBankV3Table` elements
class KanjiBankV3OnyomiTable extends Table {

  /// id of this meaning
  IntColumn get id => integer().autoIncrement()();

  /// `KanjiBankV3` entry this meaning belongs to
  IntColumn get kanjiBankV3ID => integer().references(KanjiBankV3Table, #id)();

  /// The onyomi reading of this entry
  TextColumn get onyomi => text()();

}

/// Contains all kunyomi reading elements and each entry links to
/// `KanjiBankV3Table` elements
class KanjiBankV3KunyomiTable extends Table {

  /// id of this meaning
  IntColumn get id => integer().autoIncrement()();

  /// `KanjiBankV3` entry this meaning belongs to
  IntColumn get kanjiBankV3ID => integer().references(KanjiBankV3Table, #id)();

  /// The kunyomi reading of this entry
  TextColumn get kunyomi => text().nullable()();

}

/// Contains all tags and each entry links to a `KanjiBankV3Table` elements
class KanjiBankV3TagTable extends Table {

  /// id of this meaning
  IntColumn get id => integer().autoIncrement()();

  /// `KanjiBankV3` entry this meaning belongs to
  IntColumn get kanjiBankV3ID => integer().references(KanjiBankV3Table, #id)();

  /// The kunyomi reading of this entry
  TextColumn get tag => text()();

}

/// Contains all kanji meaning elements and each entry links to
/// `KanjiBankV3Table` elements
class KanjiBankV3MeaningsTable extends Table {

  /// id of this meaning
  IntColumn get id => integer().autoIncrement()();

  /// `KanjiBankV3` entry this meaning belongs to
  IntColumn get kanjiBankV3ID => integer().references(KanjiBankV3Table, #id)();

  /// The meaning of this entry
  TextColumn get meaning => text()();

}

/// Contains all kanji stats and each entry links to
/// `KanjiBankV3Table` elements
class KanjiBankV3StatsTable extends Table {

  /// id of this meaning
  IntColumn get id => integer().autoIncrement()();

  /// `KanjiBankV3` entry this meaning belongs to
  IntColumn get kanjiBankV3ID => integer().references(KanjiBankV3Table, #id)();

  /// The name of this entrie's stat
  TextColumn get statName => text()();

  /// The value of this entrie's stat
  TextColumn get statValue => text()();

}

