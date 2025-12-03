import 'package:da_kanji_mobile/core/user/time_tracking/time_tracking_table.dart';
import 'package:da_kanji_mobile/core/user/time_tracking/timer_status.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:drift/drift.dart';
import 'package:async/async.dart';

part 'time_tracking_dao.g.dart';


@DriftAccessor(
  tables: [
    TimeTrackingTable, TimeTrackingUnitTable, TimeTrackingTagsTable, TimeTrackingCategoriesTable
  ]
)
class TimeTrackingDao extends DatabaseAccessor<UserDataDB> with _$TimeTrackingDaoMixin {

  TimeTrackingDao(super.db);

  // --- START : Statistics & History ---
  
  /// Fetches all sessions that STARTED on a specific [date].
  /// Returns a list of sessions with their associated units (work blocks).
  Future<List<({TimeTrackingTableData session, List<TimeTrackingUnitTableData> units})>> 
      getSessionsForDate(DateTime date) async {
    
    // 1. Define the day boundaries
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    // 2. Query Sessions that started in this range
    // Join with the FIRST unit to check the start time of the session
    // (Since TimeTrackingTable doesn't have a startTime, only units do)
    final sessionsQuery = select(timeTrackingTable).join([
      innerJoin(
        timeTrackingUnitTable,
        timeTrackingUnitTable.timeTrackingId.equalsExp(timeTrackingTable.id),
      )
    ]);

    // Filter by the start time of the unit
    sessionsQuery.where(timeTrackingUnitTable.startTime.isBetweenValues(startOfDay, endOfDay));
    
    // Group by Session ID to avoid duplicates in the main result
    sessionsQuery.groupBy([timeTrackingTable.id]);

    final sessionResults = await sessionsQuery.get();
    
    // 3. For each session, fetch ALL its units to calculate breaks/end times
    List<({TimeTrackingTableData session, List<TimeTrackingUnitTableData> units})> fullData = [];

    for (final row in sessionResults) {
      final session = row.readTable(timeTrackingTable);
      
      final units = await (select(timeTrackingUnitTable)
        ..where((tbl) => tbl.timeTrackingId.equals(session.id))
        ..orderBy([(t) => OrderingTerm(expression: t.startTime)]))
        .get();

      fullData.add((session: session, units: units));
    }

    // Sort by the start time of the first unit
    fullData.sort((a, b) {
      if (a.units.isEmpty || b.units.isEmpty) return 0;
      return a.units.first.startTime.compareTo(b.units.first.startTime);
    });

    return fullData;
  }
  // --- END : Statistics & History ---

  // --- START : Session Management ---

  /// Checks for any running timers that have exceeded 24 hours.
  /// If found, it caps the unit at exactly 24 hours and closes the session.
  Future<void> enforce24HourLimit() async {
    // Find running units that started more than 24 hours ago
    final limit = DateTime.now().subtract(const Duration(hours: 24));
    
    final staleUnits = await (select(timeTrackingUnitTable)
      ..where((t) => t.endTime.isNull() & t.startTime.isSmallerThanValue(limit)))
      .get();

    if (staleUnits.isEmpty) return;

    await transaction(() async {
      for (final unit in staleUnits) {
        // The forced end time is 23:59h to prevent edge-case overlaps
        final forcedEndTime = unit.startTime.add(const Duration(hours: 23, minutes: 59));

        // Close the Unit
        await (update(timeTrackingUnitTable)..where((t) => t.id.equals(unit.id)))
            .write(TimeTrackingUnitTableCompanion(
              endTime: Value(forcedEndTime),
            ));

        // Close the Session (Mark as completed since it was abandoned)
        await (update(timeTrackingTable)
              ..where((t) => t.id.equals(unit.timeTrackingId)))
            .write(const TimeTrackingTableCompanion(
              isCompleted: Value(true),
            ));
      }
    });
  }

  /// Updates an existing session's details including time, breaks, and metadata.
  Future<void> updateSession({
    required int sessionId,
    required DateTime newStartTime,
    required DateTime newEndTime,
    required int newBreakMinutes,
    String? category,
    String? tag,
  }) async {
    return transaction(() async {
      // 1. Update Session Meta
      await (update(timeTrackingTable)..where((t) => t.id.equals(sessionId))).write(
        TimeTrackingTableCompanion(
          category: Value(category),
          tag: Value(tag),
        ),
      );

      // 2. Fetch Units to get current IDs
      var units = await (select(timeTrackingUnitTable)
            ..where((t) => t.timeTrackingId.equals(sessionId))
            ..orderBy([(t) => OrderingTerm(expression: t.startTime)]))
          .get();

      if (units.isEmpty) return;

      // 3. Update Global Start/End Boundaries
      // Set the very first start time
      await (update(timeTrackingUnitTable)
            ..where((t) => t.id.equals(units.first.id)))
          .write(TimeTrackingUnitTableCompanion(startTime: Value(newStartTime)));

      // Set the very last end time
      await (update(timeTrackingUnitTable)
            ..where((t) => t.id.equals(units.last.id)))
          .write(TimeTrackingUnitTableCompanion(endTime: Value(newEndTime)));

      // Refresh units to get updated boundaries/times for calculation
      units = await (select(timeTrackingUnitTable)
            ..where((t) => t.timeTrackingId.equals(sessionId))
            ..orderBy([(t) => OrderingTerm(expression: t.startTime)]))
          .get();

      // 4. Calculate existing breaks (sum of gaps) excluding the last gap
      int existingFixedBreaks = 0;
      if (units.length > 2) {
         for (int i = 0; i < units.length - 2; i++) {
             // Gap is between unit[i].end and unit[i+1].start
             final end = units[i].endTime ?? units[i].startTime;
             final start = units[i+1].startTime;
             existingFixedBreaks += start.difference(end).inMinutes;
         }
      }

      // 5. Determine the required duration for the final gap
      final int neededLastGapMinutes = (newBreakMinutes - existingFixedBreaks).clamp(0, 1440);
      final Duration neededLastGap = Duration(minutes: neededLastGapMinutes);

      if (units.length == 1) {
        // Case: No existing breaks (1 Unit).
        // Logic: "Add one at the end".
        // shorten the current unit and add a 0-duration unit at newEndTime to create the gap.
        
        if (neededLastGapMinutes > 0) {
          final modifiedFirstEnd = newEndTime.subtract(neededLastGap);
          
          // Safety: Don't let end be before start
          final safeFirstEnd = modifiedFirstEnd.isBefore(newStartTime) 
              ? newStartTime 
              : modifiedFirstEnd;

          // Update Unit 1 End Time
          await (update(timeTrackingUnitTable)
              ..where((t) => t.id.equals(units.first.id)))
              .write(TimeTrackingUnitTableCompanion(endTime: Value(safeFirstEnd)));

          // Insert Unit 2 (Marker at the end to force the timeline to stretch to newEndTime)
          await into(timeTrackingUnitTable).insert(
            TimeTrackingUnitTableCompanion(
              timeTrackingId: Value(sessionId),
              startTime: Value(newEndTime),
              endTime: Value(newEndTime),
            ),
          );
        }
      } else {
        // Case: Existing breaks.
        // Logic: "Make the last one longer" (or shorter).
        // Adjust the Start Time of the last unit to widen/shrink the gap before it.
        final secondToLastUnit = units[units.length - 2];
        final secondToLastEnd = secondToLastUnit.endTime ?? newStartTime; 
        
        // Calculate new start for the last unit based on the needed gap
        final newLastStart = secondToLastEnd.add(neededLastGap);
        
        // Safety: Start cannot be after End
        final safeLastStart = newLastStart.isAfter(newEndTime) 
            ? newEndTime 
            : newLastStart;

        await (update(timeTrackingUnitTable)
            ..where((t) => t.id.equals(units.last.id)))
            .write(TimeTrackingUnitTableCompanion(startTime: Value(safeLastStart)));
      }
    });
  }
  
  /// Inserts a fully completed session manually (e.g., from the editor).
  /// [breakMinutes] are subtracted from the end of the first unit to create a gap.
  Future<void> insertPastSession({
    required DateTime startTime,
    required DateTime endTime,
    required String category,
    String? tag,
    required int breakMinutes,
  }) async {
    return transaction(() async {
      // 1. Create the session entry
      final sessionId = await into(timeTrackingTable).insert(
        TimeTrackingTableCompanion(
          category: Value(category),
          tag: Value(tag),
          isCompleted: const Value(true),
        ),
      );

      // 2. Calculate Unit Splits
      // To represent a break, we create:
      // Unit 1: Start -> (End - Break)
      // Unit 2: End -> End (A 0-duration marker to define the gap)
      
      final totalDuration = endTime.difference(startTime).inMinutes;
      final safeBreak = (breakMinutes >= totalDuration) ? 0 : breakMinutes;
      final workDuration = totalDuration - safeBreak;

      if (safeBreak > 0) {
        final firstUnitEnd = startTime.add(Duration(minutes: workDuration));

        // Work Unit
        await into(timeTrackingUnitTable).insert(
          TimeTrackingUnitTableCompanion(
            timeTrackingId: Value(sessionId),
            startTime: Value(startTime),
            endTime: Value(firstUnitEnd),
          ),
        );

        // End Marker Unit (creates the gap visually in timeline)
        await into(timeTrackingUnitTable).insert(
          TimeTrackingUnitTableCompanion(
            timeTrackingId: Value(sessionId),
            startTime: Value(endTime),
            endTime: Value(endTime),
          ),
        );
      } else {
        // Continuous session with no break
        await into(timeTrackingUnitTable).insert(
          TimeTrackingUnitTableCompanion(
            timeTrackingId: Value(sessionId),
            startTime: Value(startTime),
            endTime: Value(endTime),
          ),
        );
      }
    });
  }

  /// Returns the the row of the currently running timer, if any.
  Future<TimeTrackingUnitTableData?> getRunningTimer() async {

    // ensure no timer is over 24 hours
    await enforce24HourLimit();

    final query = select(timeTrackingUnitTable)
      ..where((tbl) => tbl.endTime.isNull());
    final result = await query.getSingleOrNull();
    return result;
  }

  /// Returns the start time of the currently running timer, if any.
  Future<DateTime?> getRunningTimersStartTime() async {
    return (await getRunningTimer())?.startTime;
  }

  /// Returns the full state of the user's tracking.
  Stream<TimerStatus> watchCurrentStatus() {

    // Is the timer ticking right now?
    final runningStream = (select(timeTrackingUnitTable)
          ..where((tbl) => tbl.endTime.isNull())
          ..limit(1))
        .watchSingleOrNull();

    // Is there an "Active" session (Paused)?
    final sessionStream = (select(timeTrackingTable)
          ..where((tbl) => tbl.isCompleted.equals(false))
          ..limit(1))
        .watchSingleOrNull();

    // StreamZip waits for both streams to emit, then gives you a List based on order
    return StreamZip([runningStream, sessionStream]).map((results) {
      final runningUnit = results[0] as TimeTrackingUnitTableData?; // Type manually if needed
      final activeSession = results[1] as TimeTrackingTableData?;

      if (runningUnit != null) return TimerStatus.running;
      if (activeSession != null) return TimerStatus.paused;
      return TimerStatus.idle;
    });
  }

  Future<TimerStatus> getCurrentStatus() async {
    // ensure no timer is over 24 hours
    await enforce24HourLimit();
    return watchCurrentStatus().first;
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
  Future<void> startNewSession(String? category, String? tags) async {
    return transaction(() async {
      // A. Create the Parent (Session)
      final sessionId = await into(timeTrackingTable).insert(
        TimeTrackingTableCompanion(
          category: Value(category),
          tag: Value(tags),
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

  /// Deletes a session and all its associated time units.
  Future<void> deleteSession(int sessionId) async {
    return transaction(() async {
      // 1. Delete all units associated with this session
      await (delete(timeTrackingUnitTable)
            ..where((t) => t.timeTrackingId.equals(sessionId)))
          .go();

      // 2. Delete the session itself
      await (delete(timeTrackingTable)
            ..where((t) => t.id.equals(sessionId)))
          .go();
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

      // 3. Update the running session if any
      final runningSessionId = (await getRunningTimer())?.timeTrackingId;
      if (runningSessionId == null) return;

      await (update(timeTrackingTable)
        ..where((tbl) => tbl.id.equals(runningSessionId)))
        .write(
          TimeTrackingTableCompanion(
            category: Value(category),
          ),
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

  /// Set the selected tag
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

      // 3. Update the running session if any
      final runningSessionId = (await getRunningTimer())?.timeTrackingId;
      if (runningSessionId == null) return;

      await (update(timeTrackingTable)
        ..where((tbl) => tbl.id.equals(runningSessionId)))
        .write(
          TimeTrackingTableCompanion(
            tag: Value(tag),
          ),
        );
    });
  }

  /// Get the selected tag
  Future<String?> getSelectedTag() async {
    final query = select(timeTrackingTagsTable)
      ..where((tbl) => tbl.isSelected.equals(true))
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result?.tag;
  }
  // --- END   : Tags and Categories Management ---
}
