import 'package:dakanji_db/database/kanji/kanji_bank_v3_table.dart';
import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';

part 'dakanji_db.g.dart';


@DriftDatabase(tables: [KanjiBankV3Table, KanjiBankV3OnyomiTable,
  KanjiBankV3KunyomiTable, KanjiBankV3TagTable, KanjiBankV3MeaningsTable,
  KanjiBankV3StatsTable])
class DaKanjiDB extends _$DaKanjiDB {
  // After generating code, this class needs to define a schemaVersion getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/getting-started/#open
  DaKanjiDB(String path) : super(_openConnection(path));

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection(String path) {
    return NativeDatabase.createInBackground(File(path));
  }
}