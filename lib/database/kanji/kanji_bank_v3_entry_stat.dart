// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kanji_bank_v3_entry_stat.freezed.dart';
part 'kanji_bank_v3_entry_stat.g.dart';



@Freezed()
/// Class representing one stat of a kanji entry of DaKanjiDB
abstract class KanjiBankV3EntryStat with _$KanjiBankV3EntryStat {

  const factory KanjiBankV3EntryStat(
    {

      /// The name of this stat
      required String name,
      /// The value of this stat
      required String value,

    }) = _KanjiBankV3EntryStat;

  factory KanjiBankV3EntryStat.fromJson(Map<String, Object?> json)
    => _$KanjiBankV3EntryStatFromJson(json);

}
