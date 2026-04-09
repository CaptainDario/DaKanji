import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:language_processing/language_processing.dart';

class Iso6393Converter implements JsonConverter<Iso639_3?, String?> {
  const Iso6393Converter();

  @override
  Iso639_3? fromJson(String? json) {
    if (json == null || json.trim().isEmpty) return null;
    return parseToIso(json.trim()).iso3; 
  }

  @override
  String? toJson(Iso639_3? object) {
    return object?.name;
  }
}