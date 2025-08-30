// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import '/database/general_tables/definition_tables.dart';
import '/database/general_tables/reading_tables.dart';
import '/database/kanji/kanji_bank_v3_tables.dart';
import '/database/tag/tag_bank_v3_tables.dart';

/// Contains the relationships between readings (onyomi) and kanjis
class KanjiBankV3OnyomiReadingRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated onyomi reading
  IntColumn get onyomiReadingId => integer().references(ReadingTable, #id)();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer().references(KanjiBankV3Table, #id)();

}

/// Contains the relationships between readings (kunyomi) and kanjis
class KanjiBankV3KunyomiReadingRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated kunyomi reading
  IntColumn get kunyomiReadingId => integer().references(ReadingTable, #id)();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer().references(KanjiBankV3Table, #id)();

}

/// Contains the relationships between tags and kanjis
class KanjiBankV3TagsKanjiRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated tag
  IntColumn get tagId => integer().references(TagBankV3Table, #id)();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer().references(KanjiBankV3Table, #id)();

}

/// Contains the relationships between definitions and kanjis
class KanjiBankV3DefinitionsKanjiRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated definition
  IntColumn get definitionId => integer().references(DefinitionTable, #id)();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer().references(KanjiBankV3Table, #id)();

}

/// Contains the relationships between stat values and kanjis
class KanjiBankV3StatKanjiRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated stats element
  IntColumn get statId => integer().references(KanjiBankV3StatsTable, #id)();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer().references(KanjiBankV3Table, #id)();

}
