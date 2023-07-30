// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData()
  ..appOpenedTimes = json['appOpenedTimes'] as int? ?? 0
  ..doNotShowRateAgain = json['doNotShowRateAgain'] as bool? ?? false
  ..versionUsed =
      json['versionUsed'] == null ? null : Version.fromJson(json['versionUsed'])
  ..userRefusedUpdate = json['userRefusedUpdate'] == null
      ? null
      : DateTime.parse(json['userRefusedUpdate'] as String)
  ..showTutorialDrawing = json['showTutorialDrawing'] as bool? ?? true
  ..showTutorialDictionary = json['showTutorialDictionary'] as bool? ?? true
  ..showTutorialText = json['showTutorialText'] as bool? ?? true
  ..showTutorialClipboard = json['showTutorialClipboard'] as bool? ?? true
  ..showTutorialKanjiTable = json['showTutorialKanjiTable'] as bool? ?? true
  ..showOnboarding = json['showOnboarding'] as bool? ?? true
  ..showRateDialog = json['showRateDialog'] as bool? ?? false
  ..showChangelog = json['showChangelog'] as bool? ?? false
  ..drawingBackend =
      $enumDecodeNullable(_$InferenceBackendEnumMap, json['drawingBackend']);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'appOpenedTimes': instance.appOpenedTimes,
      'doNotShowRateAgain': instance.doNotShowRateAgain,
      'versionUsed': instance.versionUsed,
      'userRefusedUpdate': instance.userRefusedUpdate?.toIso8601String(),
      'showTutorialDrawing': instance.showTutorialDrawing,
      'showTutorialDictionary': instance.showTutorialDictionary,
      'showTutorialText': instance.showTutorialText,
      'showTutorialClipboard': instance.showTutorialClipboard,
      'showTutorialKanjiTable': instance.showTutorialKanjiTable,
      'showOnboarding': instance.showOnboarding,
      'showRateDialog': instance.showRateDialog,
      'showChangelog': instance.showChangelog,
      'drawingBackend': _$InferenceBackendEnumMap[instance.drawingBackend],
    };

const _$InferenceBackendEnumMap = {
  InferenceBackend.CPU: 'CPU',
  InferenceBackend.CPU_1: 'CPU_1',
  InferenceBackend.CPU_2: 'CPU_2',
  InferenceBackend.CPU_3: 'CPU_3',
  InferenceBackend.CPU_4: 'CPU_4',
  InferenceBackend.CPU_5: 'CPU_5',
  InferenceBackend.CPU_6: 'CPU_6',
  InferenceBackend.CPU_7: 'CPU_7',
  InferenceBackend.CPU_8: 'CPU_8',
  InferenceBackend.CPU_9: 'CPU_9',
  InferenceBackend.CPU_10: 'CPU_10',
  InferenceBackend.CPU_11: 'CPU_11',
  InferenceBackend.CPU_12: 'CPU_12',
  InferenceBackend.CPU_13: 'CPU_13',
  InferenceBackend.CPU_14: 'CPU_14',
  InferenceBackend.CPU_15: 'CPU_15',
  InferenceBackend.CPU_16: 'CPU_16',
  InferenceBackend.CPU_17: 'CPU_17',
  InferenceBackend.CPU_18: 'CPU_18',
  InferenceBackend.CPU_19: 'CPU_19',
  InferenceBackend.CPU_20: 'CPU_20',
  InferenceBackend.CPU_21: 'CPU_21',
  InferenceBackend.CPU_22: 'CPU_22',
  InferenceBackend.CPU_23: 'CPU_23',
  InferenceBackend.CPU_24: 'CPU_24',
  InferenceBackend.CPU_25: 'CPU_25',
  InferenceBackend.CPU_26: 'CPU_26',
  InferenceBackend.CPU_27: 'CPU_27',
  InferenceBackend.CPU_28: 'CPU_28',
  InferenceBackend.CPU_29: 'CPU_29',
  InferenceBackend.CPU_30: 'CPU_30',
  InferenceBackend.CPU_31: 'CPU_31',
  InferenceBackend.CPU_32: 'CPU_32',
  InferenceBackend.GPU: 'GPU',
  InferenceBackend.NNApi: 'NNApi',
  InferenceBackend.CoreML2: 'CoreML2',
  InferenceBackend.CoreML3: 'CoreML3',
  InferenceBackend.Metal: 'Metal',
  InferenceBackend.XNNPack: 'XNNPack',
  InferenceBackend.XNNPack_1: 'XNNPack_1',
  InferenceBackend.XNNPack_2: 'XNNPack_2',
  InferenceBackend.XNNPack_3: 'XNNPack_3',
  InferenceBackend.XNNPack_4: 'XNNPack_4',
  InferenceBackend.XNNPack_5: 'XNNPack_5',
  InferenceBackend.XNNPack_6: 'XNNPack_6',
  InferenceBackend.XNNPack_7: 'XNNPack_7',
  InferenceBackend.XNNPack_8: 'XNNPack_8',
  InferenceBackend.XNNPack_9: 'XNNPack_9',
  InferenceBackend.XNNPack_10: 'XNNPack_10',
  InferenceBackend.XNNPack_11: 'XNNPack_11',
  InferenceBackend.XNNPack_12: 'XNNPack_12',
  InferenceBackend.XNNPack_13: 'XNNPack_13',
  InferenceBackend.XNNPack_14: 'XNNPack_14',
  InferenceBackend.XNNPack_15: 'XNNPack_15',
  InferenceBackend.XNNPack_16: 'XNNPack_16',
  InferenceBackend.XNNPack_17: 'XNNPack_17',
  InferenceBackend.XNNPack_18: 'XNNPack_18',
  InferenceBackend.XNNPack_19: 'XNNPack_19',
  InferenceBackend.XNNPack_20: 'XNNPack_20',
  InferenceBackend.XNNPack_21: 'XNNPack_21',
  InferenceBackend.XNNPack_22: 'XNNPack_22',
  InferenceBackend.XNNPack_23: 'XNNPack_23',
  InferenceBackend.XNNPack_24: 'XNNPack_24',
  InferenceBackend.XNNPack_25: 'XNNPack_25',
  InferenceBackend.XNNPack_26: 'XNNPack_26',
  InferenceBackend.XNNPack_27: 'XNNPack_27',
  InferenceBackend.XNNPack_28: 'XNNPack_28',
  InferenceBackend.XNNPack_29: 'XNNPack_29',
  InferenceBackend.XNNPack_30: 'XNNPack_30',
  InferenceBackend.XNNPack_31: 'XNNPack_31',
  InferenceBackend.XNNPack_32: 'XNNPack_32',
};
