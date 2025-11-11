
import 'dart:convert';

import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/database/dakanji_db.dart';
import '/database/example/example_entry_translation.dart';

part 'example_entry.freezed.dart';
part 'example_entry.g.dart';



@Freezed()
@JsonSerializable()
/// Class representing one example sentence and its translations of the database
class ExampleEntry with _$ExampleEntry {

  /// The id of this entry in the example table
  @override
  int id;

  /// The id of the dictionary this entry belongs to
  @override
  final IndexEntry indexEntry;

  /// The example sentence
  @override
  final String example;

  /// The translations of the example
  @override
  final List<ExampleEntryTranslation> translations;

  ExampleEntry({
    required this.id,
    required this.indexEntry,
    required this.example,
    required this.translations,
  }) {
    translations.sort((a, b) => a.languageCode.compareTo(b.languageCode));
  }

  factory ExampleEntry.fromJson(dynamic json)
    => _$ExampleEntryFromJson(json);

  factory ExampleEntry.fromExampleFtsSearchSql(ExampleFtsSearchDriftResult r){

    return ExampleEntry(
      id: r.id,
      indexEntry: IndexEntry.fromJson(jsonDecode(r.indexEntry)),
      example: r.exampleSentence,
      translations: List.from(jsonDecode(r.translations)).map((e) => 
        ExampleEntryTranslation.fromJson(e)  
      ).toList()
    );
  }

  Map<String, Object?> toJson() => _$ExampleEntryToJson(this);

}
