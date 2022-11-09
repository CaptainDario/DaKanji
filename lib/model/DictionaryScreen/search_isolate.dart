import 'dart:async';
import 'dart:isolate';

import 'package:async/async.dart';

import 'package:isar/isar.dart';
import 'package:database_builder/src/jm_enam_and_dict_to_Isar/data_classes.dart' as isar_jm;
import 'package:database_builder/src/kanjiVG_to_Isar/data_classes.dart' as isar_kanji;
import 'package:database_builder/src/kanjidic2_to_Isar/data_classes.dart' as isar_kanjidic;





class SearchIsolate {

  /// Has the isolate been initialized
  bool initialized = false;
  /// The receive port of the main isolate
  ReceivePort? receivePort;
  /// The send port of the main isolate
  SendPort? sendPort;
  /// the send port of the spawned isolate
  SendPort? isolateSendPort;
  /// The spawned isolate
  Isolate? isolate;
  /// The queue for the results of the search isolate
  StreamQueue? events;
  /// The search mode used for this isolate
  int mode;
  /// In which languages meanings should be searched
  List<String> languages;
  /// A name fot this isolate 
  String? debugName;

  SearchIsolate(
    this.mode, 
    this.languages, 
    {
      this.debugName
    }
  );

  /// Initializes the isolate.
  /// 
  /// Warning: this needs to be called before any other function
  void init() async {
    receivePort = ReceivePort();
    sendPort = receivePort!.sendPort;

    isolate = await Isolate.spawn(
      _readAndParseJsonService, 
      receivePort!.sendPort,
      debugName: debugName
    );

    // Convert the ReceivePort into a StreamQueue to receive messages from the
    // spawned isolate using a pull-based interface. Events are stored in this
    // queue until they are accessed by `events.next`.
    events = StreamQueue<dynamic>(receivePort!);

    // The first message from the spawned isolate is a SendPort. This port is
    // used to communicate with the spawned isolate.
    isolateSendPort = await events!.next;

    // init isolate
    isolateSendPort!.send(languages);
    isolateSendPort!.send(mode);

    initialized = true;
  }

  /// Kills the isolate, this should be called before discarding this object.
  void kill() {
    _checkInitialized();

    receivePort!.sendPort.send(null);

    initialized = false;
  }

  /// convenience function to check if `init()` was called.
  /// Throws an Exxception if it was not initialized.
  void _checkInitialized() {
    if(!initialized) throw Exception("The isolate needs to be ");
  }

  // Spawns an isolate and asynchronously sends a list of filenames for it to
  // read and decode. Waits for the response containing the decoded JSON
  // before sending the next.
  //
  // Returns a stream that emits the JSON-decoded contents of each file.
  Future<List<isar_jm.Entry>> query(String query) async {
    _checkInitialized();

    isolateSendPort!.send(query);

    List<isar_jm.Entry> result = await events!.next;
    return result;
  }
}



// The entrypoint that runs on the spawned isolate. Receives queries from
// the main isolate, searches in ISAR, and sends the result back to the main isolate.
Future<void> _readAndParseJsonService(SendPort p) async {
  print('Spawned isolate started.');

  // Send a SendPort to the main isolate so that it can send messages
  final commandPort = ReceivePort();
  p.send(commandPort.sendPort);

  // convert the receive port to a queue to get the init arguments
  var events = StreamQueue<dynamic>(commandPort);
  List<String> langs = await events.next;
  int mode = await events.next;

  // open isar
  Isar isar = Isar.openSync(
    [isar_kanji.KanjiSVGSchema, isar_jm.EntrySchema, isar_kanjidic.Kanjidic2EntrySchema],
  );

  // Wait for messages from the main isolate.
  await for (final message in events.rest) {
    if (message is String) {
      Stopwatch s = Stopwatch()..start();
      print("message = " + message.toString());
      List<isar_jm.Entry> results = isar.entrys.filter()
        .meaningsElement((meaning) => meaning
          .anyOf(langs, (m, lang) => m
            .languageEqualTo(lang)
            .optional(message.length < 3, (m) => m
              .meaningsElementStartsWith(message)
            )
            .optional(message.length >= 3, (m) => m
              .meaningsElementContains(message)
            )
          )
        )
      .limit(1000)
      .findAllSync();

      // Send the result to the main isolate.
      p.send(results);
      print("len ${results.length} time: ${s.elapsed}");
    }
    else if (message == null) {
      // Exit if the main isolate sends a null message, indicating there are no
      // more files to read and parse.
      break;
    }
  }

  print('Spawned isolate finished.');
  Isolate.exit();
}