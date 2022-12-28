import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image/image.dart' as image;
import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:da_kanji_mobile/model/DrawScreen/drawing_isolate_utils.dart';
import 'package:da_kanji_mobile/model/TFLite/base_interpreter.dart';



/// The tf lite interpreter to recognize the hand drawn kanji characters.
/// 
/// Notifies listeners when the predictions changed.
class DrawingInterpreter extends BaseInterpreter with ChangeNotifier{

  // the utils for the interpreter's isolate
  DrawingIsolateUtils ?_isolateUtils;

  /// If the interpreter was initialized successfully
  bool wasInitialized = false;

  /// The path to the tf lite asset
  final String _tfLiteAssetPath = "tflite_models/CNN_single_char.tflite";

  /// The path to the mock tf lite asset (small size can be included in repo)
  final String _mockTFLiteAssetPath = "tflite_models/mock_CNN_single_char.tflite";
  
  /// The path to the labels asset
  final String _labelAssetPath = "assets/tflite_models/CNN_single_char_labels.txt";

  /// The list of all labels the model can recognize.
  late List<String> _labels;

  /// height of the input image (image used for inference)
  int height = 128;

  /// width of the input image (image used for inference)
  int width = 128;

  /// The [_noPredictions] most likely predictions will be shown to the user
  final int _noPredictions = 10;
  
  /// the prediction the CNN made
  List<String> _predictions = List.generate(10, (index) => " ");




  List<String> get predictions{
    return _predictions;
  }

  void _setPredictions(List<String> predictions){
    _predictions = predictions;
  }

  get labels {
    return _labels;
  }

  get isolateUtils{
    return _isolateUtils;
  }

  get interpreteraddress{
    return interpreter?.address;
  }

  DrawingInterpreter(super.name);


  /// Caution: This method needs to be called before using the interpreter.
  void init() async {

    if(wasInitialized){
      debugPrint("Drawing interpreter already initialized. Skipping init.");
    }
    else{
      //  check if the actual model is available or only the mock model
      try {   
        await Interpreter.fromAsset(_tfLiteAssetPath);
        usedTFLiteAssetPath = _tfLiteAssetPath;
      } catch (e) {
        debugPrint("You are using the mock model for DrawScreen inference!");
        usedTFLiteAssetPath = _mockTFLiteAssetPath;
      }

      await loadLabels();
      await allocateInputOutput();
      await initInterpreter();

      _isolateUtils = DrawingIsolateUtils();
      await _isolateUtils?.start();

      wasInitialized = true;
    }
  }

  /// Initialize a second interpereter inside an isolate so that inference is
  /// not blocking the main thread
  void initIsolate(int interpreterAdress, List<String> labels) {

    interpreter = Interpreter.fromAddress(interpreterAdress);
    _labels = labels;

    allocateInputOutput();

    wasInitialized = true;
  }

  /// load the labels from file
  Future<void> loadLabels() async {
    var l = await rootBundle.loadString(_labelAssetPath);
    _labels = l.split("");
  }

  /// allocate memory for inference in / output
  Future<void> allocateInputOutput() async {
    input = List<List<double>>.generate(
      height, (i) => List.generate(width, (j) => 0.0)).
    reshape<double>([1, height, width, 1]).cast();
    output =
      List<List<double>>.generate(1, (i) => 
      List<double>.generate(_labels.length, (j) => 0.0));
  }

  @override
  void free() {
    if(interpreter == null){
      debugPrint("No interpreter was initialized");
      return;
    }

    interpreter!.close();
    output = [[]];
    input = [[[[]]]];
    interpreter = null;
    clearPredictions();
    wasInitialized = false;
  }

  /// Clear all predictions by setting them to " "
  void clearPredictions(){
    _setPredictions(List.generate(_noPredictions, (index) => " "));
    notifyListeners();
  }

  /// Create predictions based on the drawing by running inference on the CNN
  ///
  /// After running the inference the 10 most likely predictions are
  /// returned ordered by how likely they are [likeliest, ..., unlikeliest].
  void runInference(Uint8List inputImage, {bool runInIsolate = true}) async {
    
    if(!wasInitialized) {
      throw Exception(
        "You are trying to use the interpreter before it was initialized!\n" "Execute init() first!"
      );
    }

    if(runInIsolate){
      _predictions = await _isolateUtils?.runInference(
        inputImage,
        interpreter?.address ?? 0,
        labels
      );
    }
    else{

      // take image from canvas and resize it
      image.Image base = image.decodeImage(inputImage)!;
      image.Image resizedImage = image.copyResize(base,
        height: height, width: width, interpolation: image.Interpolation.cubic);
      resizedImage = image.gaussianBlur(resizedImage, 2);
      Uint8List resizedBytes = 
        resizedImage.getBytes(format: image.Format.luminance);

      // convert image for inference into shape [1, height, width, 1]
      // also apply thresholding and normalization [0, 1]
      for (int x = 0; x < height; x++) {
        for (int y = 0; y < width; y++) {
          double val = resizedBytes[(x * width) + y].toDouble();
          
          input[0][x][y][0] = val;
        }
      }

      // convert image array to str to show for debugging
      //var imageStr = _input.toString();

      // run inference
      interpreter!.run(input, output);

      // get the 10 most likely predictions
      for (int c = 0; c < _noPredictions; c++) {
        int index = 0;
        for (int i = 0; i < output[0].length; i++) {
          if (output[0][i] > output[0][index]){
            index = i;
          }
        }
        predictions[c] = _labels[index];
        output[0][index] = 0.0;
      }
    }

    notifyListeners();
  }

}