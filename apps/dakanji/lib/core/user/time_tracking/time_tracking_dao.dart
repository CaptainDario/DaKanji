import 'package:da_kanji_mobile/core/user/time_tracking/time_tracking_table.dart';
import 'package:da_kanji_mobile/core/user/time_tracking/timer_status.dart';
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

  /// Returns the full state of the user's tracking.
  Future<TimerStatus> getCurrentStatus() async {
    // 1. Is the timer ticking right now?
    final runningUnit = await (select(timeTrackingUnitTable)
        ..where((tbl) => tbl.endTime.isNull())
        ..limit(1))
        .getSingleOrNull();

    if (runningUnit != null) {
      return TimerStatus.running;
    }

    // 2. Is there an "Active" session (Paused)?
    final activeSession = await (select(timeTrackingTable)
        ..where((tbl) => tbl.isCompleted.equals(false))
        ..limit(1))
        .getSingleOrNull();

    if (activeSession != null) {
      return TimerStatus.paused;
    }

    // 3. Nothing is happening.
    return TimerStatus.idle;
  }

  /// Creates a new row in TimeTrackingTable and starts the timer.
  Future<void> startNewSession(String category, String tags) async {
    return transaction(() async {
      // A. Create the Parent (Session)
      final sessionId = await into(timeTrackingTable).insert(
        TimeTrackingTableCompanion(
          category: Value(category),
          tags: Value(tags),
          isCompleted: const Value(false), // Set as Active
        ),
      );

      // B. Start the first Unit
      await into(timeTrackingUnitTable).insert(
        TimeTrackingUnitTableCompanion(
          timeTrackingId: Value(sessionId),
          startTime: Value(DateTime.now()),
          endTime: const Value(null),
        ),
      );
    });
  }

  /// Closes the current 'Unit'. The 'Session' remains active (isCompleted=false).
  Future<void> pauseTimer() async {
    final now = DateTime.now();
    
    // Find the currently running unit (where endTime is null)
    final query = update(timeTrackingUnitTable)
      ..where((tbl) => tbl.endTime.isNull());

    await query.write(
      TimeTrackingUnitTableCompanion(endTime: Value(now)),
    );
  }

  /// Does NOT create a new Session. Adds a new Unit to the EXISTING Session.
  Future<void> resumeTimer() async {
    // A. Find the most recent 'Active' Session
    final activeSession = await (select(timeTrackingTable)
          ..where((tbl) => tbl.isCompleted.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();

    if (activeSession == null) {
      throw Exception("No active session found to resume!");
    }

    // B. Create a new Unit linked to that Session
    await into(timeTrackingUnitTable).insert(
      TimeTrackingUnitTableCompanion(
        timeTrackingId: Value(activeSession.id),
        startTime: Value(DateTime.now()),
        endTime: const Value(null),
      ),
    );
  }

  /// Closes the current Unit AND marks the Session as completed.
  Future<void> finishSession() async {
    return transaction(() async {
      // A. Pause the timer (Close the unit)
      await pauseTimer();

      // B. Mark the Session as Complete
      // (This hides it from the 'Resume' logic)
      final query = update(timeTrackingTable)
        ..where((tbl) => tbl.isCompleted.equals(false));
        
      await query.write(
        const TimeTrackingTableCompanion(isCompleted: Value(true)),
      );
    });
  }
}
