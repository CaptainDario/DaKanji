// Dart imports:
import 'dart:isolate';

// Package imports:
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:drift/isolate.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:universal_io/io.dart';

// Project imports:
import '/database/dakanji_db.dart';

/// Worker isolate that processes a file and sends a message when done
void isolateWorker(SendPort mainSendPort) {

  final receivePort = ReceivePort();

  // Send back the isolate's port for communication
  mainSendPort.send(receivePort.sendPort);
  // The DaDakanji database
  late DaKanjiDB db;

  // init mecab
  final mecab = Mecab();
  // TODO isolate based parsing
  //await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  receivePort.listen((message) async {
    if(message is DriftIsolate){
      db = DaKanjiDB(executor: await message.connect());
      mainSendPort.send("initialized");
    }
    if (message is File) {
      print("isolate received a file");
      try {
        await parseDictionaryZip(message, db, mecab);
      } catch (e) {
        print("Error during parsing of dictionary: $e");
        mainSendPort.send("Error during parsing of dictionary: $e");
      }
      
      // Notify the main isolate that the file is done
      mainSendPort.send('done'); 
    }
  });

}
