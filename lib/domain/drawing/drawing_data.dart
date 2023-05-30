import 'dart:typed_data';

import 'package:image/image.dart' as image;
import 'package:tflite_flutter/tflite_flutter.dart';



/// Class to bundle all data and methods to run the SignDetection TF Lite model.
/// This includes:
/// * pre- / postprocessing of the data
/// * Define how to run the interpreter
class DrawingData {

  /// A list containing all labels that the model can detect
  final List<String> labels;

  /// The width of the input image to the model
  int inputImageWidth = 128;
  /// The height of the input image to the model
  int inputImageHeight = 128;
  /// The channels of the input image to the model
  int inputImageChannels = 1;
  /// The [_noPredictions] most likely predictions will be shown to the user
  final int _noPredictions = 10;

  late final List<List<List<List<double>>>> input;

  late final List<List<double>> output;

  late final List<String> predictions;



  /// Setup this SignDetectionData class. The given input width,
  /// height, channels should match the input to the model and the `labels` the
  /// class labels of the model.
  DrawingData(this.labels){
    input = List<List<double>>.generate(
      inputImageHeight, (i) => List.generate(inputImageWidth, (j) => 0.0)).
    reshape<double>([1, inputImageHeight, inputImageWidth, 1]).cast();
    output =
      List<List<double>>.generate(1, (i) => 
      List<double>.generate(labels.length, (j) => 0.0));
    predictions = List.filled(_noPredictions, " ");
  }

  /// Pre processes the given `input` and returns the result
  Future<List<List<List<List<double>>>>> preProcessRawInput(Uint8List input) async {
    
    // take image from canvas and resize it
    image.Image base = image.decodeImage(input)!;
    image.Image resizedImage = image.copyResize(base,
      height: inputImageHeight, 
      width: inputImageWidth,
      interpolation: image.Interpolation.cubic
    );
    /*resizedImage = image.gaussianBlur(resizedImage, 2);
    Uint8List resizedBytes = 
      resizedImage.getBytes(format: image.Format.luminance);*/
    resizedImage = image.gaussianBlur(resizedImage, radius: 2);
    final imgRgba8 = resizedImage.convert(numChannels: 1);
    image.grayscale(imgRgba8);

    // convert image for inference into shape [1, height, width, 1]
    // also apply thresholding and normalization [0, 1]
    for (int x = 0; x < inputImageHeight; x++) {
      for (int y = 0; y < inputImageWidth; y++) {
        double val = imgRgba8.getPixelIndex(y, x).toDouble();
        
        this.input[0][x][y][0] = val;
      }
    }

    return this.input;
  }

  /// Defines the post process procdure for the interpreter given in the
  /// constructor. 
  List<String> postProcessRawOutput(){

    // get the 10 most likely predictions
    for (int c = 0; c < _noPredictions; c++) {
      int index = 0;
      for (int i = 0; i < output[0].length; i++) {
        if (output[0][i] > output[0][index]){
          index = i;
        }
      }
      predictions[c] = labels[index];
      output[0][index] = 0.0;
    }
    
    return predictions;
  }

  /// Defines how to run the interpreter
  void runInterpreter(
    Interpreter interpreter,
    List<List<List<List<double>>>> input,
    List<List<double>> output
  )
  {
    interpreter.run(input, output);
  }
}