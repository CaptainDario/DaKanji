// Dart imports:
import 'dart:math';

// Package imports:
import 'package:lite_rt_for_flutter/flutter_interpreter.dart';
import 'package:lite_rt_for_flutter/lite_rt_for_flutter.dart';
import 'package:sentry/sentry_io.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/tf_lite/inference_backend.dart';

/// Initializes the TFLite interpreter on android. Uses either NNAPI, GPU,
/// XNNPack or CPU delegate. For each backend an interpreter is created and
/// the time to run inference measured. 
/// 
/// See `initOptimalInterpreter()` for parameter usage
Future<Map<InferenceBackend, double>> testInterpreterAndroid(
  String assetPath,
  void Function(Interpreter interpreter) runInterpreter,
  {
    List<InferenceBackend> exclude = const [],
    int iterations = 1
  }
  ) async 
{
  Map<InferenceBackend, double> inferenceBackend = {};

  // NNAPI delegate
  if(!exclude.contains(InferenceBackend.nnapi)){
    try{
      Interpreter interpreter = await nnapiInterpreter(assetPath);
      inferenceBackend.addEntries(
        [testBackend(interpreter, InferenceBackend.nnapi, iterations, runInterpreter)]
      );
    }
    catch (e){
      Sentry.captureException(e);
    }
  }
  // GPU delegate
  if(!exclude.contains(InferenceBackend.gpu)){
    try {
      Interpreter interpreter = await gpuInterpreter(assetPath);
      inferenceBackend.addEntries(
        [testBackend(interpreter, InferenceBackend.gpu, iterations, runInterpreter)]
      );
    }
    catch (e){
      Sentry.captureException(e);
    }
  }
  // XNNPack delegate
  if(!exclude.contains(InferenceBackend.xnnPack)){
    try{
      for (var i = 1; i <= min(Platform.numberOfProcessors, 32); i++) {
        String xnnBack = "xnnPack_$i";
        Interpreter interpreter = await xnnPackInterpreter(assetPath, i);
        inferenceBackend.addEntries(
          [testBackend(interpreter, getXNNPackFromString(xnnBack), iterations, runInterpreter)]
        );
      }
    }
    catch (e){
      Sentry.captureException(e);
    }
  }
  // CPU delegate
  if(!exclude.contains(InferenceBackend.cpu)){
    try{
      for (var i = 1; i <= min(Platform.numberOfProcessors, 32); i++) {
        String cpuBack = "cpu_$i";
        Interpreter interpreter = await cpuInterpreter(assetPath, i);
        inferenceBackend.addEntries(
          [testBackend(interpreter, getCPUFromString(cpuBack), iterations, runInterpreter)]
        );
      }
    }
    catch (e){
      Sentry.captureException(e);
    }
  }

  return inferenceBackend;
}

/// Initializes the TFLite interpreter on iOS.
///
/// Uses either CoreML (2|3), Metal, XNNPack or CPU delegate
Future<Map<InferenceBackend, double>> testInterpreterIOS(
    String assetPath,
    void Function(Interpreter interpreter) runInterpreter,
    {
      List<InferenceBackend> exclude = const [],
      int iterations = 1
    }
  ) async 
{

  Map<InferenceBackend, double> inferenceBackend = {};

  // CoreML 3 delegate
  if(!exclude.contains(InferenceBackend.coreMl_3)){
    try{
      Interpreter interpreter = await coreMLInterpreterIOS(assetPath, coreMLVersion: 3);
      inferenceBackend.addEntries(
        [testBackend(interpreter, InferenceBackend.coreMl_3, iterations, runInterpreter)]
      );
    }
    catch (e){
      Sentry.captureException(e);
    }
  }
  // CoreML 2 delegate
  if(!exclude.contains(InferenceBackend.coreMl_2)){
    try{
      Interpreter interpreter = await coreMLInterpreterIOS(assetPath, coreMLVersion: 2);
      inferenceBackend.addEntries(
        [testBackend(interpreter, InferenceBackend.coreMl_2, iterations, runInterpreter)]
      );
    }
    catch (e){
      Sentry.captureException(e);
    }
  }
  // Metal delegate
  if(!exclude.contains(InferenceBackend.metal)){
    try {
      Interpreter interpreter = await metalInterpreterIOS(assetPath);
      inferenceBackend.addEntries(
        [testBackend(interpreter, InferenceBackend.metal, iterations, runInterpreter)]
      );
    }
    catch (e){
      Sentry.captureException(e);
    }
  }
  // XNNPack delegate
  if(!exclude.contains(InferenceBackend.xnnPack)){
    try{
      for (var i = 1; i <= min(Platform.numberOfProcessors, 32); i++) {
        String xnnBack = "xnnPack_$i";
        Interpreter interpreter = await xnnPackInterpreter(assetPath, i);
        inferenceBackend.addEntries(
          [testBackend(interpreter, getXNNPackFromString(xnnBack), iterations, runInterpreter)]
        );
      }
    }
    catch (e) {
      Sentry.captureException(e);
    }
  }
  // CPU delegate
  if(!exclude.contains(InferenceBackend.cpu)){
    try{
      for (var i = 1; i <= min(Platform.numberOfProcessors, 32); i++) {
        String cpuBack = "cpu_$i";
        Interpreter interpreter = await cpuInterpreter(assetPath, i);
        inferenceBackend.addEntries(
          [testBackend(interpreter, getCPUFromString(cpuBack), iterations, runInterpreter)]
        );
      }
    }
    catch (e){
      Sentry.captureException(e);
    }
  }

  return inferenceBackend;
}


/// Initializes the TFLite interpreter on Windows.
///
/// Uses the GPU (OpenCL), XNNPack or CPU mode
Future<Map<InferenceBackend, double>> testInterpreterWindows(
  String assetPath,
  void Function(Interpreter interpreter) runInterpreter,
  {
    List<InferenceBackend> exclude = const [],
    int iterations = 1
  }
  ) async 
{
  Map<InferenceBackend, double> inferenceBackend = {};

  // GPU delegate
  if(!exclude.contains(InferenceBackend.gpu)){
    try {
      Interpreter interpreter = await gpuInterpreter(assetPath);
      inferenceBackend.addEntries(
        [testBackend(interpreter, InferenceBackend.gpu, iterations, runInterpreter)]
      );
    }
    catch (e){
      Sentry.captureException(e);
    }
  }
  // XNNPack delegate
  if(!exclude.contains(InferenceBackend.xnnPack)){
    try{
      for (var i = 1; i <= min(Platform.numberOfProcessors, 32); i++) {
        String xnnBack = "xnnPack_$i";
        Interpreter interpreter = await xnnPackInterpreter(assetPath, i);
        inferenceBackend.addEntries(
          [testBackend(interpreter, getXNNPackFromString(xnnBack), iterations, runInterpreter)]
        );
      }
    }
    catch (e){
      Sentry.captureException(e);
    }
  }
  // CPU delegate
  if(!exclude.contains(InferenceBackend.cpu)){
    try{
      for (var i = 1; i <= min(Platform.numberOfProcessors, 32); i++) {
        String cpuBack = "cpu_$i";
        Interpreter interpreter = await cpuInterpreter(assetPath, i);
        inferenceBackend.addEntries(
          [testBackend(interpreter, getCPUFromString(cpuBack), iterations, runInterpreter)]
        );
      }
    }
    catch (e){
      Sentry.captureException(e);
    }
  }

  return inferenceBackend;
}

/// Initializes the TFLite interpreter on Linux.
///
/// Uses the GPU (OpenCL), XNNPack or CPU mode
Future<Map<InferenceBackend, double>> testInterpreterLinux(
  String assetPath,
  void Function(Interpreter interpreter) runInterpreter,
  {
    List<InferenceBackend> exclude = const [],
    int iterations = 1
  }
  ) async 
{
  Map<InferenceBackend, double> inferenceBackend = {};

  // GPU delegate
  if(!exclude.contains(InferenceBackend.gpu)){
    try {
      Interpreter interpreter = await gpuInterpreter(assetPath);
      inferenceBackend.addEntries(
        [testBackend(interpreter, InferenceBackend.gpu, iterations, runInterpreter)]
      );
    }
    catch (e){
      Sentry.captureException(e);
    }
  }
  // XNNPack delegate
  if(!exclude.contains(InferenceBackend.xnnPack)){
    try{
      for (var i = 1; i <= min(Platform.numberOfProcessors, 32); i++) {
        String xnnBack = "xnnPack_$i";
        Interpreter interpreter = await xnnPackInterpreter(assetPath, i);
        inferenceBackend.addEntries(
          [testBackend(interpreter, getXNNPackFromString(xnnBack), iterations, runInterpreter)]
        );
      }
    }
    catch (e){
      Sentry.captureException(e);
    }
  }
  // CPU delegate
  if(!exclude.contains(InferenceBackend.cpu)){
    try{
      for (var i = 1; i <= min(Platform.numberOfProcessors, 32); i++) {
        String cpuBack = "cpu_$i";
        Interpreter interpreter = await cpuInterpreter(assetPath, i);
        inferenceBackend.addEntries(
          [testBackend(interpreter, getCPUFromString(cpuBack), iterations, runInterpreter)]
        );
      }
    }
    catch (e){
      Sentry.captureException(e);
    }
  }

  return inferenceBackend;
}

/// Initializes the TFLite interpreter on Mac.
///
/// Uses the GPU (OpenCL), XNNPack or CPU mode
Future<Map<InferenceBackend, double>> testInterpreterMac(
  String assetPath,
  void Function(Interpreter interpreter) runInterpreter,
  {
    List<InferenceBackend> exclude = const [],
    int iterations = 1
  }
  ) async 
{
  Map<InferenceBackend, double> inferenceBackend = {};

  // CoreML 3 delegate
  if(!exclude.contains(InferenceBackend.coreMl_3)){
    try{
      Interpreter interpreter = await coreMLInterpreterIOS(assetPath, coreMLVersion: 3);
      inferenceBackend.addEntries(
        [testBackend(interpreter, InferenceBackend.coreMl_3, iterations, runInterpreter)]
      );
    }
    catch (e){
      Sentry.captureException(e);
    }
  }
  // CoreML 2 delegate
  if(!exclude.contains(InferenceBackend.coreMl_2)){
    try{
      Interpreter interpreter = await coreMLInterpreterIOS(assetPath, coreMLVersion: 2);
      inferenceBackend.addEntries(
        [testBackend(interpreter, InferenceBackend.coreMl_2, iterations, runInterpreter)]
      );
    }
    catch (e){
      Sentry.captureException(e);
    }
  }
  // Metal delegate
  if(!exclude.contains(InferenceBackend.metal)){
    try {
      Interpreter interpreter = await metalInterpreterIOS(assetPath);
      inferenceBackend.addEntries(
        [testBackend(interpreter, InferenceBackend.metal, iterations, runInterpreter)]
      );
    }
    catch (e){
      Sentry.captureException(e);
    }
  }
  // XNNPack delegate
  if(!exclude.contains(InferenceBackend.xnnPack)){
    try{
      for (var i = 1; i <= min(Platform.numberOfProcessors, 32); i++) {
        String xnnBack = "xnnPack_$i";
        Interpreter interpreter = await xnnPackInterpreter(assetPath, i);
        inferenceBackend.addEntries(
          [testBackend(interpreter, getXNNPackFromString(xnnBack), iterations, runInterpreter)]
        );
      }
    }
    catch (e){
      Sentry.captureException(e);
    }
  }
  // CPU delegate
  if(!exclude.contains(InferenceBackend.cpu)){
    try{
      for (var i = 1; i <= min(Platform.numberOfProcessors, 32); i++) {
        String cpuBack = "cpu_$i";
        Interpreter interpreter = await cpuInterpreter(assetPath, i);
        inferenceBackend.addEntries(
          [testBackend(interpreter, getCPUFromString(cpuBack), iterations, runInterpreter)]
        );
      }
    }
    catch (e){
      Sentry.captureException(e);
    }
  }

  return inferenceBackend;
}


/// Initializes the interpreter with NPU acceleration for Android.
Future<Interpreter> nnapiInterpreter(String assetPath) async {
  final options = InterpreterOptions()..useNnApiForAndroid = true;
  Interpreter i = await FlutterInterpreter.fromAsset(
    assetPath, 
    options: options
  );

  return i; 
}

/// Initializes the interpreter with GPU acceleration.
Future<Interpreter> gpuInterpreter(String assetPath) async {
  final gpuDelegateV2 = GpuDelegateV2(
    options: GpuDelegateOptionsV2(
      isPrecisionLossAllowed: true
    )
  );
  final options = InterpreterOptions()..addDelegate(gpuDelegateV2);
  Interpreter i = await FlutterInterpreter.fromAsset(
    assetPath,
    options: options
  );

  return i;
}

/// Initializes the interpreter with metal acceleration for iOS.
Future<Interpreter> metalInterpreterIOS(String assetPath) async {

  final gpuDelegate = GpuDelegate(
    options: GpuDelegateOptions(
      allowPrecisionLoss: true,
    ),
  );
  var interpreterOptions = InterpreterOptions()..addDelegate(gpuDelegate);
  Interpreter i = await FlutterInterpreter.fromAsset(
    assetPath,
    options: interpreterOptions
  );
  
  return i;
}

/// Initializes the interpreter with coreML acceleration for iOS.
Future<Interpreter> coreMLInterpreterIOS(
  String assetPath,
  {
    int coreMLVersion = 1
  }
  ) async 
{

  var interpreterOptions = InterpreterOptions()..addDelegate(
    CoreMlDelegate(
      options: CoreMlDelegateOptions(
        coremlVersion: coreMLVersion,
      )
    )
  );
  Interpreter i = await FlutterInterpreter.fromAsset(
    assetPath,
    options: interpreterOptions
  );

  return i;
}

/// Initializes the interpreter with CPU mode set.
Future<Interpreter> cpuInterpreter(String assetPath, int threads) async {
  final options = InterpreterOptions()
    ..threads = threads;
  Interpreter i = await FlutterInterpreter.fromAsset(
    assetPath, options: options);

  return i;
}

/// Initializes the interpreter with XNNPack-CPU mode set.
Future<Interpreter> xnnPackInterpreter(String assetPath, int threads) async {

  Interpreter interpreter;
  final options = InterpreterOptions()..addDelegate(
    XNNPackDelegate(
      options: XNNPackDelegateOptions(
        numThreads: threads 
      )
    )
  );
  interpreter = await FlutterInterpreter.fromAsset(
    assetPath,
    options: options
  );

  return interpreter;
}


MapEntry<InferenceBackend, double> testBackend (
  Interpreter interpreter, 
  InferenceBackend i,
  int iterations,
  void Function(Interpreter interpreter) runInterpreter
)
{

  Stopwatch s = Stopwatch();

  s.start();
  for (var i = 0; i < iterations; i++) {
    runInterpreter(interpreter);
  }
  s.stop();
  
  return MapEntry(i, s.elapsed.inMilliseconds / iterations);
}
