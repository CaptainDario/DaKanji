import 'package:da_kanji_mobile/core/user/time_tracking/time_tracking_table.dart';
import 'package:da_kanji_mobile/core/user/time_tracking/timer_status.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/core/utils/sql_utils.dart';
import 'package:drift/drift.dart';
import 'package:async/async.dart';

part 'time_tracking_dao.g.dart';


@DriftAccessor(
  tables: [
    TimeTrackingTable,
    TimeTrackingUnitTable,
    TimeTrackingTagsTable,
    TimeTrackingCategoriesTable,
    TimeTrackingDailyGoalTable,
  ]
)
class TimeTrackingDao extends DatabaseAccessor<UserDataDB> with _$TimeTrackingDaoMixin {

  TimeTrackingDao(super.db);

  // --- START : Daily Goals Management ---

  /// Ensures that there is an entry for today's date in the Daily Goals table.
  /// If not, it inserts one with the provided [defaultGoal] in minutes.
  Future<void> ensureDailyGoalExists({int defaultGoal = 60}) async {
    final now = DateTime.now();
    // Normalize to local midnight to ensure consistent day-based lookup
    final todayLocal = DateTime(now.year, now.month, now.day);
    final todaySql = const IsoDateConverter().toSql(todayLocal);

    // Check if today already exists
    final exists = await (select(timeTrackingDailyGoalTable)
          ..where((t) => t.date.equals(todaySql)))
        .getSingleOrNull();

    if (exists != null) return;

    // Get most recent goal to maintain user preference
    final lastEntry = await (select(timeTrackingDailyGoalTable)
          ..orderBy([(t) => OrderingTerm.desc(t.date)])
          ..limit(1))
        .getSingleOrNull();

    final int goalToUse = lastEntry?.studyGoalMinutes ?? defaultGoal;

    await setTodayGoal(goalToUse);
  }

  // 2. GET (Future) - For one-off logic checks
  Future<int> getTodayGoal() async {
    final now = DateTime.now();
    final todayLocal = DateTime(now.year, now.month, now.day);
    final todaySql = const IsoDateConverter().toSql(todayLocal);

    final row = await (select(timeTrackingDailyGoalTable)
          ..where((t) => t.date.equals(todaySql)))
        .getSingleOrNull();
        
    return row?.studyGoalMinutes ?? 0;
  }

  // 3. SET - Call this when user changes the slider/input
  Future<void> setTodayGoal(int minutes) async {
    final now = DateTime.now();
    final todayLocal = DateTime(now.year, now.month, now.day);
    
    await into(timeTrackingDailyGoalTable).insertOnConflictUpdate(
      TimeTrackingDailyGoalTableCompanion(
        date: Value(todayLocal),
        studyGoalMinutes: Value(minutes),
      ),
    );
  }

  // --- END   : Daily Goals Management ---

  // --- START : Statistics & History ---

  /// Fetches daily study totals AND goals for a specific date range.
  /// Returns: `Map<Date, (Minutes Studied, Daily Goal)>`
  /// Keys are normalized to `DateTime.utc(y, m, d)` (representing the Local day) 
  /// to ensure equality matches with UI keys.
  Future<Map<DateTime, (int, int)>> getStudyHistoryRange({
    required DateTime start,
    required DateTime end,
  }) async {
    
    // 1. Fetch Actual Study Time (Aggregate Units)
    // -------------------------------------------------
    // Query range must be in UTC because the DB stores UTC
    final unitsQuery = select(timeTrackingUnitTable)
      ..where((t) => t.startTime.isBetweenValues(start.toUtc(), end.toUtc()));

    final units = await unitsQuery.get();
    final Map<DateTime, int> actualMap = {};

    for (final unit in units) {
      // CRITICAL: Convert to Local Time BEFORE determining the day.
      // A session at 23:00 Local is still "Today", even if it is 02:00 UTC "Tomorrow".
      final localStart = unit.startTime.toLocal();
      
      // Create a normalized key (UTC with local values) for Map equality
      final dateKey = DateTime.utc(localStart.year, localStart.month, localStart.day);
      
      final localEnd = unit.endTime?.toLocal() ?? DateTime.now();
      final duration = localEnd.difference(localStart).inMinutes;

      actualMap[dateKey] = (actualMap[dateKey] ?? 0) + duration;
    }

    // 2. Fetch Historical Goals
    // -------------------------------------------------
    // Goals are typically stored as ISO strings representing the day (YYYY-MM-DD).
    final goalsQuery = select(timeTrackingDailyGoalTable)
      ..where((t) => t.date.isBetweenValues(
        const IsoDateConverter().toSql(start),
        const IsoDateConverter().toSql(end)
      ));
      
    final goals = await goalsQuery.get();
    final Map<DateTime, int> goalMap = {};

    for (var row in goals) {
      // Convert the storage date to our normalized key format
      final d = row.date;
      final dateKey = DateTime.utc(d.year, d.month, d.day);
      goalMap[dateKey] = row.studyGoalMinutes;
    }

    // 3. Merge Results
    // -------------------------------------------------
    final Map<DateTime, (int, int)> result = {};
    final allDates = {...actualMap.keys, ...goalMap.keys};

    for (final date in allDates) {
      final studied = actualMap[date] ?? 0;
      final goal = goalMap[date] ?? 0;
      
      result[date] = (studied, goal);
    }

    return result;
  }
  
  /// Calculates the current streak based *only* on Time Tracking data.
  /// 
  /// This solves the "Lazy Loading" issue by querying a large history range (365 days)
  /// directly from the database, rather than relying on the UI's loaded pages.
  /// 
  /// Logic:
  /// 1. A day is compliant if (Actual / Goal) >= 0.5.
  /// 2. If Today is compliant, count it. 
  /// 3. If Today is NOT compliant (or not started), check Yesterday.
  /// 4. Count backwards until a non-compliant day is found.
  Future<int> calculateTimeStreak() async {
    final now = DateTime.now();
    // Fetch enough history to cover most streaks (e.g., 1 year)
    final start = now.subtract(const Duration(days: 365));
    // getStudyHistoryRange returns Map<DateTime, (Actual, Goal)>
    final history = await getStudyHistoryRange(start: start, end: now);
    
    int streak = 0;
    // Normalize logic cursor to UTC midnight (matching history keys)
    DateTime checkDate = DateTime.utc(now.year, now.month, now.day);
    
    // Helper to check compliance
    bool isCompliant(DateTime date) {
      if (!history.containsKey(date)) return false;
      final (actual, goal) = history[date]!;
      if (goal <= 0) return false; // No goal = streak break
      return (actual / goal) >= 0.5;
    }

    // 1. Check Today
    if (isCompliant(checkDate)) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    } else {
      // If today is not done yet, we don't break the streak immediately;
      // we just look at yesterday to see the "current standing".
      checkDate = checkDate.subtract(const Duration(days: 1));
    }

    // 2. Loop Backwards
    while (true) {
      if (isCompliant(checkDate)) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break; // Streak broken
      }
    }
    
    return streak;
  }
  
  /// Fetches all sessions that STARTED on a specific [date].
  /// [date] is expected to be a Local date.
  Future<List<({TimeTrackingTableData session, List<TimeTrackingUnitTableData> units})>> 
      getSessionsForDate(DateTime date) async {
    
    // 1. Define the day boundaries in Local Time
    final startOfDayLocal = DateTime(date.year, date.month, date.day);
    final endOfDayLocal = startOfDayLocal.add(const Duration(days: 1));

    // 2. Convert boundaries to UTC for the Database Query
    final startUtc = startOfDayLocal.toUtc();
    final endUtc = endOfDayLocal.toUtc();

    // 3. Query Sessions
    final sessionsQuery = select(timeTrackingTable).join([
      innerJoin(
        timeTrackingUnitTable,
        timeTrackingUnitTable.timeTrackingId.equalsExp(timeTrackingTable.id),
      )
    ]);

    // Filter units that fall within the UTC range corresponding to the Local day
    sessionsQuery.where(timeTrackingUnitTable.startTime.isBetweenValues(startUtc, endUtc));
    
    sessionsQuery.groupBy([timeTrackingTable.id]);

    final sessionResults = await sessionsQuery.get();
    
    List<({TimeTrackingTableData session, List<TimeTrackingUnitTableData> units})> fullData = [];

    for (final row in sessionResults) {
      final session = row.readTable(timeTrackingTable);
      
      final units = await (select(timeTrackingUnitTable)
        ..where((tbl) => tbl.timeTrackingId.equals(session.id))
        ..orderBy([(t) => OrderingTerm(expression: t.startTime)]))
        .get();

      fullData.add((session: session, units: units));
    }

    fullData.sort((a, b) {
      if (a.units.isEmpty || b.units.isEmpty) return 0;
      return a.units.first.startTime.compareTo(b.units.first.startTime);
    });

    return fullData;
  }
  // --- END : Statistics & History ---

  // --- START : Session Management ---

  /// Checks if the current timer has been running longer than [thresholdHours].
  /// Returns the start time (UTC) if true, null otherwise.
  /// 
  /// [thresholdHours] defaults to 6, but can be configured based on user preference.
  Future<DateTime?> checkLongRunningTimer({int thresholdHours = 6}) async {
    // 1. Get the running timer
    final running = await getRunningTimer();
    
    if (running == null) return null;

    // 2. Check Duration (Compare UTC to UTC)
    final nowUtc = DateTime.now().toUtc();
    final duration = nowUtc.difference(running.startTime);

    if (duration.inHours >= thresholdHours) {
      return running.startTime;
    }
    
    return null;
  }

  /// Checks for any running timers that have exceeded 24 hours.
  Future<void> enforce24HourLimit() async {
    // Use UTC for DB comparison
    final limit = DateTime.now().toUtc().subtract(const Duration(hours: 24));
    
    final staleUnits = await (select(timeTrackingUnitTable)
      ..where((t) => t.endTime.isNull() & t.startTime.isSmallerThanValue(limit)))
      .get();

    if (staleUnits.isEmpty) return;

    await transaction(() async {
      for (final unit in staleUnits) {
        final forcedEndTime = unit.startTime.add(const Duration(hours: 23, minutes: 59));

        // Close the Unit
        await (update(timeTrackingUnitTable)..where((t) => t.id.equals(unit.id)))
            .write(TimeTrackingUnitTableCompanion(
              endTime: Value(forcedEndTime),
            ));

        // Close the Session
        await (update(timeTrackingTable)
              ..where((t) => t.id.equals(unit.timeTrackingId)))
            .write(const TimeTrackingTableCompanion(
              isCompleted: Value(true),
            ));
      }
    });
  }

  Future<void> updateSession({
    required int sessionId,
    required DateTime newStartTime,
    required DateTime newEndTime,
    required int newBreakMinutes,
    String? category,
    String? tag,
  }) async {
    // Ensure inputs are UTC for storage
    final startUtc = newStartTime.toUtc();
    final endUtc = newEndTime.toUtc();

    return transaction(() async {
      await (update(timeTrackingTable)..where((t) => t.id.equals(sessionId))).write(
        TimeTrackingTableCompanion(
          category: Value(category),
          tag: Value(tag),
        ),
      );

      var units = await (select(timeTrackingUnitTable)
            ..where((t) => t.timeTrackingId.equals(sessionId))
            ..orderBy([(t) => OrderingTerm(expression: t.startTime)]))
          .get();

      if (units.isEmpty) return;

      // Update Boundaries
      await (update(timeTrackingUnitTable)
            ..where((t) => t.id.equals(units.first.id)))
          .write(TimeTrackingUnitTableCompanion(startTime: Value(startUtc)));

      await (update(timeTrackingUnitTable)
            ..where((t) => t.id.equals(units.last.id)))
          .write(TimeTrackingUnitTableCompanion(endTime: Value(endUtc)));

      units = await (select(timeTrackingUnitTable)
            ..where((t) => t.timeTrackingId.equals(sessionId))
            ..orderBy([(t) => OrderingTerm(expression: t.startTime)]))
          .get();

      // Recalculate Breaks
      int existingFixedBreaks = 0;
      if (units.length > 2) {
         for (int i = 0; i < units.length - 2; i++) {
             // Use internal logic (UTC) for difference calculation
             final end = units[i].endTime ?? units[i].startTime;
             final start = units[i+1].startTime;
             existingFixedBreaks += start.difference(end).inMinutes;
         }
      }

      final int neededLastGapMinutes = (newBreakMinutes - existingFixedBreaks).clamp(0, 1440);
      final Duration neededLastGap = Duration(minutes: neededLastGapMinutes);

      if (units.length == 1) {
        if (neededLastGapMinutes > 0) {
          final modifiedFirstEnd = endUtc.subtract(neededLastGap);
          
          final safeFirstEnd = modifiedFirstEnd.isBefore(startUtc) 
              ? startUtc 
              : modifiedFirstEnd;

          await (update(timeTrackingUnitTable)
              ..where((t) => t.id.equals(units.first.id)))
              .write(TimeTrackingUnitTableCompanion(endTime: Value(safeFirstEnd)));

          // Marker unit
          await into(timeTrackingUnitTable).insert(
            TimeTrackingUnitTableCompanion(
              timeTrackingId: Value(sessionId),
              startTime: Value(endUtc),
              endTime: Value(endUtc),
            ),
          );
        }
      } else {
        final secondToLastUnit = units[units.length - 2];
        final secondToLastEnd = secondToLastUnit.endTime ?? startUtc; 
        
        final newLastStart = secondToLastEnd.add(neededLastGap);
        
        final safeLastStart = newLastStart.isAfter(endUtc) 
            ? endUtc 
            : newLastStart;

        await (update(timeTrackingUnitTable)
            ..where((t) => t.id.equals(units.last.id)))
            .write(TimeTrackingUnitTableCompanion(startTime: Value(safeLastStart)));
      }
    });
  }
  
  Future<void> insertPastSession({
    required DateTime startTime,
    required DateTime endTime,
    required String category,
    String? tag,
    required int breakMinutes,
  }) async {
    // Ensure UTC
    final startUtc = startTime.toUtc();
    final endUtc = endTime.toUtc();

    return transaction(() async {
      final sessionId = await into(timeTrackingTable).insert(
        TimeTrackingTableCompanion(
          category: Value(category),
          tag: Value(tag),
          isCompleted: const Value(true),
        ),
      );

      final totalDuration = endUtc.difference(startUtc).inMinutes;
      final safeBreak = (breakMinutes >= totalDuration) ? 0 : breakMinutes;
      final workDuration = totalDuration - safeBreak;

      if (safeBreak > 0) {
        final firstUnitEnd = startUtc.add(Duration(minutes: workDuration));

        await into(timeTrackingUnitTable).insert(
          TimeTrackingUnitTableCompanion(
            timeTrackingId: Value(sessionId),
            startTime: Value(startUtc),
            endTime: Value(firstUnitEnd),
          ),
        );

        // Marker Unit
        await into(timeTrackingUnitTable).insert(
          TimeTrackingUnitTableCompanion(
            timeTrackingId: Value(sessionId),
            startTime: Value(endUtc),
            endTime: Value(endUtc),
          ),
        );
      } else {
        await into(timeTrackingUnitTable).insert(
          TimeTrackingUnitTableCompanion(
            timeTrackingId: Value(sessionId),
            startTime: Value(startUtc),
            endTime: Value(endUtc),
          ),
        );
      }
    });
  }

  /// Calculates the total study minutes for today (Local Time).
  Future<int> getTodayStudyMinutes() async {
    final nowLocal = DateTime.now();
    final startOfTodayLocal = DateTime(nowLocal.year, nowLocal.month, nowLocal.day);
    
    // Convert to UTC for Query Filtering
    // We want units that ended AFTER the start of the local day (or are still running)
    // AND started BEFORE right now.
    final startOfTodayUtc = startOfTodayLocal.toUtc();
    final nowUtc = nowLocal.toUtc();

    final units = await (select(timeTrackingUnitTable)
      ..where((t) {
        return t.endTime.isNull() | t.endTime.isBiggerThanValue(startOfTodayUtc);
      })
      ..where((t) => t.startTime.isSmallerThanValue(nowUtc))
    ).get();

    int totalMinutes = 0;

    for (final unit in units) {
      // Convert everything to Local for the logic calculation
      final unitStartLocal = unit.startTime.toLocal();
      final unitEndLocal = unit.endTime?.toLocal() ?? nowLocal;

      // Clamp start to today's start
      final effectiveStart = unitStartLocal.isBefore(startOfTodayLocal) 
          ? startOfTodayLocal 
          : unitStartLocal;

      // Clamp end to now
      final effectiveEnd = unitEndLocal.isAfter(nowLocal) 
          ? nowLocal 
          : unitEndLocal;

      if (effectiveEnd.isAfter(effectiveStart)) {
        totalMinutes += effectiveEnd.difference(effectiveStart).inMinutes;
      }
    }
    
    return totalMinutes;
  }

  /// Returns the the row of the currently running timer, if any.
  Future<TimeTrackingUnitTableData?> getRunningTimer() async {
    await enforce24HourLimit();

    final query = select(timeTrackingUnitTable)
      ..where((tbl) => tbl.endTime.isNull());
    return await query.getSingleOrNull();
  }

  Future<DateTime?> getRunningTimersStartTime() async {
    return (await getRunningTimer())?.startTime; // already UTC from DB
  }

  Stream<TimerStatus> watchCurrentStatus() {
    final runningStream = (select(timeTrackingUnitTable)
          ..where((tbl) => tbl.endTime.isNull())
          ..limit(1))
        .watchSingleOrNull();

    final sessionStream = (select(timeTrackingTable)
          ..where((tbl) => tbl.isCompleted.equals(false))
          ..limit(1))
        .watchSingleOrNull();

    return StreamZip([runningStream, sessionStream]).map((results) {
      final runningUnit = results[0] as TimeTrackingUnitTableData?;
      final activeSession = results[1] as TimeTrackingTableData?;

      if (runningUnit != null) return TimerStatus.running;
      if (activeSession != null) return TimerStatus.paused;
      return TimerStatus.idle;
    });
  }

  Future<TimerStatus> getCurrentStatus() async {
    await enforce24HourLimit();
    return watchCurrentStatus().first;
  }

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
    Duration totalPause = Duration.zero; 
    bool isPaused = true; 
    DateTime? lastEndTime;

    // We can calculate duration math using UTC directly as Duration is absolute
    final nowUtc = DateTime.now().toUtc();

    for (final unit in units) {
      if (lastEndTime != null) {
        totalPause += unit.startTime.difference(lastEndTime);
      }

      if (unit.endTime == null) {
        isPaused = false;
        totalWork += nowUtc.difference(unit.startTime);
      } else {
        totalWork += unit.endTime!.difference(unit.startTime);
        lastEndTime = unit.endTime;
      }
    }

    return (
      hasActiveSession: true, 
      isPaused: isPaused, 
      totalWorkDuration: totalWork,
      totalPauseDuration: totalPause,
      pauseStartTime: isPaused ? lastEndTime : null 
    );
  }

  Future<void> startNewSession(String? category, String? tags) async {
    return transaction(() async {
      final sessionId = await into(timeTrackingTable).insert(
        TimeTrackingTableCompanion(
          category: Value(category),
          tag: Value(tags),
          isCompleted: const Value(false),
        ),
      );

      await into(timeTrackingUnitTable).insert(
        TimeTrackingUnitTableCompanion(
          timeTrackingId: Value(sessionId),
          startTime: Value(DateTime.now().toUtc()), // Store UTC
          endTime: const Value(null),
        ),
      );
    });
  }

  Future<void> pauseTimer() async {
    final nowUtc = DateTime.now().toUtc();
    
    final query = update(timeTrackingUnitTable)
      ..where((tbl) => tbl.endTime.isNull());

    await query.write(
      TimeTrackingUnitTableCompanion(endTime: Value(nowUtc)),
    );
  }

  Future<void> resumeTimer() async {
    final activeSession = await (select(timeTrackingTable)
          ..where((tbl) => tbl.isCompleted.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();

    if (activeSession == null) {
      throw Exception("No active session found to resume!");
    }

    await into(timeTrackingUnitTable).insert(
      TimeTrackingUnitTableCompanion(
        timeTrackingId: Value(activeSession.id),
        startTime: Value(DateTime.now().toUtc()), // Store UTC
        endTime: const Value(null),
      ),
    );
  }

  Future<void> finishSession() async {
    return transaction(() async {
      await pauseTimer();

      final query = update(timeTrackingTable)
        ..where((tbl) => tbl.isCompleted.equals(false));
        
      await query.write(
        const TimeTrackingTableCompanion(isCompleted: Value(true)),
      );
    });
  }

  Future<void> deleteSession(int sessionId) async {
    return transaction(() async {
      await (delete(timeTrackingUnitTable)
            ..where((t) => t.timeTrackingId.equals(sessionId)))
          .go();

      await (delete(timeTrackingTable)
            ..where((t) => t.id.equals(sessionId)))
          .go();
    });
  }
  // --- END : Session Management ---

  // --- START : Tags and Categories Management ---
  Future<List<String>> getAllCategories() async {
    final query = select(timeTrackingCategoriesTable);
    final results = await query.get();
    return results.map((row) => row.category).toList();
  }

  Future<void> addCategory(String category) async {
    await into(timeTrackingCategoriesTable).insert(
      TimeTrackingCategoriesTableCompanion(
        category: Value(category),
      ),
      mode: InsertMode.insertOrIgnore
    );
  }

  Future<void> deleteCategory(String category) async {
    final query = delete(timeTrackingCategoriesTable)
      ..where((tbl) => tbl.category.equals(category));
    await query.go();
  }

  Future setSelectedCategory(String category) async {
    return transaction(() async {
      final deselectQuery = update(timeTrackingCategoriesTable)
        ..where((tbl) => tbl.isSelected.equals(true));
      await deselectQuery.write(
        const TimeTrackingCategoriesTableCompanion(isSelected: Value(false)),
      );

      final selectQuery = update(timeTrackingCategoriesTable)
        ..where((tbl) => tbl.category.equals(category));
      await selectQuery.write(
        const TimeTrackingCategoriesTableCompanion(isSelected: Value(true)),
      );

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

  Future<String?> getSelectedCategory() async {
    final query = select(timeTrackingCategoriesTable)
      ..where((tbl) => tbl.isSelected.equals(true))
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result?.category;
  }


  Future<List<String>> getAllTags() async {
    final query = select(timeTrackingTagsTable);
    final results = await query.get();
    return results.map((row) => row.tag).toList();
  }

  Future<void> addTag(String tag) async {
    await into(timeTrackingTagsTable).insert(
      TimeTrackingTagsTableCompanion(
        tag: Value(tag),
      ),
      mode: InsertMode.insertOrIgnore
    );
  }

  Future<void> deleteTag(String tag) async {
    final query = delete(timeTrackingTagsTable)
      ..where((tbl) => tbl.tag.equals(tag));
    await query.go();

  }

  Future setSelectedTag(String tag) async {
    return transaction(() async {
      final deselectQuery = update(timeTrackingTagsTable)
        ..where((tbl) => tbl.isSelected.equals(true));
      await deselectQuery.write(
        const TimeTrackingTagsTableCompanion(isSelected: Value(false)),
      );

      final selectQuery = update(timeTrackingTagsTable)
        ..where((tbl) => tbl.tag.equals(tag));
      await selectQuery.write(
        const TimeTrackingTagsTableCompanion(isSelected: Value(true)),
      );

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

  Future<String?> getSelectedTag() async {
    final query = select(timeTrackingTagsTable)
      ..where((tbl) => tbl.isSelected.equals(true))
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result?.tag;
  }
  // --- END   : Tags and Categories Management ---
}