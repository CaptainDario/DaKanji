import 'dart:math';
import 'package:intl/intl.dart';

/// Generates mock data.
/// [streakLength] ensures the most recent N days satisfy the >50% rule.
/// [length] determines how many days back to generate data for (default 35).
({
  Map<String, (int, int)> vocab,
  Map<String, (int, int)> characters,
  Map<String, (int, int)> time
}) generateMockStudyData({
  int streakLength = 5,
  int length = 35, 
}) {
  final Random random = Random();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateTime now = DateTime.now();

  final Map<String, (int, int)> v = {};
  final Map<String, (int, int)> c = {};
  final Map<String, (int, int)> t = {};

  // Generates progress strictly >= 50%
  (int, int) passingTuple() {
    final maxVal = 10 + random.nextInt(20); 
    final minPass = (maxVal / 2).ceil();
    final current = minPass + random.nextInt(maxVal - minPass + 1); 
    return (current, maxVal);
  }

  // Generates progress strictly < 50%
  (int, int) failingTuple() {
    final maxVal = 10 + random.nextInt(20);
    final limit = (maxVal / 2).floor(); 
    // Ensure current is strictly less than half
    final current = limit == 0 ? 0 : random.nextInt(limit);
    return (current, maxVal);
  }
  
  // Generates random progress
  (int, int) randomTuple() {
    final maxVal = 10 + random.nextInt(20);
    final current = random.nextInt(maxVal + 1);
    return (current, maxVal);
  }

  // Ensure the loop goes far enough to generate the streak-breaking day
  final int effectiveLength = max(length, streakLength + 1);

  for (int i = 0; i < effectiveLength; i++) {
    final DateTime date = now.subtract(Duration(days: i));
    final String dateStr = formatter.format(date);

    if (i < streakLength) {
      // Active streak days: Force all categories to pass
      v[dateStr] = passingTuple();
      c[dateStr] = passingTuple();
      t[dateStr] = passingTuple();
    } 
    else if (i == streakLength) {
      // Cutoff day: Force all categories to fail
      // This guarantees the streak calculation stops exactly here
      v[dateStr] = failingTuple();
      c[dateStr] = failingTuple();
      t[dateStr] = failingTuple();
    } 
    else {
      // History beyond the streak: Random data
      if (random.nextDouble() > 0.4) {
         if (random.nextBool()) v[dateStr] = randomTuple();
         if (random.nextBool()) c[dateStr] = randomTuple();
         if (random.nextBool()) t[dateStr] = randomTuple();
      }
    }
  }

  return (vocab: v, characters: c, time: t);
}