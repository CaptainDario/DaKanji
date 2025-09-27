// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import '/database/general_tables/definition_tables.dart';
import '/database/general_tables/reading_tables.dart';
import '/database/kanji/kanji_bank_v3_tables.dart';
import '/database/tag/tag_bank_v3_tables.dart';

/// Contains the relationships between readings (onyomi) and kanjis
// ignore: camel_case_types
class KanjiBankV3_X_OnyomiReadingTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated onyomi reading
  IntColumn get onyomiReadingId => integer().references(ReadingTable, #id)();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer().references(KanjiBankV3Table, #id)();

}

/// Contains the relationships between readings (kunyomi) and kanjis
// ignore: camel_case_types
class KanjiBankV3_X_KunyomiReadingTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated kunyomi reading
  IntColumn get kunyomiReadingId => integer().references(ReadingTable, #id)();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer().references(KanjiBankV3Table, #id)();

}

/// Contains the relationships between tags and kanjis
// ignore: camel_case_types
class KanjiBankV3_X_TagBankV3Table extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated tag
  IntColumn get tagId => integer().references(TagBankV3Table, #id)();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer().references(KanjiBankV3Table, #id)();

}

/// Contains the relationships between definitions and kanjis
// ignore: camel_case_types
class KanjiBankV3_X_DefinitionTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated definition
  IntColumn get definitionId => integer().references(DefinitionTable, #id)();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer().references(KanjiBankV3Table, #id)();

}

/// Contains the relationships between stat values and kanjis
// ignore: camel_case_types
class KanjiBankV3_X_KanjiBankV3StatsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated stats element
  IntColumn get statId => integer().references(KanjiBankV3StatsTable, #id)();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer().references(KanjiBankV3Table, #id)();

}
