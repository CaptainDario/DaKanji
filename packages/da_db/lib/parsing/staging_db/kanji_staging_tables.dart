import 'package:drift/drift.dart';

/// Main staging table for Kanji entries
class KanjiStagingTable extends Table {
  IntColumn get localId => integer()();
  TextColumn get kanji => text()();
  TextColumn get originalOnyomi => text().nullable()();
  TextColumn get originalKunyomi => text().nullable()();
}

/// Staging table for both Onyomi and Kunyomi readings
class KanjiReadingStagingTable extends Table {
  IntColumn get kanjiLocalId => integer()();
  TextColumn get reading => text()();
  TextColumn get readingNormalized => text().nullable()();
  TextColumn get type => text()(); // 'onyomi' or 'kunyomi'
  IntColumn get position => integer()(); // To preserve order
}

/// Staging table for definitions (meanings)
class KanjiDefinitionStagingTable extends Table {
  IntColumn get kanjiLocalId => integer()();
  TextColumn get definition => text()();
  IntColumn get position => integer()();
}

/// Staging table for tags
class KanjiTagStagingTable extends Table {
  IntColumn get kanjiLocalId => integer()();
  TextColumn get tagName => text()();
}

/// Staging table for stats (e.g., frequency, stroke count)
class KanjiStatStagingTable extends Table {
  IntColumn get kanjiLocalId => integer()();
  TextColumn get tagName => text()(); // Stats are keyed by a Tag
  TextColumn get value => text()();
}