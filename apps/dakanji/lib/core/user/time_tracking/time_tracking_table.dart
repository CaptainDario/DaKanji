import 'package:da_kanji_mobile/core/utils/sql_utils.dart';
import 'package:drift/drift.dart';



/// Table to track the daily study goals of the user
class TimeTrackingDailyGoalTable extends Table {
  
  IntColumn get id => integer().autoIncrement()();

  // the date for which the goal is set (unique per day)
  IntColumn get date => integer().map(const DateOnlyConverter()).unique()();

  // the study goal in minutes
  IntColumn get studyGoalMinutes => integer()();
  
}

/// Table to track the sessions of a user
class TimeTrackingTable extends Table {
  
  IntColumn get id => integer().autoIncrement()();

  TextColumn get category => text().nullable()();

  TextColumn get tag => text().nullable()();

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