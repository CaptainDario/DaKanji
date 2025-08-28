// Package imports:
import 'dart:convert';

import 'package:dakanji_db/database/kanji/kanji_bank_v3_dao.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:dakanji_db/database/kanji/kanji_bank_v3_entry_stat.dart';
import 'package:dakanji_db/database/tag/tag_bank_v3_entry.dart';

part 'kanji_bank_v3_entry.freezed.dart';
part 'kanji_bank_v3_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
@JsonSerializable()
/// Class representing one kanji entry of the database
class KanjiBankV3Entry with _$KanjiBankV3Entry {

  @override
  /// The kanji character of this entry
  String kanji;
  @override
  /// The onyomi readings of this entry
  List<String>? onyomis;
  @override
  /// The kunyomi readings of this entry
  List<String>? kunyomis;
  @override
  /// The tags of this entry
  List<TagBankV3Entry>? tags;
  @override
  /// The definition of this entry
  List<String>? definitions;
  @override
  /// The stats of this entry
  List<KanjiBankV3EntryStat>? stats;

  KanjiBankV3Entry(
    {
      required this.kanji,
      required this.onyomis,
      required this.kunyomis,
      required this.tags,
      required this.definitions,
      required this.stats,
    }){
      onyomis?.sort();
      kunyomis?.sort();
      tags?.sort((a, b) => a.name.compareTo(b.name));
      definitions?.sort();
      stats?.sort((a, b) => a.name.compareTo(b.name));
    }


  factory KanjiBankV3Entry.fromKanjiBankV3SearchResult(KanjiBankV3SearchResult r){
    return KanjiBankV3Entry(
      kanji: r.kanji ?? "",
      onyomis: List<String>.from(jsonDecode(r.onyomis)),
      kunyomis: List<String>.from(jsonDecode(r.kunyomis)),
      tags: List.from(jsonDecode(r.tags))
        .map((e) => TagBankV3Entry.fromJson(e))
        .toList(),
      definitions: List<String>.from(jsonDecode(r.definitions)),
      stats: List.from(jsonDecode(r.stats))
        .map((e) => KanjiBankV3EntryStat.fromJson(e))
        .toList(),
    );
  }

  factory KanjiBankV3Entry.fromJson(Map<String, Object?> json)
    => _$KanjiBankV3EntryFromJson(json);

  Map<String, Object?> toJson() => _$KanjiBankV3EntryToJson(this);

}
