import 'dart:isolate';
import 'dart:typed_data';

import 'DrawingIsolateData.dart';
import 'package:da_kanji_mobile/model/core/DrawingInterpreter.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

/// Manages separate Isolate instance for inference
class DrawingIsolateUtils {
  static const String DEBUG_NAME = "InferenceIsolate";

  Isolate _isolate;
  ReceivePort _receivePort = ReceivePort();
  SendPort _sendPort;

  SendPort get sendPort => _sendPort;

  Future<void> start() async {
    _isolate = await Isolate.spawn<SendPort>(
      entryPoint,
      _receivePort.sendPort,
      debugName: DEBUG_NAME,
    );

    _sendPort = await _receivePort.first;
  }

  void stopIsolate() {
    if (_isolate != null) {
      _receivePort.close();
      _isolate.kill(priority: Isolate.immediate);
      _isolate = null;
    }
  }

  static void entryPoint(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final DrawingIsolateData isolateData in port) {
      if (isolateData != null) {
        DrawingInterpreter classifier = DrawingInterpreter();
        classifier.initIsolate(
          Interpreter.fromAddress(isolateData.interpreterAddress),
          isolateData.labels
        );
        classifier.runInference(isolateData.image, runInIsolate: false);
        isolateData.responsePort.send(classifier.predictions);
      }
    }
  }

  Future<dynamic> runInference (
    Uint8List image, int interpreterAddress, List<String> labels) async {
    
    var data = DrawingIsolateData(image, interpreterAddress, labels);

    ReceivePort responsePort = ReceivePort();
    sendPort.send(data..responsePort = responsePort.sendPort);
    return responsePort.first;
  }
}
