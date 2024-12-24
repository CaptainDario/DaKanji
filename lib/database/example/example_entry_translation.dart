// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
part 'example_entry_translation.freezed.dart';
part 'example_entry_translation.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one kanji entry of the database
class ExampleEntryTranslation with _$ExampleEntryTranslation {

  const factory ExampleEntryTranslation(
    {
      /// The example's translation
      required String translation,
      /// Language code of the language of this translation
      required String languageCode
    }) = _ExampleEntryTranslation;

  factory ExampleEntryTranslation.fromJson(Map<String, Object?> json)
    => _$ExampleEntryTranslationFromJson(json);

}
