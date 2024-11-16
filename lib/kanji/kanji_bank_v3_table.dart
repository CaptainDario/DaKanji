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
  //extColumn get onyomi => text()();
  /// the kunyomi readings of this character
  //TextColumn get kunyomi => text()();
  /// the tags of this character
  //TextColumn get tags => text()();

  // meanings
  // is there a way to reference all entries from the Meanings Table?

  // stats
  // is there a way to reference all entries from the stats Table?
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

