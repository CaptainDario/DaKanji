import 'dart:async';
import 'dart:collection';
import 'dart:isolate';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_params.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart'; 

class DaKanjiDbSearchManager {
  
  // -- Configuration --
  final DaKanjiDB daKanjiDB;
  final int debounceMilliseconds;
  final bool debug;
  final int targetIdleWorkers;

  // -- State --
  Timer? _debounceTimer;
  
  /// Queue of warm workers ready to take a job instantly.
  final Queue<_WorkerHandle> _idleWorkers = Queue();
  
  /// The handle for the current UI request.
  _SearchJobHandle? _activeJob;
  
  /// Tracks how many workers are currently being spawned
  int _spawningCount = 0;

  /// Tracks the current "generation" of the search request. 
  int _currentSearchId = 0;

  DaKanjiDbSearchManager({
    required this.daKanjiDB,
    this.debounceMilliseconds = 333,
    this.debug = false,
    this.targetIdleWorkers = 2,
  }) {
    _replenishQueue();
  }

  /// Cancels debounce timer and marks current job as cancelled.
  void cancelCurrentOperations() {
    _debounceTimer?.cancel();
    _activeJob?.cancel(); // Logically cancel, don't kill
    _currentSearchId++;
  }

  void search(
    DictionarySearchParams params, {
    required void Function(DictionarySearchResult?) onResult,
  }) {
    _debounceTimer?.cancel();
    final int thisSearchId = ++_currentSearchId;

    _debounceTimer = Timer(Duration(milliseconds: debounceMilliseconds), () {
      _executeSearch(params, onResult, thisSearchId);
    });
  }

  void searchImmediate(
    DictionarySearchParams params, {
    required void Function(DictionarySearchResult?) onResult,
  }) {
    _debounceTimer?.cancel();
    final int thisSearchId = ++_currentSearchId;
    _executeSearch(params, onResult, thisSearchId);
  }

  Future<void> _executeSearch(
    DictionarySearchParams params,
    void Function(DictionarySearchResult?) onResult,
    int searchId,
  ) async {
    
    // 1. Check if user typed again while debounce was waiting
    if (searchId != _currentSearchId) return;

    if (params.query.isEmpty) {
      _activeJob?.cancel();
      onResult(null);
      return;
    }

    // 2. Logically cancel the previous job (ignore its results)
    // We DO NOT kill the worker. Let it finish and close DB cleanly.
    _activeJob?.cancel();

    // 3. Create a new handle for this specific search
    final job = _SearchJobHandle();
    _activeJob = job;

    // 4. Get a worker (Warm or Spawn)
    _WorkerHandle worker;
    if (_idleWorkers.isNotEmpty) {
      if (debug) print("[Controller] Using WARM worker");
      worker = _idleWorkers.removeFirst();
    } else {
      if (debug) print("[Controller] Queue empty! Spawning COLD worker...");
      try {
        worker = await _spawnWorker();
        // Check if cancelled during spawn await
        if (job.isCancelled || searchId != _currentSearchId) {
          _idleWorkers.add(worker); // Save for next time
          return; 
        }
      } catch (e) {
        if (debug) print("[Controller] Failed to spawn cold worker: $e");
        return;
      }
    }

    // 5. Setup result listener
    final resultPort = ReceivePort();

    resultPort.listen((message) {
      // Only process if this specific job hasn't been cancelled/superseded
      if (!job.isCancelled && searchId == _currentSearchId) {
        if (message is DictionarySearchResult) {
          onResult(message);
        } else if (message is _ErrorResult && debug) {
          print("[Controller] Worker Error: ${message.error}");
        }
      } else {
        if (debug) print("[Controller] Ignoring stale result (Gen: $searchId)");
      }
      
      resultPort.close();
    });

    // 6. Send Job
    worker.sendPort.send(_WorkerJob(
      replyPort: resultPort.sendPort,
      params: params,
      debug: debug,
    ));

    // 7. Ensure we have workers ready for the NEXT keystroke
    _replenishQueue();
  }

  void _replenishQueue() {
    final needed = targetIdleWorkers - _idleWorkers.length - _spawningCount;
    if (needed <= 0) return;

    for (int i = 0; i < needed; i++) {
      _spawningCount++;
      _spawnWorker().then((worker) {
        _idleWorkers.add(worker);
        _spawningCount--;
      }).catchError((e) {
        if (debug) print("[Controller] Replenish failed: $e");
        _spawningCount--;
      });
    }
  }

  Future<_WorkerHandle> _spawnWorker() async {
    final handshakePort = ReceivePort(); 
    final completer = Completer<_WorkerHandle>();

    try {
      final driftIsolate = await daKanjiDB.attachedDatabase.serializableConnection();

      final isolate = await Isolate.spawn(
        _workerEntry,
        _InitMessage(
          handshakeSendPort: handshakePort.sendPort,
          dbConnection: driftIsolate,
          inMemory: daKanjiDB.inMemory,
        ),
        debugName: "SearchWorker",
      );

      handshakePort.listen((message) {
        if (message is SendPort) {
          completer.complete(_WorkerHandle(isolate: isolate, sendPort: message));
          handshakePort.close(); 
        }
      });

    } catch (e) {
      completer.completeError(e);
      handshakePort.close();
    }

    return completer.future;
  }

  void dispose() {
    cancelCurrentOperations();
    // It is safe to kill IDLE workers as they hold no active DB locks/connections
    for (final w in _idleWorkers) {
      w.isolate.kill(priority: Isolate.immediate);
    }
    _idleWorkers.clear();
  }

  // --- Worker Logic (Same as before) ---

  static void _workerEntry(_InitMessage init) async {
    final commandPort = ReceivePort();
    init.handshakeSendPort.send(commandPort.sendPort);

    final QueryExecutor executor = await init.dbConnection.connect();
    final DaKanjiDB db = DaKanjiDB(executor: executor, inMemory: init.inMemory);

    await for (final msg in commandPort) {
      if (msg is _WorkerJob) {
        try {
          final result = await db.dictionarySearchDao.dictionarySearch(
            msg.params,
            printDebugInfo: msg.debug,
          );
          await db.close(); // Crucial: Properly close connection
          Isolate.exit(msg.replyPort, result);
        } catch (e) {
          try { await db.close(); } catch (_) {}
          Isolate.exit(msg.replyPort, _ErrorResult(e.toString()));
        }
      }
    }
  }
}

// --- Helper DTOs ---

class _WorkerHandle {
  final Isolate isolate;
  final SendPort sendPort;
  _WorkerHandle({required this.isolate, required this.sendPort});
}

class _SearchJobHandle {
  bool isCancelled = false;
  void cancel() => isCancelled = true;
}

class _InitMessage {
  final SendPort handshakeSendPort;
  final DriftIsolate dbConnection;
  final bool inMemory;
  _InitMessage({required this.handshakeSendPort, required this.dbConnection, required this.inMemory});
}

class _WorkerJob {
  final SendPort replyPort;
  final DictionarySearchParams params;
  final bool debug;
  _WorkerJob({required this.replyPort, required this.params, required this.debug});
}

class _ErrorResult {
  final String error;
  _ErrorResult(this.error);
}