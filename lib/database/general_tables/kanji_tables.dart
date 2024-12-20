// Package imports:
import 'package:drift/drift.dart';

/// Contains the kanji entries and links to the radicals table
@TableIndex(name: 'kanji', columns: {#kanji})
class KanjiTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the kanji character of this entry
  TextColumn get kanji => text().unique().withLength(min: 1)();

}
