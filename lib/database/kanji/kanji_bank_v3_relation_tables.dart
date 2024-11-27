import 'package:dakanji_db/database/kanji/kanji_bank_v3_tables.dart';
import 'package:dakanji_db/database/tag/tag_bank_v3_tables.dart';
import 'package:drift/drift.dart';



/// Contains the relationships between onyomi readings and kanjis
class KanjiBankV3OnyomiKanjiRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated onyomi reading
  IntColumn get onyomiId => integer().references(KanjiBankV3OnyomisTable, #id)();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer().references(KanjiBankV3Table, #id)();

}

/// Contains the relationships between kunyomi readings and kanjis
class KanjiBankV3KunyomiKanjiRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated kunyomi reading
  IntColumn get kunyomiId => integer().references(KanjiBankV3KunyomisTable, #id)();
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

/// Contains the relationships between meanings and kanjis
class KanjiBankV3MeaningsKanjiRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated meaning
  IntColumn get meaningId => integer().references(KanjiBankV3MeaningsTable, #id)();
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