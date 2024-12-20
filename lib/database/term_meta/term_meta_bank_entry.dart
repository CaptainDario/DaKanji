// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'term_meta_bank_entry.freezed.dart';
part 'term_meta_bank_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one term meta entry of the database
class TermMetaBankV3Entry with _$TermMetaBankV3Entry {

  const factory TermMetaBankV3Entry(
    {
      /// The term of this entry
      required String term,
      /// The type of this entry
      required String type,
      /// the numeric value of this entry
      int? value,
      /// The display value of this entry
      String? displayValue,
    }) = _TermMetaBankV3Entry;

  factory TermMetaBankV3Entry.fromJson(Map<String, Object?> json)
    => _$TermMetaBankV3EntryFromJson(json);

}
