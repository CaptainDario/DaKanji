import 'dart:isolate';
import 'package:async/async.dart';

import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:da_kanji_mobile/model/DrawScreen/drawing_data.dart';
import 'package:da_kanji_mobile/model/TFLite/inference_stats.dart';



/// Bundles data to pass between Isolate
class DrawingIsolate {

  /// The name of this isolate (used for debugging)
  String debugName;
  /// The isolate instance
  late Isolate? _isolate;
  /// The receive port of the main thread
  final ReceivePort _receivePort = ReceivePort();
  /// A queue of messages that are send from the isolate
  late final StreamQueue<dynamic> messageQueue = StreamQueue<dynamic>(_receivePort);
  /// The port on which the isolate is listening
  late SendPort _sendPort;
  SendPort get sendPort => _sendPort;


  /// Instantiates a new `SignDetectionIsolate`. Before using it `start()` needs
  /// to be called
  DrawingIsolate(
    {
      this.debugName = "DrawingIsolate",
    }
  );

  /// Spawns a new isolate to run inference in. In this isolate an interpreter
  /// with the given address and data is created to run inference.
  Future<void> start(int interpreterAddress, DrawingData data,) async {
    _isolate = await Isolate.spawn<SendPort>(
      entryPoint,
      _receivePort.sendPort,
      debugName: debugName,
    );

    _sendPort = await messageQueue.next;
    sendPort.send(interpreterAddress);
    sendPort.send(data);
  }

  /// Stops this isolate and frees all resources
  void stopIsolate() {
    if (_isolate != null) {
      _receivePort.close();
      _isolate!.kill(priority: Isolate.immediate);
      _isolate = null;
    }
  }

  /// The function that is called inside of the isolate.
  /// It sets the isolate up and starts listening for messages.
  static void entryPoint(SendPort sendPort) async {

    // send the port of this isolate to the main thread
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    /// a queue a of messages that are send from the main isolate
    StreamQueue mainMessageQueue = StreamQueue(port);

    // create a interpreter inside of the isolate
    Interpreter interpreter = Interpreter.fromAddress(
      (await mainMessageQueue.next) as int
    );
    
    // receive all data
    DrawingData data = (await mainMessageQueue.next) as DrawingData;

    // time measurements
    InferenceStats inferenceStats = InferenceStats();
    Stopwatch stopwatch = Stopwatch();

    // wait for messages from the main isolate
    await for (final message in mainMessageQueue.rest) {
      
      // stop listening for messages on a null message
      if(message ==  null) break;

      // pre processing
      stopwatch..reset()..start();
      var input = await data.preProcessRawInput(message);
      inferenceStats.preProcessingTime = stopwatch.elapsed.inMilliseconds;

      // inference
      stopwatch..reset()..start();
      data.runInterpreter(interpreter, input, data.output);
      inferenceStats.inferenceTime = stopwatch.elapsed.inMilliseconds;

      // post processing
      stopwatch..reset()..start();
      List<String> out = data.postProcessRawOutput();
      inferenceStats.postProcessingTime = stopwatch.elapsed.inMilliseconds;

      // send result and stats to main isolate
      sendPort.send(out);
      sendPort.send(inferenceStats);
    }
  }
}