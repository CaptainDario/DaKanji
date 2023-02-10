// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData()
  ..appOpenedTimes = json['appOpenedTimes'] as int? ?? 0
  ..doNotShowRateAgain = json['doNotShowRateAgain'] as bool? ?? false
  ..versionUsed = json['versionUsed'] as String? ?? ''
  ..showShowcaseDrawing = json['showShowcaseDrawing'] as bool? ?? true
  ..showShowcaseDictionary = json['showShowcaseDictionary'] as bool? ?? true
  ..showShowcaseText = json['showShowcaseText'] as bool? ?? true
  ..showOnboarding = json['showOnboarding'] as bool? ?? true
  ..showRatePopup = json['showRatePopup'] as bool? ?? false
  ..showChangelog = json['showChangelog'] as bool? ?? false
  ..drawingBackend =
      $enumDecodeNullable(_$InferenceBackendEnumMap, json['drawingBackend']);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'appOpenedTimes': instance.appOpenedTimes,
      'doNotShowRateAgain': instance.doNotShowRateAgain,
      'versionUsed': instance.versionUsed,
      'showShowcaseDrawing': instance.showShowcaseDrawing,
      'showShowcaseDictionary': instance.showShowcaseDictionary,
      'showShowcaseText': instance.showShowcaseText,
      'showOnboarding': instance.showOnboarding,
      'showRatePopup': instance.showRatePopup,
      'showChangelog': instance.showChangelog,
      'drawingBackend': _$InferenceBackendEnumMap[instance.drawingBackend],
    };

const _$InferenceBackendEnumMap = {
  InferenceBackend.CPU: 'CPU',
  InferenceBackend.GPU: 'GPU',
  InferenceBackend.NNApi: 'NNApi',
  InferenceBackend.CoreML2: 'CoreML2',
  InferenceBackend.CoreML3: 'CoreML3',
  InferenceBackend.Metal: 'Metal',
  InferenceBackend.XNNPack: 'XNNPack',
};
