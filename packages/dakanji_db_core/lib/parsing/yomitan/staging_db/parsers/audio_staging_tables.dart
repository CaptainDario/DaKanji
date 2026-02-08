import 'package:drift/drift.dart';

/// Staging table for Audio Metadata (Terms, Readings, Pitch)
class AudioStagingTable extends Table {
  IntColumn get localId => integer().autoIncrement()();
  TextColumn get term => text()();
  TextColumn get reading => text().nullable()();
  IntColumn get pitchPattern => integer().nullable()();
  TextColumn get originalFileName => text()(); // Links to Media
}

/// Staging table for the actual Audio Files
class MediaStagingTable extends Table {
  IntColumn get localId => integer().autoIncrement()();
  TextColumn get fileName => text()();
  BlobColumn get content => blob()();
}