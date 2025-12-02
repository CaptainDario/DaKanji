import 'dart:math';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode

class TimeTrackingMockDataGenerator {
  final UserDataDB db;
  final Random _rng = Random();

  TimeTrackingMockDataGenerator(this.db);

  // Configuration
  final List<String> _categories = ['Vocab', 'Kanji', 'Grammar', 'Reading', 'Listening'];
  final List<String> _tags = ['N1', 'N2', 'Review', 'Textbook', 'Anki'];

  /// Generates a complex scenario for TODAY to test UI edge cases.
  /// 
  /// Includes: 
  /// 1. A session with multiple breaks (Work-Pause-Work-Pause-Work)
  /// 2. A session that crosses midnight (Today 23:30 -> Tomorrow 00:15)
  Future<void> generateTodayComplexScenario() async {
    if (!kDebugMode) {
      print("⚠️ Aborted: Debug mode only.");
      return;
    }

    await db.transaction(() async {
      // Calculate start of "Today" in local time to anchor our specific times
      final nowLocal = DateTime.now();
      final todayStartLocal = DateTime(nowLocal.year, nowLocal.month, nowLocal.day);

      // --- SCENARIO 1: The "Grind" (Multiple Breaks) ---
      // 10:00 - 10:45 (Work)
      // 10:45 - 11:00 (Break - 15m)
      // 11:00 - 11:45 (Work)
      // 11:45 - 12:30 (Break - 45m Lunch)
      // 12:30 - 13:00 (Work)
      await _insertSession(
        category: "Kanji",
        tag: "N1 Drill", 
        isCompleted: true,
        units: [
          _MockUnit(
            todayStartLocal.add(const Duration(hours: 10, minutes: 0)).toUtc(),
            todayStartLocal.add(const Duration(hours: 10, minutes: 45)).toUtc(),
          ),
          _MockUnit(
            todayStartLocal.add(const Duration(hours: 11, minutes: 0)).toUtc(),
            todayStartLocal.add(const Duration(hours: 11, minutes: 45)).toUtc(),
          ),
          _MockUnit(
            todayStartLocal.add(const Duration(hours: 12, minutes: 30)).toUtc(),
            todayStartLocal.add(const Duration(hours: 13, minutes: 0)).toUtc(),
          ),
        ],
      );

      // --- SCENARIO 2: The "Midnight Crossover" ---
      // Starts Today 23:30 -> Ends Tomorrow 00:15
      // This tests if your "Sessions for Date" query correctly captures sessions starting today
      // but ending tomorrow.
      await _insertSession(
        category: "Reading",
        tag: "Novel",
        isCompleted: true,
        units: [
          _MockUnit(
            todayStartLocal.add(const Duration(hours: 23, minutes: 30)).toUtc(),
            todayStartLocal.add(const Duration(hours: 24, minutes: 15)).toUtc(), // = Next Day 00:15
          ),
        ],
      );
    });

    print("✅ Today's Complex Mock Data Generated");
  }

  /// Generates randomized data for the last 21 days (3 weeks).
  /// [clearExisting] will wipe the table before inserting (Recommended).
  Future<void> generateLastThreeWeeks({bool clearExisting = true}) async {
    if (!kDebugMode) {
      print("⚠️ Attempted to seed data in Release mode. Aborted.");
      return;
    }

    await db.transaction(() async {
      if (clearExisting) {
        await db.delete(db.timeTrackingUnitTable).go();
        await db.delete(db.timeTrackingTable).go();
      }

      final now = DateTime.now().toUtc();
      
      // Loop backwards from today to 21 days ago
      for (int i = 0; i < 21; i++) {
        final targetDate = now.subtract(Duration(days: i));
        
        // 20% chance to skip a day (Real humans take breaks)
        if (_rng.nextDouble() < 0.2) continue;

        // Generate 1 to 3 sessions per day
        final sessionCount = _rng.nextInt(3) + 1; 

        // Start the day randomly between 8am and 10am
        final startOfDay = DateTime.utc(targetDate.year, targetDate.month, targetDate.day);
        DateTime currentCursor = startOfDay.add(Duration(hours: 8 + _rng.nextInt(2), minutes: _rng.nextInt(60)));
        
        for (int s = 0; s < sessionCount; s++) {
          final isLast = (i == 0 && s == sessionCount - 1);
          
          // Generate session starting exactly at currentCursor
          // Returns the end time of that session
          final sessionEnd = await _generateRandomSession(
            startTime: currentCursor, 
            isLastSessionOfToday: isLast,
            targetDateForReference: targetDate
          );

          // Advance cursor for next session: End of previous + random break (15m to 2h)
          currentCursor = sessionEnd.add(Duration(minutes: 15 + _rng.nextInt(105)));
        }
      }
    });

    print("✅ Mock Data (3 Weeks) Generated Successfully");
  }

  // --- Internal Helpers ---

  /// Returns the DateTime when this generated session ends
  Future<DateTime> _generateRandomSession({
    required DateTime startTime, 
    required bool isLastSessionOfToday,
    required DateTime targetDateForReference,
  }) async {
    // 1. Randomize Metadata
    final category = _categories[_rng.nextInt(_categories.length)];
    final tag = _rng.nextBool() ? _tags[_rng.nextInt(_tags.length)] : null;
    
    // 2. Use provided startTime (This fixes the overlapping/negative value issue)
    final baseStartTime = startTime;

    // 3. Determine Session Pattern
    final pattern = _rng.nextInt(100);
    List<_MockUnit> units = [];
    DateTime lastEndTime;

    if (pattern < 60) {
      // 60% Chance: Standard Solid Block (20 - 90 mins)
      final duration = Duration(minutes: 20 + _rng.nextInt(70));
      lastEndTime = baseStartTime.add(duration);
      units.add(_MockUnit(baseStartTime, lastEndTime));
    
    } else if (pattern < 90) {
      // 30% Chance: Pomodoro Style (25m Work -> 5m Break -> 25m Work)
      var time = baseStartTime;
      final loops = 2 + _rng.nextInt(2); // 2 or 3 pomodoros
      
      for (int p = 0; p < loops; p++) {
        final workEnd = time.add(const Duration(minutes: 25));
        units.add(_MockUnit(time, workEnd));
        
        // Add 5 min break gap for next unit
        time = workEnd.add(const Duration(minutes: 5)); 
      }
      // The last "time" includes the break, but the actual work ended 5 mins ago
      lastEndTime = time.subtract(const Duration(minutes: 5));

    } else {
      // 10% Chance: Micro Session (Quick Review < 10 mins)
      final duration = Duration(minutes: 2 + _rng.nextInt(8));
      lastEndTime = baseStartTime.add(duration);
      units.add(_MockUnit(baseStartTime, lastEndTime));
    }

    // 4. Handle "Currently Running" Case
    bool isCompleted = true;
    
    // Only simulate running timer if "Today" is actually today
    final isActuallyToday = targetDateForReference.day == DateTime.now().day;
    
    if (isLastSessionOfToday && isActuallyToday && _rng.nextBool()) {
       isCompleted = false;
       final lastUnit = units.last;
       // Running timer has no end time
       units[units.length - 1] = _MockUnit(lastUnit.start, null);
    }

    await _insertSession(
      category: category, 
      tag: tag, 
      isCompleted: isCompleted, 
      units: units
    );

    return lastEndTime;
  }

  Future<void> _insertSession({
    required String category,
    required String? tag,
    required bool isCompleted,
    required List<_MockUnit> units,
  }) async {
    final sessionId = await db.into(db.timeTrackingTable).insert(
      TimeTrackingTableCompanion(
        category: Value(category),
        tag: Value(tag),
        isCompleted: Value(isCompleted),
      ),
    );

    for (final unit in units) {
      await db.into(db.timeTrackingUnitTable).insert(
        TimeTrackingUnitTableCompanion(
          timeTrackingId: Value(sessionId),
          startTime: Value(unit.start),
          endTime: Value(unit.end),
        ),
      );
    }
  }
}

class _MockUnit {
  final DateTime start;
  final DateTime? end;
  _MockUnit(this.start, this.end);
}