// Package imports:
import 'package:dakanji_db/database/dakanji_db.dart';
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

      /// The translations of the example
      required List<ExampleEntryTranslation> translations,
    }) = _ExampleEntry;

  factory ExampleEntry.fromJson(Map<String, Object?> json)
    => _$ExampleEntryFromJson(json);

  factory ExampleEntry.fromExampleFtsSearchSql(ExampleFtsSearchSqlResult r){

    // get all translations
    List<ExampleEntryTranslation> translations = [];
    List<String> trans = r.translations?.split("|||").toList() ?? [];
    List<String> codes = r.languageCodes?.split("|||").toList() ?? [];
    for (var i = 0; i < trans.length; i++) {
      translations.add(ExampleEntryTranslation(
        translation: trans[i],
        languageCode: codes[i]
      ));
    }

    return ExampleEntry(
      example: r.exampleSentence,
      translations: translations,
    );
  }

}
