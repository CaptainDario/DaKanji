// Dart imports:
import 'dart:async';
import 'dart:isolate';

// Flutter imports:
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:async/async.dart';
import 'package:database_builder/database_builder.dart';
import 'package:isar/isar.dart';
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:da_kanji_mobile/repositories/dictionary/dictionary_search.dart';

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
    {
      this.debugName,
      int noProcesses = 2
    }
  );

  /// Initializes the isolate.
  /// 
  /// Warning: this needs to be called before any other function
  /// Note: `noIsolates` needs to be larger than 0
  Future<void> init(int isolateNo, int noIsolates) async {

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

    _initialized = true;
  }


  /// Kills the isolate, this should be called before discarding this object.
  Future<void> kill() async {
    _checkInitialized();

    isolateSendPort!.send(null);
    var s  = await events!.next;
    debugPrint("killed: $s");

    _initialized = false;
  }

  /// convenience function to check if `init()` was called.
  /// Throws an Exxception if it was not initialized.
  void _checkInitialized() {
    if(!_initialized) throw Exception("The isolate needs to be initialized first.");
  }

  /// Queries the dictionay inside an isolate
  Future<List> query(String query, String? queryKana, String? queryDeconjugated,
    List<String> filters) async {
    
    _checkInitialized();

    List result = [];

    if(query != ""){
      isolateSendPort!.send(Tuple4(query, queryKana, queryDeconjugated, filters));
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

  // open isar
  Isar isar = Isar.openSync(
    [KanjiSVGSchema, JMNEdictSchema, JMdictSchema, Kanjidic2Schema],
    directory: directory,
    name: name,
    maxSizeMiB: g_IsarDictMaxMiB
  );

  List<int> ids = isar.jmdict.where().idProperty().findAllSync();
  int noEntries = ids.length-1;
  int idRangeStart = (ids[(noEntries/noIsolates*isolateNo).floor()]).floor();
  int idRangeEnd   = (ids[(noEntries/noIsolates*(isolateNo+1)).floor()]).floor();

  debugPrint('Spawned isolate started, args: langs - $langs; isolateNo - $isolateNo; idRangeStart - $idRangeStart; idRangeEnd - $idRangeEnd');

  // Wait for messages from the main isolate.
  await for (final message in events.rest) {

    if (message == null) {
      // Exit if the main isolate sends a null message
      break;
    }
    
    if (message is Tuple4<String, String?, String?, List<String>>) {
      Stopwatch s = Stopwatch()..start();
      
      String query = message.item1;
      String? queryKana = message.item2;
      String? queryDeconjugated = message.item3;
      List<String> filters = message.item4;

      List<JMdict> searchResults = 
        buildJMDictQuery(isar, idRangeStart, idRangeEnd, noIsolates,
          query, queryKana, queryDeconjugated, filters, langs)
        .findAllSync();

      // Send the result to the main isolate.
      p.send(searchResults);
      debugPrint("Query: $query, QueryKana: $queryKana, QueryDeconjugated: $queryDeconjugated, filters: $filters, results: ${searchResults.length}, time: ${s.elapsed}");
    }    
  }

  debugPrint('Spawned isolate finished.');
  Isolate.exit(p, name);
}
