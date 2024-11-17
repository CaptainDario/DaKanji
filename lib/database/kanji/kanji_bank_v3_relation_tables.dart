import 'package:drift/drift.dart';



/// Contains the relationships between onyomi readings and kanjis
class KanjiBankV3OnyomiKanjiRelationsTable extends Table {

  /// id of this realtion
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated onyomi reading
  IntColumn get onyomiId => integer()();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer()();

}

/// Contains the relationships between kunyomi readings and kanjis
class KanjiBankV3KunyomiKanjiRelationsTable extends Table {

  /// id of this realtion
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated onyomi reading
  IntColumn get kunyomiId => integer()();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer()();

}

/// Contains the relationships between tags and kanjis
class KanjiBankV3TagsKanjiRelationsTable extends Table {

  /// id of this realtion
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated onyomi reading
  IntColumn get tagId => integer()();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer()();

}

/// Contains the relationships between meanings and kanjis
class KanjiBankV3MeaningsKanjiRelationsTable extends Table {

  /// id of this realtion
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated onyomi reading
  IntColumn get meaningId => integer()();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer()();

}

/// Contains the relationships between stats and kanjis
class KanjiBankV3StatsKanjiRelationsTable extends Table {

  /// id of this realtion
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated onyomi reading
  IntColumn get statId => integer()();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer()();

}