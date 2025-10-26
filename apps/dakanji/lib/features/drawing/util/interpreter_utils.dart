// Package imports:
import 'package:lite_rt_for_flutter/lite_rt_for_flutter.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/tf_lite/inference_backend.dart';
import 'package:da_kanji_mobile/repositories/tf_lite/backend.dart';

/// Checks for the available backends and uses the best available backend.
/// For this a valid `input`, `output` and function `runInterpreter` (defines
/// how to run the given TF Lite model at `tfLiteAssetPath)` needs to be provided
/// With `exclude` certain delegates can be excluded.
/// `iterations` denotes how many times the time for running inference should be
/// measured.
/// A map containing the backends with their
/// time is returned. If a backend is not included that means that this backend
/// is not available on this device with this model.
/// 
/// Delegate support and order: 
/// * iOS    : CoreML > Metal > XNNPack > CPU <br/>
/// * Android: NNApi > GPU > XNNPack > CPU <br/>
/// * Windows: GPU (OpenCL) > XNNPack > CPU <br/>
/// * Mac    : GPU (OpenCL) > XNNPack > CPU <br/>
/// * Linux  : GPU (OpenCL) > XNNPack > CPU <br/>
Future<Map<InferenceBackend, double>> testBackends(
  String tfLiteAssetPath,
  Object input,
  Object output,
  void Function(Interpreter interpreter, Object input, Object output) runInterpreter,
  {
    List<InferenceBackend> exclude = const [],
    int iterations = 1
  }
  ) async 
{

  Map<InferenceBackend, double> backendStats;

  
  if (Platform.isAndroid) {
    backendStats = await testInterpreterAndroid(
      tfLiteAssetPath,
      (Interpreter interpreter) => runInterpreter(interpreter, input, output),
      exclude: exclude,
      iterations: iterations
    );
  }
  
  else if (Platform.isIOS) {
    backendStats = await testInterpreterIOS(
      tfLiteAssetPath,
      (Interpreter interpreter) => runInterpreter(interpreter, input, output),
      exclude: exclude,
      iterations: iterations
    );
  }
  else if(Platform.isWindows) {
    backendStats = await testInterpreterWindows(
      tfLiteAssetPath,
      (Interpreter interpreter) => runInterpreter(interpreter, input, output),
      exclude: exclude,
      iterations: iterations
    );
  }
  else if(Platform.isLinux) {
    backendStats = await testInterpreterLinux(
      tfLiteAssetPath,
      (Interpreter interpreter) => runInterpreter(interpreter, input, output),
      exclude: exclude,
      iterations: iterations
    );
  }
  else if(Platform.isMacOS) {
    backendStats = await testInterpreterMac(
      tfLiteAssetPath,
      (Interpreter interpreter) => runInterpreter(interpreter, input, output),
      exclude: exclude,
      iterations: iterations
    );
  }
  else {
    throw Exception("Platform not supported.");
  }
  

  return backendStats;
}

/// Instantiates an interpereter using the given TF Lite model asset and 
/// backend
Future<Interpreter> initInterpreterFromBackend(
  InferenceBackend inferenceBackend,
  String assetPath
  ) async
{
  if(inferenceBackend == InferenceBackend.cpu){
    return cpuInterpreter(assetPath, 1);
  }
  else if(inferenceBackend.name.startsWith(InferenceBackend.cpu.name)){
    return cpuInterpreter(assetPath, int.parse(inferenceBackend.name.split("_")[1]));
  }
  else if(inferenceBackend == InferenceBackend.xnnPack){
    return xnnPackInterpreter(assetPath, 1);
  }
  else if(inferenceBackend.name.startsWith(InferenceBackend.xnnPack.name)){
    return await xnnPackInterpreter(assetPath, int.parse(inferenceBackend.name.split("_")[1]));
  }
  else if(inferenceBackend == InferenceBackend.gpu){
    return await gpuInterpreter(assetPath);
  }
  else if(inferenceBackend == InferenceBackend.nnapi){
    return await nnapiInterpreter(assetPath);
  }
  else if(inferenceBackend == InferenceBackend.metal){
    return await metalInterpreterIOS(assetPath);
  }
  else if(inferenceBackend == InferenceBackend.coreMl_2){
    return await coreMLInterpreterIOS(assetPath, coreMLVersion: 2);
  }
  else if(inferenceBackend == InferenceBackend.coreMl_3){
    return await coreMLInterpreterIOS(assetPath, coreMLVersion: 3);
  }
  else{
    throw Exception("Unknown inference backend $inferenceBackend.");
  }
}