// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_tracking_dao.dart';

// ignore_for_file: type=lint
mixin _$TimeTrackingDaoMixin on DatabaseAccessor<UserDataDB> {
  $TimeTrackingTableTable get timeTrackingTable =>
      attachedDatabase.timeTrackingTable;
  $TimeTrackingUnitTableTable get timeTrackingUnitTable =>
      attachedDatabase.timeTrackingUnitTable;
  $TimeTrackingTagsTableTable get timeTrackingTagsTable =>
      attachedDatabase.timeTrackingTagsTable;
  $TimeTrackingCategoriesTableTable get timeTrackingCategoriesTable =>
      attachedDatabase.timeTrackingCategoriesTable;
  $TimeTrackingDailyGoalTableTable get timeTrackingDailyGoalTable =>
      attachedDatabase.timeTrackingDailyGoalTable;
  TimeTrackingDaoManager get managers => TimeTrackingDaoManager(this);
}

class TimeTrackingDaoManager {
  final _$TimeTrackingDaoMixin _db;
  TimeTrackingDaoManager(this._db);
  $$TimeTrackingTableTableTableManager get timeTrackingTable =>
      $$TimeTrackingTableTableTableManager(
        _db.attachedDatabase,
        _db.timeTrackingTable,
      );
  $$TimeTrackingUnitTableTableTableManager get timeTrackingUnitTable =>
      $$TimeTrackingUnitTableTableTableManager(
        _db.attachedDatabase,
        _db.timeTrackingUnitTable,
      );
  $$TimeTrackingTagsTableTableTableManager get timeTrackingTagsTable =>
      $$TimeTrackingTagsTableTableTableManager(
        _db.attachedDatabase,
        _db.timeTrackingTagsTable,
      );
  $$TimeTrackingCategoriesTableTableTableManager
  get timeTrackingCategoriesTable =>
      $$TimeTrackingCategoriesTableTableTableManager(
        _db.attachedDatabase,
        _db.timeTrackingCategoriesTable,
      );
  $$TimeTrackingDailyGoalTableTableTableManager
  get timeTrackingDailyGoalTable =>
      $$TimeTrackingDailyGoalTableTableTableManager(
        _db.attachedDatabase,
        _db.timeTrackingDailyGoalTable,
      );
}
