import 'package:freezed_annotation/freezed_annotation.dart';

part 'kanji_bank_entry_stat.freezed.dart';
part 'kanji_bank_entry_stat.g.dart';



@Freezed()
/// Class representing one stat of a kanji entry of DaKanjiDB
class KanjiBankEntryStat with _$KanjiBankEntryStat {

  const factory KanjiBankEntryStat(
    {

      /// The name of this stat
      required String name,
      /// The value of this stat
      required String value,

    }) = _KanjiBankEntryStat;

  factory KanjiBankEntryStat.fromJson(Map<String, Object?> json)
    => _$KanjiBankEntryStatFromJson(json);

}