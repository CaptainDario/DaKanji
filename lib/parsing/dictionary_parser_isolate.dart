import 'package:universal_io/io.dart';
import 'dart:isolate';

import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:drift/isolate.dart';

/// Worker isolate that processes a file and sends a message when done
void isolateWorker(SendPort mainSendPort) {

  final receivePort = ReceivePort();

  // Send back the isolate's port for communication
  mainSendPort.send(receivePort.sendPort);
  // The DaDakanji database
  late DaKanjiDB db;

  receivePort.listen((message) async {
    if(message is DriftIsolate){
      db = DaKanjiDB(executor: await message.connect());
      mainSendPort.send("initialized");
    }
    if (message is File) {
      print("isolate received a file");
      // TODO update api
      //await parseDictionaryFile(Tuple2(message, db));
      // Notify the main isolate that the file is done
      mainSendPort.send('done'); 
    }
  });

}
