// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_word_lists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsWordLists _$SettingsWordListsFromJson(Map<String, dynamic> json) =>
    SettingsWordLists()
      ..showWordFruequency = json['showWordFruequency'] as bool? ?? false
      ..includedLanguages = (json['includedLanguages'] as List<dynamic>)
          .map((e) => e as bool)
          .toList()
      ..pdfMaxMeaningsPerVocabulary =
          (json['pdfMaxMeaningsPerVocabulary'] as num).toInt()
      ..pdfMaxWordsPerMeaning = (json['pdfMaxWordsPerMeaning'] as num).toInt()
      ..pdfMaxLinesPerMeaning = (json['pdfMaxLinesPerMeaning'] as num).toInt()
      ..pdfIncludeKana = json['pdfIncludeKana'] as bool
      ..autoStartScreensaver = json['autoStartScreensaver'] as bool
      ..screenSaverWordLists = (json['screenSaverWordLists'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList()
      ..screenSaverSecondsToStart =
          (json['screenSaverSecondsToStart'] as num).toInt()
      ..screenSaverSecondsToNextCard =
          (json['screenSaverSecondsToNextCard'] as num).toInt();

Map<String, dynamic> _$SettingsWordListsToJson(SettingsWordLists instance) =>
    <String, dynamic>{
      'showWordFruequency': instance.showWordFruequency,
      'includedLanguages': instance.includedLanguages,
      'pdfMaxMeaningsPerVocabulary': instance.pdfMaxMeaningsPerVocabulary,
      'pdfMaxWordsPerMeaning': instance.pdfMaxWordsPerMeaning,
      'pdfMaxLinesPerMeaning': instance.pdfMaxLinesPerMeaning,
      'pdfIncludeKana': instance.pdfIncludeKana,
      'autoStartScreensaver': instance.autoStartScreensaver,
      'screenSaverWordLists': instance.screenSaverWordLists,
      'screenSaverSecondsToStart': instance.screenSaverSecondsToStart,
      'screenSaverSecondsToNextCard': instance.screenSaverSecondsToNextCard,
    };
