import 'package:da_kanji_mobile/core/user/time_tracking/time_tracking_table.dart';
import 'package:da_kanji_mobile/core/user/time_tracking/timer_status.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:drift/drift.dart';

part 'time_tracking_dao.g.dart';


@DriftAccessor(
  tables: [
    TimeTrackingTable, TimeTrackingUnitTable, TimeTrackingTagsTable, TimeTrackingCategoriesTable
  ]
)
class TimeTrackingDao extends DatabaseAccessor<UserDataDB> with _$TimeTrackingDaoMixin {

  TimeTrackingDao(super.db);


  // --- START : Session Management ---
  /// Returns the start time of the currently running timer, if any.
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

  /// Retrieves data to restore an active session, if any.
  Future<({
    bool hasActiveSession, 
    bool isPaused, 
    Duration totalWorkDuration,
    Duration totalPauseDuration,
    DateTime? pauseStartTime
  })> getSessionRestoreData() async {
    final activeSession = await (select(timeTrackingTable)
          ..where((tbl) => tbl.isCompleted.equals(false))
          ..limit(1))
          .getSingleOrNull();

    if (activeSession == null) {
      return (
        hasActiveSession: false, 
        isPaused: false, 
        totalWorkDuration: Duration.zero, 
        totalPauseDuration: Duration.zero, 
        pauseStartTime: null
      );
    }

    final units = await (select(timeTrackingUnitTable)
          ..where((tbl) => tbl.timeTrackingId.equals(activeSession.id))
          ..orderBy([(t) => OrderingTerm(expression: t.startTime)])) 
          .get();

    Duration totalWork = Duration.zero;
    Duration totalPause = Duration.zero; // <--- NEW
    bool isPaused = true; 
    DateTime? lastEndTime;

    for (final unit in units) {
      // 1. Calculate the GAP (Pause) before this unit started
      if (lastEndTime != null) {
        totalPause += unit.startTime.difference(lastEndTime);
      }

      // 2. Calculate the WORK duration of this unit
      if (unit.endTime == null) {
        isPaused = false;
        totalWork += DateTime.now().difference(unit.startTime);
      } else {
        totalWork += unit.endTime!.difference(unit.startTime);
        lastEndTime = unit.endTime;
      }
    }

    return (
      hasActiveSession: true, 
      isPaused: isPaused, 
      totalWorkDuration: totalWork,
      totalPauseDuration: totalPause, // <--- Return the sum of gaps
      pauseStartTime: isPaused ? lastEndTime : null 
    );
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
  // --- END : Session Management ---

  // --- START : Tags and Categories Management ---
  /// Get all tags that the user has defined
  Future<List<String>> getAllCategories() async {
    final query = select(timeTrackingCategoriesTable);
    final results = await query.get();
    return results.map((row) => row.category).toList();
  }

  /// Add a new category
  Future<void> addCategory(String category) async {
    await into(timeTrackingCategoriesTable).insert(
      TimeTrackingCategoriesTableCompanion(
        category: Value(category),
      ),
      mode: InsertMode.insertOrIgnore
    );
  }

  /// Delete an existing category
  Future<void> deleteCategory(String category) async {
    final query = delete(timeTrackingCategoriesTable)
      ..where((tbl) => tbl.category.equals(category));
    await query.go();
  }

  /// Set the selected category
  Future setSelectedCategory(String category) async {
    return transaction(() async {
      // 1. Deselect all categories
      final deselectQuery = update(timeTrackingCategoriesTable)
        ..where((tbl) => tbl.isSelected.equals(true));
      await deselectQuery.write(
        const TimeTrackingCategoriesTableCompanion(isSelected: Value(false)),
      );
      // 2. Select the desired category
      final selectQuery = update(timeTrackingCategoriesTable)
        ..where((tbl) => tbl.category.equals(category));
      await selectQuery.write(
        const TimeTrackingCategoriesTableCompanion(isSelected: Value(true)),
      );
    });
  }

  /// Get the selected category
  Future<String?> getSelectedCategory() async {
    final query = select(timeTrackingCategoriesTable)
      ..where((tbl) => tbl.isSelected.equals(true))
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result?.category;
  }


  /// Get all tags that the user has defined
  Future<List<String>> getAllTags() async {
    final query = select(timeTrackingTagsTable);
    final results = await query.get();
    return results.map((row) => row.tag).toList();
  }

  /// Add a new tag
  Future<void> addTag(String tag) async {
    await into(timeTrackingTagsTable).insert(
      TimeTrackingTagsTableCompanion(
        tag: Value(tag),
      ),
      mode: InsertMode.insertOrIgnore
    );
  }

  /// Delete an existing tag
  Future<void> deleteTag(String tag) async {
    final query = delete(timeTrackingTagsTable)
      ..where((tbl) => tbl.tag.equals(tag));
    await query.go();
  }

  Future setSelectedTag(String tag) async {
    return transaction(() async {
      // 1. Deselect all tags
      final deselectQuery = update(timeTrackingTagsTable)
        ..where((tbl) => tbl.isSelected.equals(true));
      await deselectQuery.write(
        const TimeTrackingTagsTableCompanion(isSelected: Value(false)),
      );

      // 2. Select the desired tag
      final selectQuery = update(timeTrackingTagsTable)
        ..where((tbl) => tbl.tag.equals(tag));
      await selectQuery.write(
        const TimeTrackingTagsTableCompanion(isSelected: Value(true)),
      );
    });
  }

  Future<String?> getSelectedTag() async {
    final query = select(timeTrackingTagsTable)
      ..where((tbl) => tbl.isSelected.equals(true))
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result?.tag;
  }
  // --- END   : Tags and Categories Management ---
}
