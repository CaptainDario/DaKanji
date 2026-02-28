import 'package:drift/drift.dart';

/// Staging table for any media Files
class MediaStagingTable extends Table {
  /// Auto-incrementing local ID
  IntColumn get localId => integer().autoIncrement()();
  
  /// The full original file path (e.g., "dir/file.mp3"). 
  /// This serves as the Foreign Key link to AudioStagingTable.originalFileName.
  TextColumn get fileName => text()();
  
  /// The normalized directory path (e.g., "dir") ready for MediaTable.path
  TextColumn get cleanPath => text()();
  
  /// The normalized file name (e.g., "file.mp3") ready for MediaTable.name
  TextColumn get cleanName => text()();
  
  /// The raw binary content of the file
  BlobColumn get content => blob()();
}