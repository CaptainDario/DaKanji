// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData()
  ..appOpenedTimes = json['appOpenedTimes'] as int? ?? 0
  ..newInstall = json['newInstall'] as bool? ?? true
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
  ..showTutorialKanjiMap = json['showTutorialKanjiMap'] as bool? ?? true
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
      'newInstall': instance.newInstall,
      'doNotShowRateAgain': instance.doNotShowRateAgain,
      'versionUsed': instance.versionUsed,
      'userRefusedUpdate': instance.userRefusedUpdate?.toIso8601String(),
      'showTutorialDrawing': instance.showTutorialDrawing,
      'showTutorialDictionary': instance.showTutorialDictionary,
      'showTutorialText': instance.showTutorialText,
      'showTutorialDojg': instance.showTutorialDojg,
      'showTutorialClipboard': instance.showTutorialClipboard,
      'showTutorialKanjiTable': instance.showTutorialKanjiTable,
      'showTutorialKanjiMap': instance.showTutorialKanjiMap,
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
  InferenceBackend.cpu: 'cpu',
  InferenceBackend.cpu_1: 'cpu_1',
  InferenceBackend.cpu_2: 'cpu_2',
  InferenceBackend.cpu_3: 'cpu_3',
  InferenceBackend.cpu_4: 'cpu_4',
  InferenceBackend.cpu_5: 'cpu_5',
  InferenceBackend.cpu_6: 'cpu_6',
  InferenceBackend.cpu_7: 'cpu_7',
  InferenceBackend.cpu_8: 'cpu_8',
  InferenceBackend.cpu_9: 'cpu_9',
  InferenceBackend.cpu_10: 'cpu_10',
  InferenceBackend.cpu_11: 'cpu_11',
  InferenceBackend.cpu_12: 'cpu_12',
  InferenceBackend.cpu_13: 'cpu_13',
  InferenceBackend.cpu_14: 'cpu_14',
  InferenceBackend.cpu_15: 'cpu_15',
  InferenceBackend.cpu_16: 'cpu_16',
  InferenceBackend.cpu_17: 'cpu_17',
  InferenceBackend.cpu_18: 'cpu_18',
  InferenceBackend.cpu_19: 'cpu_19',
  InferenceBackend.cpu_20: 'cpu_20',
  InferenceBackend.cpu_21: 'cpu_21',
  InferenceBackend.cpu_22: 'cpu_22',
  InferenceBackend.cpu_23: 'cpu_23',
  InferenceBackend.cpu_24: 'cpu_24',
  InferenceBackend.cpu_25: 'cpu_25',
  InferenceBackend.cpu_26: 'cpu_26',
  InferenceBackend.cpu_27: 'cpu_27',
  InferenceBackend.cpu_28: 'cpu_28',
  InferenceBackend.cpu_29: 'cpu_29',
  InferenceBackend.cpu_30: 'cpu_30',
  InferenceBackend.cpu_31: 'cpu_31',
  InferenceBackend.cpu_32: 'cpu_32',
  InferenceBackend.gpu: 'gpu',
  InferenceBackend.nnapi: 'nnapi',
  InferenceBackend.coreMl_2: 'coreMl_2',
  InferenceBackend.coreMl_3: 'coreMl_3',
  InferenceBackend.metal: 'metal',
  InferenceBackend.xnnPack: 'xnnPack',
  InferenceBackend.xnnPack_1: 'xnnPack_1',
  InferenceBackend.xnnPack_2: 'xnnPack_2',
  InferenceBackend.xnnPack_3: 'xnnPack_3',
  InferenceBackend.xnnPack_4: 'xnnPack_4',
  InferenceBackend.xnnPack_5: 'xnnPack_5',
  InferenceBackend.xnnPack_6: 'xnnPack_6',
  InferenceBackend.xnnPack_7: 'xnnPack_7',
  InferenceBackend.xnnPack_8: 'xnnPack_8',
  InferenceBackend.xnnPack_9: 'xnnPack_9',
  InferenceBackend.xnnPack_10: 'xnnPack_10',
  InferenceBackend.xnnPack_11: 'xnnPack_11',
  InferenceBackend.xnnPack_12: 'xnnPack_12',
  InferenceBackend.xnnPack_13: 'xnnPack_13',
  InferenceBackend.xnnPack_14: 'xnnPack_14',
  InferenceBackend.xnnPack_15: 'xnnPack_15',
  InferenceBackend.xnnPack_16: 'xnnPack_16',
  InferenceBackend.xnnPack_17: 'xnnPack_17',
  InferenceBackend.xnnPack_18: 'xnnPack_18',
  InferenceBackend.xnnPack_19: 'xnnPack_19',
  InferenceBackend.xnnPack_20: 'xnnPack_20',
  InferenceBackend.xnnPack_21: 'xnnPack_21',
  InferenceBackend.xnnPack_22: 'xnnPack_22',
  InferenceBackend.xnnPack_23: 'xnnPack_23',
  InferenceBackend.xnnPack_24: 'xnnPack_24',
  InferenceBackend.xnnPack_25: 'xnnPack_25',
  InferenceBackend.xnnPack_26: 'xnnPack_26',
  InferenceBackend.xnnPack_27: 'xnnPack_27',
  InferenceBackend.xnnPack_28: 'xnnPack_28',
  InferenceBackend.xnnPack_29: 'xnnPack_29',
  InferenceBackend.xnnPack_30: 'xnnPack_30',
  InferenceBackend.xnnPack_31: 'xnnPack_31',
  InferenceBackend.xnnPack_32: 'xnnPack_32',
};
