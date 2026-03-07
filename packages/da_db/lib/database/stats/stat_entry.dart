import 'package:freezed_annotation/freezed_annotation.dart';

part 'stat_entry.freezed.dart';
part 'stat_entry.g.dart';

@freezed
abstract class StatEntry with _$StatEntry {

  const factory StatEntry({
    required int id,
    required String statName,
    String? displayName,
    required double value,
    String? displayValue,
  }) = _StatEntry;

  factory StatEntry.fromJson(Map<String, dynamic> json) =>
      _$StatEntryFromJson(json);
}