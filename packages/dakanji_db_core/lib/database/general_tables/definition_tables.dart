// Package imports:
import 'package:drift/drift.dart';

/// Contains the meanins entries to which other tables link
class DefinitionTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the definition of this entry
  TextColumn get definition => text().unique()();

}
