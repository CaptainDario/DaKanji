import 'dart:math';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode

class TimeTrackingMockDataGenerator {
  final UserDataDB db;
  final Random _rng = Random();

  TimeTrackingMockDataGenerator(this.db);

  final List<String> _categories = ['Vocab', 'Kanji', 'Grammar', 'Reading', 'Listening'];
  final List<String> _tags = ['N1', 'N2', 'Review', 'Textbook', 'Anki'];

  /// Scenario: A session started yesterday (14:00) and was never stopped.
  Future<void> generateYesterdayRunawayScenario() async {
    if (!kDebugMode) return;

    await db.transaction(() async {
      // 1. Generate background history starting from DAY 2 (Day before yesterday).
      // We skip Day 0 (Today) AND Day 1 (Yesterday) to ensure the runaway 
      // session below is the ONLY thing visible for yesterday.
      await _generateHistoryInternal(
        clearExisting: true, 
        startDayIndex: 2 
      );

      final now = DateTime.now();
      
      // 2. Create the specific "Yesterday" event
      // We anchor this to Yesterday 14:00 strict.
      final yesterdayStartLocal = DateTime(now.year, now.month, now.day)
          .subtract(const Duration(days: 1)) 
          .add(const Duration(hours: 14)); 

      await _insertSession(
        category: "Kanji",
        tag: "N1 Grind", 
        isCompleted: false, // The only running session allowed
        units: [
          _MockUnit(
            yesterdayStartLocal.toUtc(),
            yesterdayStartLocal.add(const Duration(hours: 1)).toUtc(),
          ),
          _MockUnit(
            yesterdayStartLocal.add(const Duration(hours: 1, minutes: 15)).toUtc(),
            yesterdayStartLocal.add(const Duration(hours: 2)).toUtc(),
          ),
          // The Runaway Segment (Yesterday 16:15 -> Now/Null)
          _MockUnit(
            yesterdayStartLocal.add(const Duration(hours: 2, minutes: 15)).toUtc(),
            null, 
          ),
        ],
      );
    });
    
    print("✅ Generated: Yesterday Runaway Scenario (History starts from Day -2)");
  }

  /// Standard Mock Data: Generates last 3 weeks.
  Future<void> generateLastThreeWeeks({bool clearExisting = true}) async {
    await db.transaction(() async {
      await _generateHistoryInternal(
        clearExisting: clearExisting, 
        startDayIndex: 1 
      );
    });
  }

  /// Internal generator
  Future<void> _generateHistoryInternal({
    required bool clearExisting,
    required int startDayIndex,
  }) async {
    if (!kDebugMode) {
      print("⚠️ Aborted: Debug mode only.");
      return;
    }

    if (clearExisting) {
      await db.delete(db.timeTrackingUnitTable).go();
      await db.delete(db.timeTrackingTable).go();
    }

    final nowLocal = DateTime.now();
    
    // Loop backwards from [startDayIndex] to 21 days ago.
    for (int i = startDayIndex; i < 21; i++) {
      final targetDateLocal = nowLocal.subtract(Duration(days: i));
      
      // 20% chance to skip a day completely
      if (_rng.nextDouble() < 0.2) continue;

      final sessionCount = _rng.nextInt(3) + 1; 

      // Start the day randomly between 8am-10am LOCAL time
      final startOfDayLocal = DateTime(targetDateLocal.year, targetDateLocal.month, targetDateLocal.day);
      DateTime currentCursorLocal = startOfDayLocal.add(Duration(hours: 8 + _rng.nextInt(2), minutes: _rng.nextInt(60)));
      
      for (int s = 0; s < sessionCount; s++) {
        
        // Safety Check: If we are past 10 PM, stop generating for this day.
        // This prevents the session from bleeding past midnight and overlapping 
        // with the next day's history (which is technically i-1).
        if (currentCursorLocal.hour >= 22) break;

        final sessionEndTimeUTC = await _generateRandomSession(
          startTimeLocal: currentCursorLocal, 
          isCompleted: true, 
        );

        // Calculate next start time: End of previous session + random gap (15-120 mins)
        // We use the UTC end time and convert back to local to ensure continuity
        currentCursorLocal = sessionEndTimeUTC.toLocal().add(Duration(minutes: 15 + _rng.nextInt(105)));
      }
    }
    
    print("✅ Mock Data Generated (Starts from Day -$startDayIndex)");
  }

  // --- Internal Helpers ---

  /// Generates a session starting at [startTimeLocal].
  /// Returns the [DateTime] (UTC) of when the session actually finished.
  Future<DateTime> _generateRandomSession({
    required DateTime startTimeLocal, 
    required bool isCompleted,
  }) async {
    final category = _categories[_rng.nextInt(_categories.length)];
    final tag = _rng.nextBool() ? _tags[_rng.nextInt(_tags.length)] : null;
    
    // Working with UTC internally avoids DST jumps/overlaps during calculation
    DateTime cursorUtc = startTimeLocal.toUtc();
    
    final pattern = _rng.nextInt(100);
    List<_MockUnit> units = [];

    // Pattern 1: Solid Block
    if (pattern < 60) {
      final duration = Duration(minutes: 20 + _rng.nextInt(70));
      final endUtc = cursorUtc.add(duration);
      units.add(_MockUnit(cursorUtc, endUtc));
    
    // Pattern 2: Pomodoro (Classic 25/5)
    } else if (pattern < 90) {
      final loops = 2 + _rng.nextInt(2); // 2 or 3 loops
      
      for (int p = 0; p < loops; p++) {
        final workEnd = cursorUtc.add(const Duration(minutes: 25));
        units.add(_MockUnit(cursorUtc, workEnd));
        // Advance cursor past work + break
        cursorUtc = workEnd.add(const Duration(minutes: 5)); 
      }
      // Note: cursorUtc is now sitting at the START of the next potential block.
      // But the actual LAST UNIT ended 5 minutes ago.
      // We rely on units.last.end to return the correct time below.

    // Pattern 3: Micro Session
    } else {
      final duration = Duration(minutes: 2 + _rng.nextInt(8));
      final endUtc = cursorUtc.add(duration);
      units.add(_MockUnit(cursorUtc, endUtc));
    }

    // Handle explicit "Running" override
    if (!isCompleted && units.isNotEmpty) {
       final lastUnit = units.last;
       units[units.length - 1] = _MockUnit(lastUnit.start, null);
    }

    await _insertSession(
      category: category, 
      tag: tag, 
      isCompleted: isCompleted, 
      units: units
    );

    // FIX: Return the actual end of the last unit generated.
    // This is the source of truth. Do not calculate it manually.
    if (units.isNotEmpty && units.last.end != null) {
      return units.last.end!;
    } else {
      // Fallback for running sessions or empty (shouldn't happen in history generation)
      return cursorUtc; 
    }
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