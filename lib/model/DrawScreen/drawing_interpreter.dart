import 'package:da_kanji_mobile/model/DrawScreen/drawing_data.dart';
import 'package:da_kanji_mobile/model/TFLite/inference_backend.dart';
import 'package:da_kanji_mobile/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:da_kanji_mobile/model/DrawScreen/drawing_isolate.dart';
import 'package:da_kanji_mobile/model/TFLite/interpreter_utils.dart';
import 'package:da_kanji_mobile/model/TFLite/inference_stats.dart';



/// The tf lite interpreter to recognize the hand drawn kanji characters.
/// 
/// Notifies listeners when the predictions changed.
class DrawingInterpreter with ChangeNotifier{

  /// The interpreter to run the TF Lite model
  late Interpreter interpreter;
  /// A name for this interpreter
  final String name;
  /// If the interpreter was initialized successfully
  bool wasInitialized = false;

  /// The path to the tf lite asset
  final String _tfLiteAssetPath = "tflite_models/CNN_single_char.tflite";
  /// The path to the mock tf lite asset (small size can be included in repo)
  final String _mockTFLiteAssetPath = "tflite_models/mock_CNN_single_char.tflite";
  /// The path to the labels asset
  final String _labelAssetPath = "assets/tflite_models/CNN_single_char_labels.txt";
  /// The asset path to the used asset for creating the interpreter
  late final String _usedTFLiteAssetPath;

  /// the utils for the interpreter's isolate
  DrawingIsolate? _inferenceIsolate;
  /// The interpreter instance
  late final DrawingData data;
  /// The statstics of the last succesful inference
  InferenceStats? inferenceStats;
  /// The result of the last inference (predictions of the model)
  List<String> _predictions = List.filled(10, " ");
  get predictions {
    return _predictions;
  }

  /// Message that it printed when the instance accessed but was not initialized
  String _notInitializedMessage =
    "You are trying to use the interpreter before it was initialized!\n"
    "Execute init() first!";


  DrawingInterpreter({
    this.name = "DrawingInterpreter"
  });

  /// Initializes this interprerter with the given values
  Future<void> init() async 
  {

    if(wasInitialized){
     print("${this.name} already initialized. Skipping init.");
      return;
    }
    
    // load data
    try {
      await rootBundle.loadBuffer("assets/${_tfLiteAssetPath}");
      _usedTFLiteAssetPath = _tfLiteAssetPath;
    } catch(_) {
      _usedTFLiteAssetPath = _mockTFLiteAssetPath;
    }
    
    data = DrawingData(await loadLabels());

    interpreter = await initInterpreterFromBackend(
      await getBestBeckend(),
      _usedTFLiteAssetPath
    );

    // create and setup isolate
    _inferenceIsolate = DrawingIsolate();
    await _inferenceIsolate?.start(interpreter.address, data);

    wasInitialized = true;
  }

  Future<InferenceBackend> getBestBeckend() async {

    InferenceBackend iB;

    // check if the backend was already tested -> return it if true
    if(GetIt.I<UserData>().drawingBackend != null) {
      iB = GetIt.I<UserData>().drawingBackend!;
    }
    // Otherwise, find the best available backend and load the model
    else{
      // test all backends on this platform
      List<MapEntry<InferenceBackend, double>> tests = (await testBackends(
        _usedTFLiteAssetPath,
        data.input,
        data.output,
        (Interpreter interpreter, Object input, Object output) => 
          data.runInterpreter(
            interpreter, 
            input as List<List<List<List<double>>>>,
            output as List<List<double>>
          ),
        iterations: 10,
      )).entries.toList()..sort(((a, b) => a.value.compareTo(b.value)));

      // store the best backend to disk
      iB = tests.first.key;
      GetIt.I<UserData>().drawingBackend = iB;
      GetIt.I<UserData>().save();

     print("Inference timings for Drawing: $tests");
    }
    
    print("Using: ${iB}");
    return iB;
  }

  /// load the labels from file
  Future<List<String>> loadLabels() async {
    var l = await rootBundle.loadString(_labelAssetPath);
    return l.split("");
  }

  /// Process the input, runs inference on it and returns the processed output
  Future<void> runInference(Uint8List input) async {
    if(!wasInitialized) throw Exception(_notInitializedMessage);

    Stopwatch stopwatch = Stopwatch()..start();

    // send the input to the inference isolate and wait for the response
    _inferenceIsolate!.sendPort.send(input);

    // receive detections and stats + emit changed signal
    _predictions = await _inferenceIsolate!.messageQueue.next;
    InferenceStats stats = await _inferenceIsolate!.messageQueue.next;
    stats.totalTime = stopwatch.elapsed.inMilliseconds;
    notifyListeners();

  }

  void clearPredictions(){
    _predictions = List.filled(10, " ");
    notifyListeners();
  }

  /// Frees all used resources
  void free() {
    if(!wasInitialized){
     print(_notInitializedMessage);
      return;
    }

    _inferenceIsolate!.sendPort.send(null);
    _inferenceIsolate!.stopIsolate();
    _inferenceIsolate = null;
    interpreter.close();
    wasInitialized = false;
  }
}