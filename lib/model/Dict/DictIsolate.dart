import 'dart:async';
import 'dart:isolate';
import 'package:hive/hive.dart';
import 'package:database_builder/database_builder.dart';

import 'package:async/async.dart';

class DictIsolate {

  late ReceivePort receivePort;

  late final events;

  late SendPort sendPort;
  /// has this instance been intialized
  bool initialized = false;
  ///
  bool isInitializing = false;

  DictIsolate(){

  }

  Future<void> init () async {

    isInitializing = true;

    this.receivePort = ReceivePort();
    await Isolate.spawn(readAndParseJsonService, this.receivePort.sendPort);

    // Convert the ReceivePort into a StreamQueue to receive messages from the
    // spawned isolate using a pull-based interface. Events are stored in this
    // queue until they are accessed by `events.next`.
    this.events = StreamQueue<dynamic>(this.receivePort);

    // The first message from the spawned isolate is a SendPort. This port is
    // used to communicate with the spawned isolate.
    this.sendPort = await events.next;

    isInitializing = false;
    initialized = true;
  }


  // asynchronously sends a list 
  Stream<List<dynamic>> sendAndReceive(List<String> filenames) async* {

    if(!this.initialized)
      throw("This instance has not been intialized yet, please call `init` first");

    for (var filename in filenames) {
      // Send the next filename to be read and parsed
      this.sendPort.send(filename);

      // Receive the parsed JSON
      List<dynamic> message = await events.next;

      // Add the result to the stream returned by this async* function.
      yield message;
    }

  }

  /// terminates this isolate
  void terminate () async {
    // Send a signal to the spawned isolate indicating that it should exit.
    sendPort.send(null);

    // Dispose the StreamQueue.
    await events.cancel();

    initialized = false;
  }
}

// The entrypoint that runs on the spawned isolate. Receives messages from
// the main isolate, reads the contents of the file, decodes the JSON, and
// sends the result back to the main isolate.
Future<void> readAndParseJsonService(SendPort p) async {

  // Send a SendPort to the main isolate so that it can send JSON strings to
  // this isolate.
  final commandPort = ReceivePort();
  p.send(commandPort.sendPort);

  Hive.init("C:/Users/Dario/Documents");
  Hive.registerAdapter(EntryAdapter());
  Hive.registerAdapter(MeaningAdapter());
  /// the hive box for searching in the enam dict
  Box enamDictBox = await Hive.openBox('jm_enam_and_dict');

  // Wait for messages from the main isolate.
  await for (final message in commandPort) {
    if (message is String) {
      List<dynamic> result = enamDictBox.values.where((entry) => 
        entry.readings.contains(message) ? true : false
      ).toList();
      
      // Send the result to the main isolate.
      p.send(result);
    }
    // Exit if the main isolate sends a null message
    else if (message == null) break;
    
  }

  Isolate.exit();
}