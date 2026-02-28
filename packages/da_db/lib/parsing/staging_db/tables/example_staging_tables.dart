import 'package:drift/drift.dart';

/// Main staging table for Example Sentences
class ExampleStagingTable extends Table {
  /// The local staging ID used to link tags, stats, and terms
  IntColumn get localId => integer().autoIncrement()();
  
  // --- Data mapped to ExampleTable ---
  IntColumn get groupId => integer()();
  TextColumn get languageCode => text()(); // e.g., 'jpn', 'eng'. Resolves to LanguageCodeTable

  // --- Data mapped to ExampleSentenceTable & FTS ---
  TextColumn get exampleSentence => text()();
  TextColumn get exampleSentenceReading => text().nullable()();
  TextColumn get exampleSentenceTokenized => text()(); // The pre-computed MeCab tokens for FTS5
}

/// Staging table for tags attached to the example
class ExampleTagStagingTable extends Table {
  IntColumn get exampleLocalId => integer()();
  TextColumn get tagName => text()();
}

/// Staging table for stats (e.g., JLPT level, frequency) attached to the example
class ExampleStatStagingTable extends Table {
  IntColumn get exampleLocalId => integer()();
  
  // The 4-field StatBank format
  TextColumn get statName => text()();
  TextColumn get displayName => text().nullable()();
  RealColumn get statValue => real().nullable()(); // Nullable for pure text stats!
  TextColumn get displayValue => text().nullable()();
}

/// Staging table for the dictionary words present in the sentence.
/// This maps directly to ExampleSentenceTable_X_TermTable for reverse-lookups.
class ExampleTermStagingTable extends Table {
  IntColumn get exampleLocalId => integer()();
  /// The base dictionary term (e.g., "食べる") to resolve against TermTable
  TextColumn get term => text()(); 
}

/// Staging table for audio files associated with the example
class ExampleAudioStagingTable extends Table {
  /// Auto-incrementing ID so we can attach specific tags directly to the audio
  IntColumn get localId => integer().autoIncrement()();
  IntColumn get exampleLocalId => integer()();
  
  TextColumn get path => text()();
  TextColumn get name => text()();
}

/// Staging table for tags attached specifically to an audio file
class ExampleAudioTagStagingTable extends Table {
  IntColumn get audioLocalId => integer()();
  TextColumn get tagName => text()();
}

/// Staging table for stats attached specifically to an audio file
class ExampleAudioStatStagingTable extends Table {
  IntColumn get audioLocalId => integer()();
  
  // The 4-field StatBank format
  TextColumn get statName => text()();
  TextColumn get displayName => text().nullable()();
  RealColumn get statValue => real().nullable()();
  TextColumn get displayValue => text().nullable()();
}