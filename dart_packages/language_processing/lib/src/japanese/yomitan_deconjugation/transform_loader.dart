import 'dart:convert';
import 'dart:io';
import 'package:language_processing/src/japanese/conjugation/yomitan_conjugation_data/japanese_transforms.dart';
import 'package:language_processing/src/japanese/yomitan_deconjugation/language_transforms.dart';

class GrammarLoader {
  
  /// Reads a local JSON file directly from the hard drive, decodes it, 
  /// and passes the resulting map to the parser.
  static LanguageTransformDescriptor loadFromFile(String filePath) {
    final file = File(filePath);
    final jsonString = file.readAsStringSync();
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    
    return loadFromJson(jsonMap);
  }

  /// Parses the decoded JSON map into your native Dart classes.
  static LanguageTransformDescriptor loadFromJson(Map transformsJson) {

    // Helper function to parse i18n lists
    List<I18nInfo> parseI18n(dynamic i18nData) {
      if (i18nData == null) return const [];
      return (i18nData as List).map((item) => I18nInfo(
        language: item['language'] ?? '',
        name: item['name'] ?? '',
        description: item['description'],
      )).toList();
    }

    // 1. Parse Conditions
    final conditions = <String, ConditionInfo>{};
    if (transformsJson['conditions'] != null) {
      (transformsJson['conditions'] as Map<String, dynamic>).forEach((key, value) {
        conditions[key] = ConditionInfo(
          name: value['name'] ?? '',
          i18n: parseI18n(value['i18n']),
          isDictionaryForm: value['isDictionaryForm'] ?? false,
          subConditions: value['subConditions'] != null 
              ? List<String>.from(value['subConditions']) 
              : null,
        );
      });
    }

    // 2. Parse Transforms
    final transforms = <String, Transform>{};
    if (transformsJson['transforms'] != null) {
      (transformsJson['transforms'] as Map<String, dynamic>).forEach((key, transformData) {
        
        final rulesList = <InflectionPattern<String>>[];
        
        if (transformData['rules'] != null) {
          for (final ruleJson in transformData['rules']) {
            final type = ruleJson['type']; 
            final inflected = ruleJson['inflected'];
            final base = ruleJson['base'];
            final conditionsIn = List<String>.from(ruleJson['conditionsIn'] ?? []);
            final conditionsOut = List<String>.from(ruleJson['conditionsOut'] ?? []);

            if (type == 'suffix') {
              rulesList.add(suffixInflection(inflected, base, conditionsIn, conditionsOut));
            } else if (type == 'prefix') {
              rulesList.add(prefixInflection(inflected, base, conditionsIn, conditionsOut));
            } else if (type == 'wholeWord') {
              rulesList.add(wholeWordInflection(inflected, base, conditionsIn, conditionsOut));
            }
          }
        }

        transforms[key] = Transform(
          name: transformData['name'] ?? '',
          description: transformData['description'] ?? '',
          i18n: parseI18n(transformData['i18n']),
          rules: rulesList,
        );
      });
    }

    // 3. Return the fully formed descriptor
    return LanguageTransformDescriptor(
      language: transformsJson['language'] ?? 'ja',
      conditions: conditions,
      transforms: transforms,
    );
  }
}