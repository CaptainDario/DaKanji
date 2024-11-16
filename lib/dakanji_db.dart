import 'package:dakanji_db/kanji/kanji_bank_v3_table.dart';
import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';

part 'database.g.dart';


@DriftDatabase(tables: [KanjiBankV3, KanjiBankV3MeaningsTable])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a schemaVersion getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/getting-started/#open
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return NativeDatabase.createInBackground(File('path/to/your/database'));
  }
}