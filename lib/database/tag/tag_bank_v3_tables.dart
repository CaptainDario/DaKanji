// Package imports:
import 'package:drift/drift.dart';

/// Contains the tag defintions
@TableIndex(name: 'name', columns: {#name})
class TagBankV3Table extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// Tag name.
  TextColumn get name => text().withLength(min: 1)();
  /// Sorting order for the tag.
  IntColumn get sortingOrder => integer()();
  /// Notes for the tag.
  TextColumn get notes => text().withLength(min: 1)();
  /// Score used to determine popularity. Negative values are more rare and
  /// positive values are more frequent. This score is also used to sort search
  /// results.
  IntColumn get score => integer()();
}

/// Contains the tag categories
class TagBankV3CategoryTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// Category for the tag.
  TextColumn get category => text().withLength(min: 1)();
}
