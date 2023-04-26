import 'dart:async';
import 'dart:isolate';
import 'package:async/async.dart';

import 'package:isar/isar.dart';
import 'package:database_builder/database_builder.dart';
import 'package:kana_kit/kana_kit.dart';

import 'package:da_kanji_mobile/application/dictionary/dictionary_search_util.dart';



class DictionarySearchIsolate {

  /// In which languages meanings should be searched
  List<String> languages;

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
  /// Should the search be converted to hiragana
  bool convertToHiragana;

  /// The directory of the ISAR file of the dictionary
  String directory;
  /// The name of the ISAR file of the dictionary
  String name;

  /// A name fot this isolate 
  String? debugName;
  /// Has the isolate been initialized
  bool _initialized = false;


  DictionarySearchIsolate(
    this.languages,
    this.directory,
    this.name,
    this.convertToHiragana,
    {
      this.debugName,
      int no_processes = 2
    }
  );

  /// Initializes the isolate.
  /// 
  /// Warning: this needs to be called before any other function
  /// Note: `noIsolates` needs to be larger than 0
  void init(int isolateNo, int noIsolates) async {

    if(noIsolates < 1){
      throw Exception("`noIsolates` needs to be larger than 0");
    }

    receivePort = ReceivePort();
    sendPort = receivePort!.sendPort;

    isolate = await Isolate.spawn(
      _searchInIsar, 
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
    isolateSendPort!.send(isolateNo);
    isolateSendPort!.send(noIsolates);
    isolateSendPort!.send(directory);
    isolateSendPort!.send(name);
    isolateSendPort!.send(convertToHiragana);

    _initialized = true;
  }

  /// Kills the isolate, this should be called before discarding this object.
  void kill() {
    _checkInitialized();

    receivePort!.sendPort.send(null);

    _initialized = false;
  }

  /// convenience function to check if `init()` was called.
  /// Throws an Exxception if it was not initialized.
  void _checkInitialized() {
    if(!_initialized) throw Exception("The isolate needs to be initialized first.");
  }

  /// Queries the dictionay inside an isolate
  Future<List> query(String query) async {
    _checkInitialized();

    List result = [];

    if(query != ""){
      isolateSendPort!.send(query);
      result = await events!.next;
    }
    else{
      result = [];
    }

    return result;
  }
}



// The entrypoint that runs on the spawned isolate. Receives queries from
// the main isolate, searches in ISAR, and sends the result back to the main isolate.
Future<void> _searchInIsar(SendPort p) async {

  // Send a SendPort to the main isolate so that it can send messages
  final commandPort = ReceivePort();
  p.send(commandPort.sendPort);

  // convert the receive port to a queue to get the init arguments
  var events = StreamQueue<dynamic>(commandPort);
  List<String> langs = await events.next;
  int isolateNo  = await events.next;
  int noIsolates = await events.next;

  String directory = await events.next;
  String name = await events.next;

  bool kanaize = await events.next;

  // open isar
  Isar isar = Isar.openSync(
    [KanjiSVGSchema, JMNEdictSchema, JMdictSchema, Kanjidic2Schema],
    directory: directory,
    name: name,
    maxSizeMiB: 512
  );

  List<int> ids = isar.jmdict.where().idProperty().findAllSync();
  int noEntries = ids.length-1;
  int idRangeStart = (ids[(noEntries/noIsolates*isolateNo).floor()]).floor();
  int idRangeEnd   = (ids[(noEntries/noIsolates*(isolateNo+1)).floor()]).floor();

  KanaKit kanaKit = KanaKit();

  print('Spawned isolate started, args: langs - ${langs}; isolateNo - ${isolateNo}; idRangeStart - ${idRangeStart}; idRangeEnd - ${idRangeEnd}');

  String messageHiragana = "";

  // Wait for messages from the main isolate.
  await for (final message in events.rest) {
    if (message is String) {
      Stopwatch s = Stopwatch()..start();

      // convert the message to hiragana if setting enabled
      if(kanaize)
        messageHiragana = kanaKit.toHiragana(message);
      
      // check if the message contains wildcards and replace them appropriately
      String _message = message.replaceAll(RegExp(r"\?|\﹖|\︖|\？"), "???");
      messageHiragana = messageHiragana.replaceAll(RegExp(r"\?|\﹖|\︖|\？"), "???");

      // extract filters from query
      List<String> filters = _message.split(" ").where((e) => e.startsWith("#")).toList();
      _message = _message.split(" ").where((e) => !e.startsWith("#")).join(" ");

      print("${filters} ${filters.length} $_message");

      List<JMdict> searchResults = 
        buildJMDictQuery(isar, idRangeStart, idRangeEnd,
          _message, messageHiragana, langs)
        .limit(1000).findAllSync();

      // Send the result to the main isolate.
      p.send(searchResults);
      print("len ${searchResults.length} time: ${s.elapsed}");
    }
    else if (message == null) {
      // Exit if the main isolate sends a null message
      break;
    }
  }

  print('Spawned isolate finished.');
  Isolate.exit();
}
