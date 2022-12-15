import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:universal_io/io.dart';

import 'package:da_kanji_mobile/model/TFLite/inference_backend.dart';



/// Base class for all interpreters
/// Automatically gets the best available inference backend for this device.
abstract class BaseInterpreter {


  /// the tf lite interpreter to recognize kanjis
  Interpreter? interpreter;
  /// The inference backend used for this interpreter
  late InferenceBackend inferenceBackend;
  /// input to the interpreter
  var input;
  /// output of the interperter
  var output;
  /// the path to the tf lite model that is used in this interepreter
  late String usedTFLiteAssetPath; 
  /// The name of this interpreter
  String name;

  BaseInterpreter(this.name);

  Future<void> initInterpreter() async {
    if (Platform.isAndroid) {
      interpreter = await _initInterpreterAndroid();
    }
    else if (Platform.isIOS) {
      interpreter = await _initInterpreterIOS();
    }
    else if(Platform.isWindows) {
      interpreter = await _initInterpreterWindows();
    }
    else if(Platform.isLinux) {
      interpreter = await _initInterpreterLinux();
    }
    else if(Platform.isMacOS) {
      interpreter = await _initInterpreterMac();
    }
    else {
      throw PlatformException(code: "Platform not supported.");
    }
  }

  /// Call this to free the memory of this interpreter
  void free();

  /// Initializes the TFLite interpreter on android.
  ///
  /// Uses either NNAPI, GPU, XNNPack or CPU delegate
  Future<Interpreter> _initInterpreterAndroid() async {

    Interpreter interpreter;

    // get platform information
    //DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    // try NNAPI delegate
    try{
      interpreter = await _nnapiInterpreter();
      interpreter.run(input, output);
      debugPrint("$name-interpreter uses NNAPI delegate");
    }
    // on exception try GPU delegate
    catch (e){ 
      try {
        interpreter = await _gpuInterpreterAndroid();
        interpreter.run(input, output);
        debugPrint("$name-interpreter uses GPU v2 delegate");
      }
      // on exception try XNNPack CPU delegate
      catch (e){
        try{
          interpreter = await _xxnPackInterpreter();
          interpreter.run(input, output);
          debugPrint("$name-interpreter uses XNNPack delegate");
        }
        // on exception use CPU delegate
        catch (e) {
          interpreter = await _cpuInterpreter();
          interpreter.run(input, output);
          debugPrint("$name-interpreter uses CPU");
        }
      }
    }

    return interpreter;
  }
  
  /// Initializes the TFLite interpreter on iOS.
  ///
  /// Uses either CoreML, Metal, XNNPack or CPU delegate
  Future<Interpreter> _initInterpreterIOS() async {

    Interpreter interpreter;

    // get platform information
    //DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    // try CoreML delegate
    try{
      interpreter = await _coreMLInterpreterIOS();
      interpreter.run(input, output);
      debugPrint("$name-interpreter uses CoreML delegate");
    }
    // on exception try Metal delegate
    catch (e){ 
      try {
        interpreter = await _metalInterpreterIOS();
        interpreter.run(input, output);
        debugPrint("$name-interpreter uses Metal delegate");
      }
      // on exception use XNNPack CPU delegate
      catch (e){
        try{
          interpreter = await _xxnPackInterpreter();
          interpreter.run(input, output);
          debugPrint("$name-interpreter uses XNNPack delegate");
        }
        // on exception use CPU delegate
        catch (e) {
          interpreter = await _cpuInterpreter();
          interpreter.run(input, output);
          debugPrint("$name-interpreter uses CPU");
        }
      }
    }
    
    return interpreter;

  }

  /// Initializes the TFLite interpreter on Windows.
  ///
  /// Uses the GPU mode if open CL is avail CPU mode.
  Future<Interpreter> _initInterpreterWindows() async {

    Interpreter interpreter;

    // get platform information
    //DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //IosDeviceInfo desktopInfo = await deviceInfo.iosInfo;

    try {
      interpreter = await _gpuInterpreterAndroid();
      interpreter.run(input, output);
      debugPrint("$name-interpreter uses GPU open-cl delegate");
    }
    // on exception try XNNPack CPU delegate
    catch (e){
      try{
        interpreter = await _xxnPackInterpreter();
        interpreter.run(input, output);
        debugPrint("$name-interpreter uses XNNPack delegate");
      }
      // on exception use CPU delegate
      catch (e) {
        interpreter = await _cpuInterpreter();
        interpreter.run(input, output);
        debugPrint("$name-interpreter uses CPU");
      }
    }
        
    return interpreter;
  }

  /// Initializes the TFLite interpreter on Linux.
  ///
  /// Uses the uses CPU mode.
  Future<Interpreter> _initInterpreterLinux() async {

    Interpreter interpreter;

    // get platform information
    //DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //IosDeviceInfo desktopInfo = await deviceInfo.iosInfo;

    try {
      interpreter = await _gpuInterpreterAndroid();
      interpreter.run(input, output);
      debugPrint("$name-interpreter uses GPU open-cl delegate");
    }
    // on exception try XNNPack CPU delegate
    catch (e){
      try{
        interpreter = await _xxnPackInterpreter();
        interpreter.run(input, output);
        debugPrint("$name-interpreter uses XNNPack delegate");
      }
      // on exception use CPU delegate
      catch (e) {
        interpreter = await _cpuInterpreter();
        interpreter.run(input, output);
        debugPrint("$name-interpreter uses CPU");
      }
    }
        
    return interpreter;

  }

  /// Initializes the TFLite interpreter on Mac.
  ///
  /// Uses the uses CPU mode.
  Future<Interpreter> _initInterpreterMac() async {

    Interpreter interpreter;

    // get platform information
    //DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //IosDeviceInfo desktopInfo = await deviceInfo.iosInfo;

    try {
      interpreter = await _gpuInterpreterAndroid();
      interpreter.run(input, output);
      debugPrint("$name-interpreter uses GPU open-cl delegate");
    }
    // on exception try XNNPack CPU delegate
    catch (e){
      try{
        interpreter = await _xxnPackInterpreter();
        interpreter.run(input, output);
        debugPrint("$name-interpreter uses XNNPack delegate");
      }
      // on exception use CPU delegate
      catch (e) {
        interpreter = await _cpuInterpreter();
        interpreter.run(input, output);
        debugPrint("$name-interpreter uses CPU");
      }
    }
        
    return interpreter;
    
  }

  /// Initializes the interpreter with NPU acceleration for Android.
  Future<Interpreter> _nnapiInterpreter() async {
    final options = InterpreterOptions()..useNnApiForAndroid = true;
    Interpreter i = await Interpreter.fromAsset(
      usedTFLiteAssetPath, 
      options: options
    );

    inferenceBackend = InferenceBackend.NNApi;

    return i; 
  }

  /// Initializes the interpreter with GPU acceleration for Android.
  Future<Interpreter> _gpuInterpreterAndroid() async {
    final gpuDelegateV2 = GpuDelegateV2();
    final options = InterpreterOptions()..addDelegate(gpuDelegateV2);
    Interpreter i = await Interpreter.fromAsset(
      usedTFLiteAssetPath,
      options: options
    );

    inferenceBackend = InferenceBackend.GPU;

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
      usedTFLiteAssetPath,
      options: interpreterOptions
    );
    
    inferenceBackend = InferenceBackend.Metal;
    
    return i;
  }

  /// Initializes the interpreter with coreML acceleration for iOS.
  Future<Interpreter> _coreMLInterpreterIOS() async {

    var interpreterOptions = InterpreterOptions()..addDelegate(CoreMlDelegate());
    Interpreter i = await Interpreter.fromAsset(
      usedTFLiteAssetPath,
      options: interpreterOptions
    );
    
    inferenceBackend = InferenceBackend.CoreML;

    return i;
  }

  /// Initializes the interpreter with CPU mode set.
  Future<Interpreter> _cpuInterpreter() async {
    final options = InterpreterOptions()
      ..threads = Platform.numberOfProcessors - 1;
    Interpreter i = await Interpreter.fromAsset(
      usedTFLiteAssetPath, options: options);
    
    inferenceBackend = InferenceBackend.CPU;

    return i;
  }

  /// Initializes the interpreter with XNNPack-CPU mode set.
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
      usedTFLiteAssetPath,
      options: options
    );

    inferenceBackend = InferenceBackend.XNNPack;

    return interpreter;
  }
  
}