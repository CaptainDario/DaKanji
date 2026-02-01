import 'dart:convert';

import 'package:language_processing/japanese_processor.dart';
import 'package:language_processing/language_processor_options.dart';
import 'package:language_processing/util/deconjugation_result.dart';





abstract class LanguageProcessor {

  const LanguageProcessor();

  factory LanguageProcessor.fromJson(Map<String, dynamic> json) {
    final String type = json['type'] ?? 'japanese'; // Default or throw error

    switch (type) {
      case 'japanese':
        return JapaneseProcessor.fromJson(json);
      // Add cases for other languages here (e.g., 'chinese')
      default:
        throw UnsupportedError('Unknown LanguageProcessor type: $type');
    }
  }

  factory LanguageProcessor.fromJsonString(String jsonString)
    => LanguageProcessor.fromJson(jsonDecode(jsonString));

  // Concrete implementation relying on the abstract toJson()
  String toJsonString() => jsonEncode(toJson());

  Map<String, dynamic> toJson();

  Future init();

  Future close();

  List<String> normalize(String term, ProcessorOptions options);

  List<String> normalizeAll(List<String> terms, ProcessorOptions options);

  List<DeconjugationResult> deconjugate(String term);

  List<DeconjugationResult> deconjugateAll(List<String> terms);

  /// Segments the given text and returns the segmented string, if 
  /// `segmentation != text` else returns null
  String? segment(String text);

  /// Returns the readings for the given text
  String getReadings(String text);

}