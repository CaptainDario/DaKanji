import 'package:drift/drift.dart';



/// Table to track the sessions of a user
class TimeTrackingTable extends Table {
  
  IntColumn get id => integer().autoIncrement()();

  TextColumn get category => text()();

  TextColumn get tags => text()();

  // false = The session is paused/running (Resume is possible).
  // true = The session is archived (Only "Start New" is possible).
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  
}

class TimeTrackingTagsTable extends Table {
  
  IntColumn get id => integer().autoIncrement()();

  TextColumn get tag => text().unique()();

  BoolColumn get isSelected => boolean().withDefault(const Constant(false))();
  
}

class TimeTrackingCategoriesTable extends Table {
  
  IntColumn get id => integer().autoIncrement()();

  TextColumn get category => text().unique()();

  BoolColumn get isSelected => boolean().withDefault(const Constant(false))();
  
}

/// Table that tracks the indivdual units that the user is *actually* stuyding
/// everyhting that is outside of [start - end] is considered a break
@TableIndex(name: 'timeTrackingIdIndex', columns: {#timeTrackingId})
class TimeTrackingUnitTable extends Table {
  
  IntColumn get id => integer().autoIncrement()();

  IntColumn get timeTrackingId => integer()
    .references(TimeTrackingTable, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get startTime => dateTime()();

  DateTimeColumn get endTime => dateTime().nullable()();
  
}