import 'package:drift/drift.dart';

/// Staging table for Audio Metadata (Terms, Readings, Pitch)
class AudioStagingTable extends Table {
  /// Auto-incrementing local ID for the staging process
  IntColumn get localId => integer().autoIncrement()();
  
  /// The raw term string
  TextColumn get term => text()();
  
  /// The normalized term (e.g. converted to standard form)
  TextColumn get termNormalized => text().nullable()();
  
  /// Segmented/Tokenized version of the term
  TextColumn get termTokens => text().nullable()();
  
  /// Normalized version of the tokens
  TextColumn get termTokensNormalized => text().nullable()();
  
  /// The raw reading string
  TextColumn get reading => text().nullable()();
  
  /// The normalized reading
  TextColumn get readingNormalized => text().nullable()();
  
  /// The pitch accent integer
  TextColumn get pitchPattern => text().nullable()();
  
  /// The full file path from the source zip, used to link to the MediaStagingTable
  TextColumn get originalFileName => text()(); 
}