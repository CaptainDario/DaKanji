import 'dart:ui';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';



class StudySessionUiModel {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final Duration totalWorkDuration;
  final Duration totalBreakDuration;
  final String category;
  final String? tag;
  final Color color;
  final List<TimeTrackingUnitTableData> units;

  StudySessionUiModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.totalWorkDuration,
    required this.totalBreakDuration,
    required this.category,
    required this.tag,
    required this.color,
    required this.units,
  });
}