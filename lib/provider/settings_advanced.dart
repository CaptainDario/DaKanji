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
  List<String> inferenceBackends= [
      InferenceBackends.cpu.name.toString(),
    ];

  /// The inference backend used for the tf lite interpreter
  late String inferenceBackend;

  /// use a thanos like snap effect to dissolve the drawing from the screen
  bool useThanosSnap = false;

  SettingsAdvanced(){
    if(Platform.isAndroid) {
      inferenceBackends.addAll([
        InferenceBackends.gpu.toString(),
        InferenceBackends.nnapi.toString(),
      ]);
    } else if(Platform.isIOS) {
      inferenceBackends.addAll([
        InferenceBackends.gpu.toString(),
        InferenceBackends.coreML.toString(),
      ]);
    }
    //else if(Platform.isLinux || Platform.isMacOS || Platform.isWindows)
    //  inferenceBackends.addAll([
    //    InferenceBackends.XXNPACK.toString()
    //  ]);

    inferenceBackend = "";
  }

  /// Instantiates a new instance from a json map
  factory SettingsAdvanced.fromJson(Map<String, dynamic> json) => _$SettingsAdvancedFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsAdvancedToJson(this);
}