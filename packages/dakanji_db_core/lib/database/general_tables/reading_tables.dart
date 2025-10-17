
import 'package:drift/drift.dart';

/// Contains the kanji entries and links to the radicals table
class ReadingTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the reading of this entry
  TextColumn get reading => text().unique()();

  /// the normalized reading of this entry (e.g., コンピューター -> コンピュうたあ)
  TextColumn get readingNormalized => text().nullable()();

}
