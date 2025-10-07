// Package imports:
import 'dart:convert';

import '/database/dakanji_db.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import '/database/kanji/kanji_bank_v3_entry_stat.dart';
import '/database/tag/tag_bank_v3_entry.dart';

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
  /// The id of the dictionary this entry belongs to
  final int indexId;
  @override
  /// The onyomi readings of this entry (sorted lexicographically)
  List<String> onyomis;
  @override
  /// The kunyomi readings of this entry (sorted lexicographically)
  List<String> kunyomis;
  @override
  /// The tags of this entry (sorted lexicographically by name)
  List<TagBankV3Entry> tags;
  @override
  /// The definition of this entry
  List<String> definitions;
  @override
  /// The stats of this entry
  List<KanjiBankV3EntryStat> stats;

  KanjiBankV3Entry(
    {
      required this.kanji,
      required this.indexId,
      required this.onyomis,
      required this.kunyomis,
      required this.tags,
      required this.definitions,
      required this.stats,
    }){
      tags.sort((a, b) => a.sortingOrder.compareTo(b.sortingOrder));
      stats.sort((a, b) {
        if (a.name != b.name) return a.name.compareTo(b.name);
        else return a.value.compareTo(b.value);
      });
    }

  factory KanjiBankV3Entry.fromKanjiDictionarySearchViewData(KanjiDictionarySearchViewData r){
    return KanjiBankV3Entry._fromData(r);
  }

  factory KanjiBankV3Entry.fromKanjiBankV3EntryViewData(KanjiBankV3EntryViewData r){
    return KanjiBankV3Entry._fromData(r);
  }

  factory KanjiBankV3Entry._fromData(dynamic r){
    return KanjiBankV3Entry(
      kanji: r.kanji,
      indexId: r.indexId,
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
