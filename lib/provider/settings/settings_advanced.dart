import 'package:flutter/cupertino.dart';

import 'package:universal_io/io.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:da_kanji_mobile/model/inference_backends.dart';

part 'settings_advanced.g.dart';



/// Class to store all settings in the advanced settings
/// 
/// To update the toJson code run `flutter pub run build_runner build`
@JsonSerializable()
class SettingsAdvanced with ChangeNotifier {

  /// The available backends for inference
  @JsonKey(ignore: true)
  List<String> inferenceBackends = [
      InferenceBackends.cpu.name.toString(),
    ];

  /// The default value for `inferenceBackend`
  @JsonKey(ignore: true)
  static const String d_inferenceBackend = "cpu";
  /// The inference backend used for the tf lite interpreter
  @JsonKey(defaultValue: d_inferenceBackend)
  late String _inferenceBackend = d_inferenceBackend;
  /// The inference backend used for the tf lite interpreter
  String get inferenceBackend => _inferenceBackend;
  /// The inference backend used for the tf lite interpreter
  set inferenceBackend(String inferenceBackend) {
    _inferenceBackend = inferenceBackend;
    notifyListeners();
  }

  /// The default value for `useThanosSnap`
  @JsonKey(ignore: true)
  static const bool d_useThanosSnap = false;
  /// use a thanos like snap effect to dissolve the drawing from the screen
  @JsonKey(defaultValue: d_useThanosSnap)
  bool _useThanosSnap = d_useThanosSnap;
  /// use a thanos like snap effect to dissolve the drawing from the screen
  bool get useThanosSnap => _useThanosSnap;
  /// use a thanos like snap effect to dissolve the drawing from the screen
  set useThanosSnap(bool useThanosSnap) {
    _useThanosSnap = useThanosSnap;
    notifyListeners();
  }

  SettingsAdvanced(){
    if(Platform.isAndroid) {
      inferenceBackends.addAll([
        InferenceBackends.gpu.name.toString(),
        InferenceBackends.nnapi.name.toString(),
      ]);
    } else if(Platform.isIOS) {
      inferenceBackends.addAll([
        InferenceBackends.gpu.name.toString(),
        InferenceBackends.coreML.name.toString(),
      ]);
    }
    //else if(Platform.isLinux || Platform.isMacOS || Platform.isWindows)
    //  inferenceBackends.addAll([
    //    InferenceBackends.XXNPACK.toString()
    //  ]);
  }

  /// Instantiates a new instance from a json map
  factory SettingsAdvanced.fromJson(Map<String, dynamic> json) => _$SettingsAdvancedFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsAdvancedToJson(this);
}