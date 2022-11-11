import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:image/image.dart' as image;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:universal_io/io.dart';

import 'package:da_kanji_mobile/model/DrawScreen/drawing_isolate_utils.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';



/// The tf lite interpreter to recognize the hand drawn kanji characters.
/// 
/// Notifies listeners when the predictions changed.
class DrawingInterpreter with ChangeNotifier{

  /// the tf lite interpreter to recognize kanjis
  Interpreter ?_interpreter;

  // the utils for the interpreter's isolate
  DrawingIsolateUtils ?_isolateUtils;

  /// If the interpreter was initialized successfully
  bool wasInitialized = false;

  /// The path to the tf lite asset
  final String _tfLiteAssetPath = "tflite_models/CNN_single_char.tflite";

  /// The path to the mock tf lite asset (small size can be included in repo)
  final String _mockTFLiteAssetPath = "tflite_models/mock_CNN_single_char.tflite";

  /// the actually used tf lite asset path
  String _usedTFLiteAssetPath = "";
  
  /// The path to the labels asset
  final String _labelAssetPath = "assets/tflite_models/CNN_single_char_labels.txt";

  /// The list of all labels the model can recognize.
  late List<String> _labels;

  /// input to the CNN
  List<List<List<List<double>>>> _input = [[[[]]]];

  /// output of the CNN
  List<List<double>> _output = [[]];

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
    return _interpreter?.address;
  }


  /// Caution: This method needs to be called before using the interpreter.
  void init() async {

    if(wasInitialized){
      debugPrint("Drawing interpreter already initialized. Skipping init.");
    }
    else{
      //  check if the actual model is available or only the mock model
      try {   
        await Interpreter.fromAsset(_tfLiteAssetPath);
        _usedTFLiteAssetPath = _tfLiteAssetPath;
      } catch (e) {
        debugPrint("You are using the mock model!");
        _usedTFLiteAssetPath = _mockTFLiteAssetPath;
      }

      // load the labels from file
      var l = await rootBundle.loadString(_labelAssetPath);
      _labels = l.split("");
      
      // allocate memory for inference in / output
      _input = List<List<double>>.generate(
        height, (i) => List.generate(width, (j) => 0.0)).
      reshape<double>([1, height, width, 1]).cast();
      _output =
        List<List<double>>.generate(1, (i) => 
        List<double>.generate(_labels.length, (j) => 0.0));

      if (Platform.isAndroid) {
        _interpreter = await _initInterpreterAndroid();
      } else if (Platform.isIOS) {
        _interpreter = await _initInterpreterIOS();
      } else if(Platform.isWindows) {
        _interpreter = await _initInterpreterWindows();
      } else if(Platform.isLinux) {
        _interpreter = await _initInterpreterLinux();
      } else if(Platform.isMacOS) {
        _interpreter = await _initInterpreterMac();
      } else {
        throw PlatformException(code: "Platform not supported.");
      }
      GetIt.I<Settings>().save();

      debugPrint(GetIt.I<Settings>().advanced.inferenceBackend);

      _isolateUtils = DrawingIsolateUtils();
      _isolateUtils?.start();

      wasInitialized = true;
    }
  }

  /// Initialize the isolate in which the inference should be run.
  void initIsolate(Interpreter interpreter, List<String> labels) async {

    _interpreter = interpreter;
    _labels = labels;

    // allocate memory for inference in / output
    _input = List<List<double>>.generate(
      height, (i) => List.generate(width, (j) => 0.0)).
      reshape<double>([1, height, width, 1]).cast();
    _output =
      List<List<double>>.generate(1, (i) => 
      List<double>.generate(_labels.length, (j) => 0.0));

    wasInitialized = true;
  }

  /// Call this to free the memory of this interpreter
  /// 
  /// Should be invoked when a different screen is opened which uses a 
  /// different interpreter.
  void free() {
    if(_interpreter == null){
      debugPrint("No interpreter was initialized");
      return;
    }

    _interpreter!.close();
    _output = [[]];
    _input = [[[[]]]];
    _interpreter = null;
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
        _interpreter?.address ?? 0,
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
          
          _input[0][x][y][0] = val;
        }
      }

      // convert image array to str to show for debugging
      //var imageStr = _input.toString();

      // run inference
      _interpreter!.run(_input, _output);

      // get the 10 most likely predictions
      for (int c = 0; c < _noPredictions; c++) {
        int index = 0;
        for (int i = 0; i < _output[0].length; i++) {
          if (_output[0][i] > _output[0][index]){
            index = i;
          }
        }
        predictions[c] = _labels[index];
        _output[0][index] = 0.0;
      }
    }

    notifyListeners();
  }

  /// Initializes the TFLite interpreter on android.
  ///
  /// Uses NnAPI for devices with Android API >= 27. Otherwise uses the 
  /// GPUDelegate. If it is detected that the apps runs on an emulator CPU mode 
  /// is used
  Future<Interpreter> _initInterpreterAndroid() async {

    Interpreter interpreter;

    // get platform information
    //DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    // if no inference backend was set -> automatically set one
    String selectedBackend = GetIt.I<Settings>().advanced.inferenceBackend;
    if(!GetIt.I<Settings>().advanced.inferenceBackends.contains(selectedBackend)){
      // try NNAPI delegate
      try{
        interpreter = await _nnapiInterpreter();
        interpreter.run(_input, _output);
      }
      // on exception try GPU delegate
      catch (e){ 
        try {
          interpreter = await _gpuInterpreterAndroid();
          interpreter.run(_input, _output);
        }
        // on exception use CPU delegate
        catch (e){
          interpreter = await _cpuInterpreter();
          interpreter.run(_input, _output);
        }
      }
    }
    // an inference backend was set -> load from settings
    else if(selectedBackend == Settings().advanced.inferenceBackends[0]){
      interpreter = await _cpuInterpreter();
    }
    else if(selectedBackend == Settings().advanced.inferenceBackends[1]){
      interpreter = await _gpuInterpreterAndroid();
    }
    else if(selectedBackend == Settings().advanced.inferenceBackends[2]){
      interpreter = await _nnapiInterpreter();
    }
    // if all fails return a CPU based interpreter
    else{
      interpreter = await _cpuInterpreter();
    }

    return interpreter;
  }
  
  /// Initializes the TFLite interpreter on iOS.
  ///
  /// Uses the metal delegate if running on an actual device.
  /// Otherwise uses CPU mode.
  Future<Interpreter> _initInterpreterIOS() async {

    Interpreter interpreter;

    // get platform information
    //DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    // if no inference backend was set -> automatically set one
    String selectedBackend = GetIt.I<Settings>().advanced.inferenceBackend;
    if(!GetIt.I<Settings>().advanced.inferenceBackends.contains(selectedBackend)){
      // try NNAPI delegate
      try{
        interpreter = await _coreMLInterpreterIOS();
        interpreter.run(_input, _output);
      }
      // on exception try GPU delegate
      catch (e){ 
        try {
          interpreter = await _metalInterpreterIOS();
          interpreter.run(_input, _output);
        }
        // on exception use CPU delegate
        catch (e){
          interpreter = await _cpuInterpreter();
          interpreter.run(_input, _output);
        }
      }
    }

    // an inference backend was set -> load from settings
    else if(selectedBackend == Settings().advanced.inferenceBackends[0]){
      interpreter = await _cpuInterpreter();
    }
    else if(selectedBackend == Settings().advanced.inferenceBackends[3]){
      interpreter = await _metalInterpreterIOS();
    }
    else if(selectedBackend == Settings().advanced.inferenceBackends[4]){
      interpreter = await _coreMLInterpreterIOS();
    }
    // if all fails return a CPU based interpreter
    else{
      interpreter = await _cpuInterpreter();
    }
    
    return interpreter;

  }

  /// Initializes the TFLite interpreter on Windows.
  ///
  /// Uses the uses CPU mode.
  Future<Interpreter> _initInterpreterWindows() async {

    return await _cpuInterpreter();
  }

  /// Initializes the TFLite interpreter on Linux.
  ///
  /// Uses the uses CPU mode.
  Future<Interpreter> _initInterpreterLinux() async {

    return await _cpuInterpreter();
  }

  /// Initializes the TFLite interpreter on Mac.
  ///
  /// Uses the uses CPU mode.
  Future<Interpreter> _initInterpreterMac() async {

    return await _cpuInterpreter();
  }

  /// Initializes the interpreter with NPU acceleration for Android.
  Future<Interpreter> _nnapiInterpreter() async {
    final options = InterpreterOptions()..useNnApiForAndroid = true;
    Interpreter i = await Interpreter.fromAsset(
      _usedTFLiteAssetPath, 
      options: options
    );
    GetIt.I<Settings>().advanced.inferenceBackend = Settings().advanced.inferenceBackends[2];
    return i; 
  }

  /// Initializes the interpreter with GPU acceleration for Android.
  Future<Interpreter> _gpuInterpreterAndroid() async {
    final gpuDelegateV2 = GpuDelegateV2();
    final options = InterpreterOptions()..addDelegate(gpuDelegateV2);
    Interpreter i = await Interpreter.fromAsset(
      _usedTFLiteAssetPath,
      options: options
    );
    GetIt.I<Settings>().advanced.inferenceBackend = Settings().advanced.inferenceBackends[1];
    return i;
  }

  /// Initializes the interpreter with metal acceleration for iOS.
  Future<Interpreter> _metalInterpreterIOS() async {

    final gpuDelegate = GpuDelegate(
      options: GpuDelegateOptions(
        allowPrecisionLoss: true, 
        waitType: TFLGpuDelegateWaitType.active),
    );
    var interpreterOptions = InterpreterOptions()..addDelegate(gpuDelegate);
    Interpreter i = await Interpreter.fromAsset(
      _usedTFLiteAssetPath,
      options: interpreterOptions
    );
    GetIt.I<Settings>().advanced.inferenceBackend = Settings().advanced.inferenceBackends[1];
    return i;
  }

  /// Initializes the interpreter with coreML acceleration for iOS.
  Future<Interpreter> _coreMLInterpreterIOS() async {

    var interpreterOptions = InterpreterOptions()..addDelegate(CoreMlDelegate());
    Interpreter i = await Interpreter.fromAsset(
      _usedTFLiteAssetPath,
      options: interpreterOptions
    );
    GetIt.I<Settings>().advanced.inferenceBackend = Settings().advanced.inferenceBackends[1];
    return i;
  }

  /// Initializes the interpreter with CPU mode set.
  Future<Interpreter> _cpuInterpreter() async {
    final options = InterpreterOptions()
      ..threads = Platform.numberOfProcessors - 1;
    Interpreter i = await Interpreter.fromAsset(
      _usedTFLiteAssetPath, options: options);
    GetIt.I<Settings>().advanced.inferenceBackend = Settings().advanced.inferenceBackends[0];
    return i;
  }


  // ignore: unused_element
  Future<Interpreter> _xxnPackInterpreter() async {

    Interpreter interpreter;
    final options = InterpreterOptions()..addDelegate(
      XNNPackDelegate(
        options: XNNPackDelegateOptions(
          numThreads: Platform.numberOfProcessors >= 4 ? 4 : Platform.numberOfProcessors 
        )
      )
    );
    interpreter = await Interpreter.fromAsset(
      _usedTFLiteAssetPath,
      options: options
    );

    return interpreter;
  }

}