import 'package:dakanji_db/database/index/index_dao.dart';
import 'package:dakanji_db/database/index/index_tables.dart';
import 'package:dakanji_db/database/kanji/kanji_bank_v3_relation_tables.dart';
import 'package:dakanji_db/database/kanji/kanji_bank_v3_tables.dart';
import 'package:dakanji_db/database/kanji/kanji_bank_v3_dao.dart';
import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';

part 'dakanji_db.g.dart';



@DriftDatabase(tables: [
    IndexTable,

    KanjiBankV3Table,
    KanjiBankV3OnyomisTable, KanjiBankV3OnyomiKanjiRelationsTable,
    KanjiBankV3KunyomisTable, KanjiBankV3KunyomiKanjiRelationsTable,
    KanjiBankV3TagsTable, KanjiBankV3TagsKanjiRelationsTable,
    KanjiBankV3MeaningsTable, KanjiBankV3MeaningsKanjiRelationsTable,
    KanjiBankV3StatsTable, KanjiBankV3StatsKanjiRelationsTable


  ],
  daos: [
    KanjiBankV3Dao, IndexDao
  ]
)
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

}