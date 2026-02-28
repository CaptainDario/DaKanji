import 'package:drift/drift.dart';

/// Staging table for Kanji Meta entries (Frequency data)
class KanjiMetaStagingTable extends Table {
  IntColumn get localId => integer()();
  TextColumn get kanji => text()();
  TextColumn get type => text()(); // e.g., 'freq'
  
  // Frequency values can be a number or a string (or both)
  IntColumn get freqValue => integer().nullable()();
  TextColumn get freqDisplayValue => text().nullable()();
}