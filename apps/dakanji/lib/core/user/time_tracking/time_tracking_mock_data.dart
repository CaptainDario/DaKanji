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

  /// The master method to generate all mock data scenarios.
  /// 
  /// [streakLength] - How many recent days (starting from valid history) should pass the goal.
  /// [length] - Total days of history to generate.
  /// [dailyGoalMinutes] - The goal to set for each generated day.
  /// [overlapToday] - If true, skips generating history for Day 0/1 and instead inserts a 
  ///                  running session starting yesterday.
  /// [overlapNearly24h] - Only applies if [overlapToday] is true. 
  ///                      If true, the running session starts 23h 58m ago (Testing caps).
  ///                      If false, it starts yesterday at 14:00 (Standard forgotten session).
  Future<void> generateMockData({
    int streakLength = 5,
    int length = 35,
    int dailyGoalMinutes = 60,
    bool overlapToday = false,
    bool overlapNearly24h = false,
  }) async {
    if (!kDebugMode) return;

    await db.transaction(() async {
      // 1. Clear DB
      await db.delete(db.timeTrackingUnitTable).go();
      await db.delete(db.timeTrackingTable).go();
      await db.delete(db.timeTrackingDailyGoalTable).go();

      // 2. Determine where history generation starts
      // If we are simulating an overlap (Runaway Session), we skip Today (0) and Yesterday (1)
      // in the history loop to prevent conflicts/noise, so the runaway session is clear.
      final int startDayIndex = overlapToday ? 2 : 0;
      final int effectiveLength = max(length, streakLength + 1);

      // 3. Generate History (Background Data)
      await _generateHistoryLoop(
        startDayIndex: startDayIndex, 
        daysToGenerate: effectiveLength, 
        streakLength: streakLength, 
        dailyGoalMinutes: dailyGoalMinutes
      );

      // 4. Generate Specific "Overlap/Runaway" Scenario (If requested)
      if (overlapToday) {
        await _generateRunawaySession(overlapNearly24h: overlapNearly24h);
      }
    });

    print("✅ Mock Data Generated: Streak=$streakLength, Overlap=$overlapToday (Nearly24h=$overlapNearly24h)");
  }

  // ===========================================================================
  // INTERNAL LOGIC
  // ===========================================================================

  Future<void> _generateHistoryLoop({
    required int startDayIndex,
    required int daysToGenerate,
    required int streakLength,
    required int dailyGoalMinutes,
  }) async {
    final now = DateTime.now();

    for (int i = startDayIndex; i < daysToGenerate; i++) {
        final targetDateLocal = now.subtract(Duration(days: i));
        
        // A. Insert Goal
        await _insertDailyGoal(targetDateLocal, dailyGoalMinutes);

        // B. Determine Duration based on Streak Rules
        // Note: We adjust the index relative to startDayIndex so the "Streak" 
        // feels correct relative to the "latest generated day".
        final adjustedIndex = i - startDayIndex;
        
        int minutesToGenerate = 0;
        bool shouldGenerate = true;

        if (adjustedIndex < streakLength) {
          // PASS (> 50%)
          final minPass = (dailyGoalMinutes / 2).ceil() + 1;
          final maxPass = (dailyGoalMinutes * 1.5).toInt();
          minutesToGenerate = minPass + _rng.nextInt(maxPass - minPass);
        } 
        else if (adjustedIndex == streakLength) {
          // FAIL (< 50%) - The Streak Breaker
          final maxFail = (dailyGoalMinutes / 2).floor() - 1;
          minutesToGenerate = maxFail <= 0 ? 0 : 1 + _rng.nextInt(maxFail);
        } 
        else {
          // RANDOM HISTORY
          if (_rng.nextDouble() < 0.4) {
            shouldGenerate = false;
          } else {
             minutesToGenerate = _rng.nextInt(dailyGoalMinutes + 30);
          }
        }

        if (shouldGenerate && minutesToGenerate > 0) {
          await _generateDayWithTotalDuration(
            dateLocal: targetDateLocal, 
            totalMinutes: minutesToGenerate
          );
        }
      }
  }

  Future<void> _generateRunawaySession({required bool overlapNearly24h}) async {
    final now = DateTime.now();

    if (overlapNearly24h) {
      // --- TEST CASE: 24h Cap ---
      // Single unit running for 23h 58m.
      final start = now.subtract(const Duration(hours: 23, minutes: 58));
      
      await _insertSession(
        category: "Test",
        tag: "24h Limit",
        isCompleted: false,
        units: [
           _MockUnit(start.toUtc(), null)
        ]
      );
    } else {
      // --- TEST CASE: Forgot to turn off yesterday ---
      // Started Yesterday 14:00. Has some history, then goes runaway.
      final yesterdayStartLocal = DateTime(now.year, now.month, now.day)
          .subtract(const Duration(days: 1)) 
          .add(const Duration(hours: 14)); 

      await _insertSession(
        category: "Kanji",
        tag: "N1 Grind", 
        isCompleted: false, 
        units: [
          _MockUnit(
            yesterdayStartLocal.toUtc(),
            yesterdayStartLocal.add(const Duration(hours: 1)).toUtc(),
          ),
          _MockUnit(
            yesterdayStartLocal.add(const Duration(hours: 1, minutes: 15)).toUtc(),
            yesterdayStartLocal.add(const Duration(hours: 2)).toUtc(),
          ),
          // Runaway Unit starts at 16:15 Yesterday
          _MockUnit(
            yesterdayStartLocal.add(const Duration(hours: 2, minutes: 15)).toUtc(),
            null, 
          ),
        ],
      );
    }
  }

  /// Splits total minutes into realistic sessions for a single day
  Future<void> _generateDayWithTotalDuration({
    required DateTime dateLocal,
    required int totalMinutes,
  }) async {
    DateTime cursor = DateTime(dateLocal.year, dateLocal.month, dateLocal.day, 9, 0);
    int minutesLeft = totalMinutes;

    while (minutesLeft > 0) {
      int sessionDuration = minutesLeft;
      // Split long sessions (randomly)
      if (minutesLeft > 45 && _rng.nextBool()) {
        sessionDuration = 20 + _rng.nextInt(minutesLeft - 20);
      }

      final startUtc = cursor.toUtc();
      final endUtc = cursor.add(Duration(minutes: sessionDuration)).toUtc();

      await _insertSession(
        category: _categories[_rng.nextInt(_categories.length)],
        tag: _rng.nextBool() ? _tags[_rng.nextInt(_tags.length)] : null,
        isCompleted: true,
        units: [_MockUnit(startUtc, endUtc)],
      );

      minutesLeft -= sessionDuration;
      cursor = cursor.add(Duration(minutes: sessionDuration + 30 + _rng.nextInt(60)));
    }
  }

  Future<void> _insertDailyGoal(DateTime date, int minutes) async {
    await db.into(db.timeTrackingDailyGoalTable).insert(
      TimeTrackingDailyGoalTableCompanion(
        date: Value(date),
        studyGoalMinutes: Value(minutes),
      ),
      mode: InsertMode.insertOrIgnore
    );
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