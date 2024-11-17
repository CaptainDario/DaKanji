import 'dart:math';

import 'package:dakanji_db/database/kanji/kanji_bank_v3_table.dart';
import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';

part 'dakanji_db.g.dart';


@DriftDatabase(tables: [KanjiBankV3Table,
  KanjiBankV3OnyomisTable, KanjiBankV3OnyomiKanjiRelationsTable,
  KanjiBankV3KunyomisTable,
  KanjiBankV3TagsTable,
  KanjiBankV3MeaningsTable,
  KanjiBankV3StatsTable
])
class DaKanjiDB extends _$DaKanjiDB {
  // After generating code, this class needs to define a schemaVersion getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/getting-started/#open
  DaKanjiDB({
    String? path,
    QueryExecutor? executor
  }) : super(executor ?? _openConnection(path!));
  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection(String path) {
    return NativeDatabase.createInBackground(
      File(path),
      setup: (database) {
        // This is important, as accessing the database across threads otherwise
        // causes "database locked" errors.
        // With write-ahead logging (WAL) enabled, a single writer and multiple
        // readers can operate on the database in parallel.
        database.execute('pragma journal_mode = MEMORY;');
      },
      readPool: 6
    );
  }

  /// Checks if the any of the given `kanjis` is already present in the database
  Future<int?> checkKanjiEntry(String kanji) async {

    final result = await managers.kanjiBankV3Table
      .filter((f) => f.kanji(kanji))
      .getSingleOrNull();

    return result?.id;

  }

  /// Checks if the any of the given `kanjis` is already present in the database
  Future<int?> checkOnyomiEntry(String kanji) async {

    final result = await managers.kanjiBankV3OnyomisTable
      .filter((f) => f.onyomi(kanji))
      .getSingleOrNull();

    return result?.id;

  }

  /// Get the maximum id of the kanji table
  Future<int> maxKanjiId() async {
    
    final query = await (selectOnly(kanjiBankV3Table)
        ..addColumns([kanjiBankV3Table.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(kanjiBankV3Table.id.max()) ?? 0;

  }

  /// Get the maximum id of the onyomi table
  Future<int> maxOnyomiId() async {
    final query = selectOnly(kanjiBankV3OnyomisTable)
        ..addColumns([kanjiBankV3OnyomisTable.id.max()]);
    final result = await query.getSingle();

    // Extract the value of the max column using the alias
    return result.read(kanjiBankV3OnyomisTable.id.max()) ?? 0;
  }

}