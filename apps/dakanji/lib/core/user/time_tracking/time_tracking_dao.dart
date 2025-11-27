import 'package:da_kanji_mobile/core/user/time_tracking/time_tracking_table.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:drift/drift.dart';

part 'time_tracking_dao.g.dart';


@DriftAccessor(
  tables: [
    TimeTrackingTable, TimeTrackingUnitTable
  ]
)
class TimeTrackingDao extends DatabaseAccessor<UserDataDB> with _$TimeTrackingDaoMixin {

  TimeTrackingDao(super.db);

  Future<DateTime?> getRunningTimer() async {
    final query = select(timeTrackingUnitTable)
      ..where((tbl) => 
        tbl.endTime.isNull()
      );

    final result = await query.getSingleOrNull();

    return result?.startTime;
  }

  Future startTimer() async {
    final newUnit = TimeTrackingUnitTableCompanion(
      timeTrackingId: Value(1),
      startTime: Value(DateTime.now()),
      endTime: Value(null),
    );

    await into(timeTrackingUnitTable).insert(newUnit);
  }

  Future stopTimer() async {
    final query = update(timeTrackingUnitTable)
      ..where((tbl) => 
        tbl.endTime.isNull()
      );

    await query.write(
      TimeTrackingUnitTableCompanion(
        endTime: Value(DateTime.now()),
      )
    );
  }

}