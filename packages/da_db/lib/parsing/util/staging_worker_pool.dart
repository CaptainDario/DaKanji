import 'dart:async';
import 'dart:isolate';

import 'package:da_db/parsing/yomitan/staging_db/workers/worker_protocol.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

/// A reusable engine to orchestrate parallel staging workers.
class StagingWorkerPool {
  /// Spawns [numWorkers] isolates executing [workerEntryPoint], feeds them 
  /// [files] from the queue, and returns the paths to the generated staging DBs.
  static Future<List<String>> runGreedyParallelStaging({
    required int numWorkers,
    required String dataSourcePath,
    required String languageProcessorJson,
    required List<String> files,
    required Directory tempDir,
    required void Function(SendPort) workerEntryPoint,
    required void Function(String) onStatus,
  }) async {
    if (files.isEmpty) return [];

    onStatus("Starting parallel import with $numWorkers workers...");
    final poolDir = await tempDir.createTemp('da_db_pool_');
    final workerDbPaths = <String>[];
    final completions = <Future>[];

    final queue = List<String>.from(files);

    for (int i = 0; i < numWorkers; i++) {
      final workerDbPath = p.join(poolDir.path, 'worker_$i.db');
      workerDbPaths.add(workerDbPath);
      final completer = Completer<void>();
      completions.add(completer.future);

      _spawnWorker(
        id: i,
        zipPath: dataSourcePath,
        dbPath: workerDbPath,
        lpJson: languageProcessorJson,
        queue: queue,
        workerEntryPoint: workerEntryPoint,
        completer: completer,
        onStatus: onStatus,
      );
    }

    await Future.wait(completions);
    return workerDbPaths;
  }

  static Future<void> _spawnWorker({
    required int id,
    required String zipPath,
    required String dbPath,
    required String lpJson,
    required List<String> queue,
    required void Function(SendPort) workerEntryPoint,
    required Completer completer,
    required Function(String) onStatus,
  }) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(workerEntryPoint, receivePort.sendPort);

    SendPort? workerSendPort;
    String? currentFileName;

    receivePort.listen((message) {
      if (message is SendPort) {
        workerSendPort = message;
        workerSendPort!.send(MsgInit(zipPath, dbPath, lpJson, receivePort.sendPort));
      } 
      else if (message is MsgReady || message is MsgDone) {
        if (message is MsgDone) {
          onStatus("Parsed: $currentFileName");
        }
        
        if (queue.isNotEmpty) {
          currentFileName = queue.removeAt(0);
          workerSendPort!.send(MsgProcessFile(currentFileName!));
        } else {
          workerSendPort!.send(MsgTerminate());
        }
      }
      else if (message is MsgError) {
        print("Worker $id Error: ${message.error}");
        // Even on error, keep feeding the worker the next file
        if (queue.isNotEmpty) {
          currentFileName = queue.removeAt(0);
          workerSendPort!.send(MsgProcessFile(currentFileName!));
        } else {
          workerSendPort!.send(MsgTerminate());
        }
      }
      else if (message == "CLOSED") {
        receivePort.close();
        completer.complete();
      }
    });
  }
}