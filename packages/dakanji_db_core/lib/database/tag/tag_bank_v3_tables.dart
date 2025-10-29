
import 'package:dakanji_db_core/database/index/index_tables.dart';
import 'package:drift/drift.dart';

/// Contains the tag defintions
@TableIndex(name: 'TagBankV3Table_indexIdIndex', columns: {#indexId})
@TableIndex(name: 'TagBankV3Table_name', columns: {#name})
class TagBankV3Table extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// The id of the dictionary this entry belongs to
  IntColumn get indexId => integer().references(IndexTable, #id)();

  /// Tag name.
  TextColumn get name => text()();
  /// Tag category
  TextColumn get category => text()();
  /// Sorting order for the tag.
  IntColumn get sortingOrder => integer()();
  /// Notes for the tag.
  TextColumn get notes => text()();
  /// Score used to determine popularity. Negative values are more rare and
  /// positive values are more frequent. This score is also used to sort search
  /// results.
  IntColumn get score => integer()();
}
