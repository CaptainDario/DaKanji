import 'package:da_db/database/stats/stat_entry.dart';
import 'package:da_db/database/tag/tag_bank_v3_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_audio_entry.freezed.dart';
part 'example_audio_entry.g.dart';

@Freezed()
@JsonSerializable()
class ExampleAudioEntry with _$ExampleAudioEntry {
  
  @override
  final int id;
  @override
  final String path;
  @override
  final String name;
  @override
  final List<TagBankV3Entry> tags;
  @override
  final List<StatEntry> stats;

  ExampleAudioEntry({
    required this.id,
    required this.path,
    required this.name,
    this.tags = const [],
    this.stats = const [],
  }) {
    // Sort tags using your TagBankV3Entry compareTo logic
    tags.sort((a, b) => a.compareTo(b));
    
    // Sort stats alphabetically by their name
    stats.sort((a, b) => a.statName.compareTo(b.statName));
  }

  factory ExampleAudioEntry.fromJson(Map<String, dynamic> json) =>
      _$ExampleAudioEntryFromJson(json);
      
  Map<String, Object?> toJson() => _$ExampleAudioEntryToJson(this);
}