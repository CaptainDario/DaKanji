import 'package:drift/drift.dart';



/// Contains the kanji entries and links to the radicals table
@TableIndex(name: 'radicalKanji', columns: {#radicalKanji})
class RadicalsKanjiTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  // TODO link to kanji table
  /// the kanji character of this entry
  /// 
  /// **Note:** this column is indexed
  TextColumn get radicalKanji => text().withLength(min: 1)();
}

/// Contains the kanji entries and links to the radicals table
@TableIndex(name: 'radical', columns: {#radical})
class RadicalsTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the radical character of this entry
  /// this column is indexed
  TextColumn get radical => text().withLength(min: 1)();

  /// Stroke count of this radical
  IntColumn get strokeCount => integer()();
}