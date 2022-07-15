import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:da_kanji_mobile/model/InferenceBackends.dart';


/// Class to store all settings in the advanced settings 
class SettingsAdvanced {

  /// The available backends for inference
  List<String> inferenceBackends= [
      InferenceBackends.CPU.name.toString(),
    ];

  /// The inference backend used for the tf lite interpreter
  late String inferenceBackend;

  /// use a thanos like snap effect to dissolve the drawing from the screen
  bool useThanosSnap = false;

  SettingsAdvanced(){
    if(Platform.isAndroid)
      inferenceBackends.addAll([
        InferenceBackends.GPU.toString(),
        InferenceBackends.NNAPI.toString(),
      ]);
    //else if(Platform.isIOS)
    //  inferenceBackends.addAll([
    //    InferenceBackends.GPU.toString(),
    //    InferenceBackends.CoreML.toString(),
    //  ]);
    //else if(Platform.isLinux || Platform.isMacOS || Platform.isWindows)
    //  inferenceBackends.addAll([
    //    InferenceBackends.XXNPACK.toString()
    //  ]);

    inferenceBackend = inferenceBackends[0];
  }

  void initFromMap(Map<String, dynamic> map){

    inferenceBackend     = map['inferenceBackend'];
    useThanosSnap        = map['useThanosSnap'];

  }

  void initFromJson(String jsonString) =>
    initFromMap(json.decode(jsonString));
  

  Map<String, dynamic> toMap() => {
    'inferenceBackend' : inferenceBackend,
    'useThanosSnap'    : useThanosSnap,
  };

  String toJson() => json.encode(toMap());
}