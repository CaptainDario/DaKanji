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
  ..showTutorialDojg = json['showTutorialDojg'] as bool? ?? true
  ..showTutorialClipboard = json['showTutorialClipboard'] as bool? ?? true
  ..showTutorialKanjiTable = json['showTutorialKanjiTable'] as bool? ?? true
  ..showTutorialKanaTable = json['showTutorialKanaTable'] as bool? ?? true
  ..showTutorialWordLists = json['showTutorialWordLists'] as bool? ?? true
  ..showOnboarding = json['showOnboarding'] as bool? ?? true
  ..showRateDialog = json['showRateDialog'] as bool? ?? false
  ..showChangelog = json['showChangelog'] as bool? ?? false
  ..dojgImported = json['dojgImported'] as bool? ?? false
  ..dojgWithMediaImported = json['dojgWithMediaImported'] as bool? ?? false
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
      'showTutorialDojg': instance.showTutorialDojg,
      'showTutorialClipboard': instance.showTutorialClipboard,
      'showTutorialKanjiTable': instance.showTutorialKanjiTable,
      'showTutorialKanaTable': instance.showTutorialKanaTable,
      'showTutorialWordLists': instance.showTutorialWordLists,
      'showOnboarding': instance.showOnboarding,
      'showRateDialog': instance.showRateDialog,
      'showChangelog': instance.showChangelog,
      'dojgImported': instance.dojgImported,
      'dojgWithMediaImported': instance.dojgWithMediaImported,
      'drawingBackend': _$InferenceBackendEnumMap[instance.drawingBackend],
    };

const _$InferenceBackendEnumMap = {
  InferenceBackend.cpu: 'CPU',
  InferenceBackend.cpu_1: 'CPU_1',
  InferenceBackend.cpu_2: 'CPU_2',
  InferenceBackend.cpu_3: 'CPU_3',
  InferenceBackend.cpu_4: 'CPU_4',
  InferenceBackend.cpu_5: 'CPU_5',
  InferenceBackend.cpu_6: 'CPU_6',
  InferenceBackend.cpu_7: 'CPU_7',
  InferenceBackend.cpu_8: 'CPU_8',
  InferenceBackend.cpu_9: 'CPU_9',
  InferenceBackend.cpu_10: 'CPU_10',
  InferenceBackend.cpu_11: 'CPU_11',
  InferenceBackend.cpu_12: 'CPU_12',
  InferenceBackend.cpu_13: 'CPU_13',
  InferenceBackend.cpu_14: 'CPU_14',
  InferenceBackend.cpu_15: 'CPU_15',
  InferenceBackend.cpu_16: 'CPU_16',
  InferenceBackend.cpu_17: 'CPU_17',
  InferenceBackend.cpu_18: 'CPU_18',
  InferenceBackend.cpu_19: 'CPU_19',
  InferenceBackend.cpu_20: 'CPU_20',
  InferenceBackend.cpu_21: 'CPU_21',
  InferenceBackend.cpu_22: 'CPU_22',
  InferenceBackend.cpu_23: 'CPU_23',
  InferenceBackend.cpu_24: 'CPU_24',
  InferenceBackend.cpu_25: 'CPU_25',
  InferenceBackend.cpu_26: 'CPU_26',
  InferenceBackend.cpu_27: 'CPU_27',
  InferenceBackend.cpu_28: 'CPU_28',
  InferenceBackend.cpu_29: 'CPU_29',
  InferenceBackend.cpu_30: 'CPU_30',
  InferenceBackend.cpu_31: 'CPU_31',
  InferenceBackend.cpu_32: 'CPU_32',
  InferenceBackend.gpu: 'GPU',
  InferenceBackend.nnapi: 'NNApi',
  InferenceBackend.coreMl_2: 'CoreML2',
  InferenceBackend.coreMl_3: 'CoreML3',
  InferenceBackend.metal: 'Metal',
  InferenceBackend.xnnPack: 'XNNPack',
  InferenceBackend.xnnPack_1: 'XNNPack_1',
  InferenceBackend.xnnPack_2: 'XNNPack_2',
  InferenceBackend.xnnPack_3: 'XNNPack_3',
  InferenceBackend.xnnPack_4: 'XNNPack_4',
  InferenceBackend.xnnPack_5: 'XNNPack_5',
  InferenceBackend.xnnPack_6: 'XNNPack_6',
  InferenceBackend.xnnPack_7: 'XNNPack_7',
  InferenceBackend.xnnPack_8: 'XNNPack_8',
  InferenceBackend.xnnPack_9: 'XNNPack_9',
  InferenceBackend.xnnPack_10: 'XNNPack_10',
  InferenceBackend.xnnPack_11: 'XNNPack_11',
  InferenceBackend.xnnPack_12: 'XNNPack_12',
  InferenceBackend.xnnPack_13: 'XNNPack_13',
  InferenceBackend.xnnPack_14: 'XNNPack_14',
  InferenceBackend.xnnPack_15: 'XNNPack_15',
  InferenceBackend.xnnPack_16: 'XNNPack_16',
  InferenceBackend.xnnPack_17: 'XNNPack_17',
  InferenceBackend.xnnPack_18: 'XNNPack_18',
  InferenceBackend.xnnPack_19: 'XNNPack_19',
  InferenceBackend.xnnPack_20: 'XNNPack_20',
  InferenceBackend.xnnPack_21: 'XNNPack_21',
  InferenceBackend.xnnPack_22: 'XNNPack_22',
  InferenceBackend.xnnPack_23: 'XNNPack_23',
  InferenceBackend.xnnPack_24: 'XNNPack_24',
  InferenceBackend.xnnPack_25: 'XNNPack_25',
  InferenceBackend.xnnPack_26: 'XNNPack_26',
  InferenceBackend.xnnPack_27: 'XNNPack_27',
  InferenceBackend.xnnPack_28: 'XNNPack_28',
  InferenceBackend.xnnPack_29: 'XNNPack_29',
  InferenceBackend.xnnPack_30: 'XNNPack_30',
  InferenceBackend.xnnPack_31: 'XNNPack_31',
  InferenceBackend.xnnPack_32: 'XNNPack_32',
};
