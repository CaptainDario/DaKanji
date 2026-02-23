
import 'package:drift/drift.dart';

/// Contains the kanji entries and links to the radicals table
@TableIndex(name: 'RadicalsTable_radical', columns: {#radical})
@TableIndex(name: 'RadicalsTable_strokeCount', columns: {#strokeCount})
class RadicalsTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the radical character of this entry
  TextColumn get radical => text().withLength(min: 1)();

  /// Stroke count of this radical
  IntColumn get strokeCount => integer()();
}
