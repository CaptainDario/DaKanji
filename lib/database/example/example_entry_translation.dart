// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
part 'example_entry_translation.freezed.dart';
part 'example_entry_translation.g.dart';



@Freezed()
@JsonSerializable()
/// Class representing one kanji entry of the database
class ExampleEntryTranslation with _$ExampleEntryTranslation {


  /// The example's translation
  @override
  final String translation;
  /// Language code of the language of this translation
  @override
  final String languageCode;

  ExampleEntryTranslation({
    required this.translation,
    required this.languageCode
  });

  factory ExampleEntryTranslation.fromJson(Map<String, Object?> json)
    => _$ExampleEntryTranslationFromJson(json);

  Map<String, Object?> toJson() => _$ExampleEntryTranslationToJson(this);

}
