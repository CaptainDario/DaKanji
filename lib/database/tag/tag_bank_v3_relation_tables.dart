// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:dakanji_db/database/tag/tag_bank_v3_tables.dart';

/// Contains the relationships between categoies readings and kanjis
class TagBankV3TagCategoryRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();

  /// the id of the associated tag reading
  IntColumn get tagId => integer().references(TagBankV3Table, #id)();
  /// the id of the associated tag category
  IntColumn get categoryId => integer().references(TagBankV3CategoryTable, #id)();

}
