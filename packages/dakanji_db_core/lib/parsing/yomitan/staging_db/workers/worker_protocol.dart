import 'dart:isolate';

/// Base class for messages sent FROM the Main Isolate TO the Worker Isolate.
abstract class WorkerMessage {}

/// Tells the worker to initialize its database and prepare the zip file.
class MsgInit extends WorkerMessage {
  final String zipPath;
  final String dbPath;
  final String languageProcessorJson;
  final SendPort replyPort;

  MsgInit(
    this.zipPath, 
    this.dbPath, 
    this.languageProcessorJson,
    this.replyPort
  );
}

/// Tells the worker to process a specific file inside the zip archive.
class MsgProcessFile extends WorkerMessage {
  final String fileName;
  MsgProcessFile(this.fileName);
}

/// Tells the worker to clean up resources (close DB, close Zip) and exit.
class MsgTerminate extends WorkerMessage {}


/// Base class for messages sent FROM the Worker Isolate TO the Main Isolate.
abstract class MainMessage {}

/// Sent when the worker has successfully initialized (DB open, Zip open).
class MsgReady extends MainMessage {
  final SendPort workerSendPort;
  MsgReady(this.workerSendPort);
}

/// Sent when the worker has finished processing one file and is ready for the next.
class MsgDone extends MainMessage {}

/// Sent when the worker encounters an exception.
class MsgError extends MainMessage {
  final String error;
  MsgError(this.error);
}