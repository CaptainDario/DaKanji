library stats_databaase;

// Dart imports:
import 'dart:io';

// Package imports:
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';

part 'dict_stats_table.dart';
part 'stats_database.g.dart';



@DriftDatabase(tables: [
  DictStatsTable
])
class StatsDatabase extends _$StatsDatabase {

  StatsDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {

    final dbFolder = g_DakanjiPathManager.statsDirectory;
    final file = File(p.join(dbFolder.path, 'stats_db.sqlite'));

    QueryExecutor qe = NativeDatabase.createInBackground(
      file,
      //sqlite3: sqlite3,
    );

    return qe;
  }
}
