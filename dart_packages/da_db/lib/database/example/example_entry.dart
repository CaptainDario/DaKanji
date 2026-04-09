import 'dart:convert';

import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:da_db/database/stats/stat_entry.dart';
import 'package:da_db/database/tag/tag_bank_v3_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'example_audio_entry.dart';

part 'example_entry.freezed.dart';
part 'example_entry.g.dart';

@Freezed()
@JsonSerializable()
class ExampleEntry with _$ExampleEntry {

  @override
  final int id;
  @override
  final IndexEntry indexEntry;
  @override
  final int? groupId;
  @override
  final String sentence;
  @override
  final List<TagBankV3Entry> tags;
  @override
  final List<StatEntry> stats;
  @override
  final List<ExampleAudioEntry> audios;

  ExampleEntry({
    required this.id,
    required this.indexEntry,
    required this.groupId,
    required this.sentence,
    this.tags = const [],
    this.stats = const [],
    this.audios = const [],
  }) {
    // Now you can sort exactly like you did in TermBankV3Entry!
    tags.sort((a, b) => a.compareTo(b));
    stats.sort((a, b) => a.statName.compareTo(b.statName));
    audios.sort((a, b) => a.name.compareTo(b.name));
  }

  factory ExampleEntry.fromJson(Map<String, dynamic> json) =>
      _$ExampleEntryFromJson(json);

  factory ExampleEntry.fromViewData(ExampleEntryViewData r) {
    
    final List<dynamic> rawTags = jsonDecode(r.tagsJson);
    final List<dynamic> rawStats = jsonDecode(r.statsJson);
    final List<dynamic> rawAudios = jsonDecode(r.audiosJson);

    return ExampleEntry(
      id: r.id,
      indexEntry: IndexEntry.fromJson(jsonDecode(r.index)),
      groupId: r.groupId,
      sentence: r.exampleSentence,
      tags: rawTags
        .map((t) => TagBankV3Entry.fromJson(t as Map<String, dynamic>))
        .toList(),
      stats: rawStats
        .map((s) => StatEntry.fromJson(s as Map<String, dynamic>))
        .toList(),
      audios: rawAudios
        .map((a) => ExampleAudioEntry.fromJson(a as Map<String, dynamic>))
        .toList(),
    );
  }
}