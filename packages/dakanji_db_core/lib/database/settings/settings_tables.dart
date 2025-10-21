import 'package:dakanji_db_core/database/index/index_tables.dart';
import 'package:dakanji_db_core/helper/json_converter.dart';
import 'package:drift/drift.dart';



class SettingsTables extends Table {

  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// The index-id of the dictionary used for popularity stats
  IntColumn get currentPopularityDictionaryIndexId => integer().nullable()
    .references(IndexTable, #id, onDelete: KeyAction.setNull)();

  /// The order of the dictionaries the user specified
  TextColumn get currentDictionaryOrder => text().map(const JsonConverter())();

}