
import 'dart:convert';

import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:da_db/database/kanji/kanji_bank_v3_entry_stat.dart';
import 'package:da_db/database/tag/tag_bank_v3_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kanji_bank_v3_entry.freezed.dart';
part 'kanji_bank_v3_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
@JsonSerializable()
/// Class representing one kanji entry of the database
class KanjiBankV3Entry with _$KanjiBankV3Entry {

  @override
  int id;
  @override
  /// The kanji character of this entry
  String kanji;
  @override
  /// The id of the dictionary this entry belongs to
  final IndexEntry indexEntry;
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
      required this.id,
      required this.kanji,
      required this.indexEntry,
      required this.onyomis,
      required this.kunyomis,
      required this.tags,
      required this.definitions,
      required this.stats,
    }){
      tags.sort((a, b) => a.compareTo(b));
      stats.sort((a, b) {
        if (a.tag.name != b.tag.name) return a.tag.name.compareTo(b.tag.name);
        else return a.value.compareTo(b.value);
      });
    }

  factory KanjiBankV3Entry.fromKanjiDictionarySearchViewData(KanjiDictionaryFindKanjiDetailsDriftResult r){
    return KanjiBankV3Entry._fromData(r);
  }

  factory KanjiBankV3Entry.fromKanjiBankV3EntryViewData(KanjiBankV3EntryViewData r){
    return KanjiBankV3Entry._fromData(r);
  }

  factory KanjiBankV3Entry._fromData(dynamic r){
    return KanjiBankV3Entry(
      id: r.id,
      kanji: r.kanji,
      indexEntry: IndexEntry.fromJson(jsonDecode(r.indexEntry)),
      onyomis: List<String?>.from(jsonDecode(r.onyomis)).nonNulls.toList(),
      kunyomis: List<String?>.from(jsonDecode(r.kunyomis)).nonNulls.toList(),
      tags: List.from(jsonDecode(r.tags))
        .map((e) => TagBankV3Entry.fromJson(e))
        .nonNulls.toList(),
      definitions: List<String>.from(jsonDecode(r.definitions))
        .nonNulls.toList(),
      stats: List.from(jsonDecode(r.stats))
        .map((e) => KanjiBankV3EntryStat.fromJson(e))
        .nonNulls.toList(),
    );
  }

  factory KanjiBankV3Entry.fromJson(Map<String, Object?> json)
    => _$KanjiBankV3EntryFromJson(json);

  Map<String, Object?> toJson() => _$KanjiBankV3EntryToJson(this);

}
