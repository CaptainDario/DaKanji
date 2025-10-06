// Package imports:
import 'dart:convert';

import '/database/dakanji_db.dart';
import '/database/example/example_entry_translation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
part 'example_entry.freezed.dart';
part 'example_entry.g.dart';



@Freezed()
@JsonSerializable()
/// Class representing one example sentence and its translations of the database
class ExampleEntry with _$ExampleEntry {

  /// The example sentence
  @override
  final String example;

  /// The id of the dictionary this entry belongs to
  final int indexId;

  /// The translations of the example
  @override
  final List<ExampleEntryTranslation> translations;

  ExampleEntry({
    required this.example,
    required this.translations,
    required this.indexId
  }) {
    translations.sort((a, b) => a.languageCode.compareTo(b.languageCode));
  }

  factory ExampleEntry.fromJson(dynamic json)
    => _$ExampleEntryFromJson(json);

  factory ExampleEntry.fromExampleFtsSearchSql(ExampleFtsSearchDriftResult r){

    return ExampleEntry(
      indexId: r.indexId,
      example: r.exampleSentence,
      translations: List.from(jsonDecode(r.translations)).map((e) => 
        ExampleEntryTranslation.fromJson(e)  
      ).toList()
    );
  }

  Map<String, Object?> toJson() => _$ExampleEntryToJson(this);

}
