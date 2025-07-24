// Package imports:
import 'package:dakanji_db/database/example/example_entry_translation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
part 'example_entry.freezed.dart';
part 'example_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one example sentence and its translations of the database
abstract class ExampleEntry with _$ExampleEntry {

  const factory ExampleEntry(
    {
      /// The example sentence
      required String example,

      required String tokenizedExample,

      /// The translations of the example
      required List<ExampleEntryTranslation> translations
    }) = _ExampleEntry;

  factory ExampleEntry.fromJson(Map<String, Object?> json)
    => _$ExampleEntryFromJson(json);

}
