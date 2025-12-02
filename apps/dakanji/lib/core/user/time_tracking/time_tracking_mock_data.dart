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
          // The Runaway Segment (Yesterday 16:15 -> Now)
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
  /// STRICT RULE: Never generates data for "Today".
  Future<void> generateLastThreeWeeks({bool clearExisting = true}) async {
    await db.transaction(() async {
      // Start loop at 1 (Yesterday). Today (0) is never touched.
      await _generateHistoryInternal(
        clearExisting: clearExisting, 
        startDayIndex: 1 
      );
    });
  }

  /// Internal generator that allows specifying where history begins.
  /// [startDayIndex] = 0 (Today), 1 (Yesterday), 2 (Day before), etc.
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
    
    // Loop from [startDayIndex] backwards to 21 days ago.
    for (int i = startDayIndex; i < 21; i++) {
      final targetDateLocal = nowLocal.subtract(Duration(days: i));
      
      // 20% chance to skip a day
      if (_rng.nextDouble() < 0.2) continue;

      final sessionCount = _rng.nextInt(3) + 1; 

      // Start the day randomly between 8am-10am LOCAL time
      final startOfDayLocal = DateTime(targetDateLocal.year, targetDateLocal.month, targetDateLocal.day);
      DateTime currentCursorLocal = startOfDayLocal.add(Duration(hours: 8 + _rng.nextInt(2), minutes: _rng.nextInt(60)));
      
      for (int s = 0; s < sessionCount; s++) {
        final sessionEndLocal = await _generateRandomSession(
          startTimeLocal: currentCursorLocal, 
          // History sessions are never running. They are done.
          isCompleted: true, 
        );

        currentCursorLocal = sessionEndLocal.add(Duration(minutes: 15 + _rng.nextInt(105)));
      }
    }
    
    print("✅ Mock Data Generated (Starts from Day -$startDayIndex)");
  }

  // --- Internal Helpers ---

  Future<DateTime> _generateRandomSession({
    required DateTime startTimeLocal, 
    required bool isCompleted,
  }) async {
    final category = _categories[_rng.nextInt(_categories.length)];
    final tag = _rng.nextBool() ? _tags[_rng.nextInt(_tags.length)] : null;
    
    final baseStartTime = startTimeLocal;
    final pattern = _rng.nextInt(100);
    List<_MockUnit> units = [];
    DateTime lastEndTimeLocal;

    // Pattern 1: Solid Block
    if (pattern < 60) {
      final duration = Duration(minutes: 20 + _rng.nextInt(70));
      lastEndTimeLocal = baseStartTime.add(duration);
      units.add(_MockUnit(baseStartTime.toUtc(), lastEndTimeLocal.toUtc()));
    
    // Pattern 2: Pomodoro
    } else if (pattern < 90) {
      var time = baseStartTime;
      final loops = 2 + _rng.nextInt(2);
      
      for (int p = 0; p < loops; p++) {
        final workEnd = time.add(const Duration(minutes: 25));
        units.add(_MockUnit(time.toUtc(), workEnd.toUtc()));
        time = workEnd.add(const Duration(minutes: 5)); 
      }
      lastEndTimeLocal = time.subtract(const Duration(minutes: 5));

    // Pattern 3: Micro Session
    } else {
      final duration = Duration(minutes: 2 + _rng.nextInt(8));
      lastEndTimeLocal = baseStartTime.add(duration);
      units.add(_MockUnit(baseStartTime.toUtc(), lastEndTimeLocal.toUtc()));
    }

    // Handle explicit "Running" override (only used if isCompleted passed as false)
    if (!isCompleted) {
       final lastUnit = units.last;
       units[units.length - 1] = _MockUnit(lastUnit.start, null);
    }

    await _insertSession(
      category: category, 
      tag: tag, 
      isCompleted: isCompleted, 
      units: units
    );

    return lastEndTimeLocal;
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