import 'package:drift/drift.dart';


class AudioTable extends Table {

  IntColumn get id => integer().autoIncrement()();

  /// The name of the audio source
  TextColumn get name => text().withLength(min: 1,)();

  /// The URI of the audio source
  TextColumn get uri => text().withLength(min: 1)();

  /// Is this a local audio source
  BoolColumn get local => boolean()();

}