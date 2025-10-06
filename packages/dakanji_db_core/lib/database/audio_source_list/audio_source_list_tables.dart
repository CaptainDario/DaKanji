import 'package:dakanji_db_core/database/index/index_tables.dart';
import 'package:drift/drift.dart';


class AudioSourceListTable extends Table {

  IntColumn get id => integer().autoIncrement()();

  IntColumn get indexId => integer().references(IndexTable, #id)();

  /// The name of the audio source
  TextColumn get name => text().withLength(min: 1,)();

  /// The URI of the audio source
  TextColumn get uri => text().withLength(min: 1)();

}