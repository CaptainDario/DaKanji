import 'dart:async';
import 'dart:collection';
import 'dart:isolate';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_params.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart'; 

/// Controls search execution using a pool of disposable, pre-warmed workers.
/// 
/// Strategy:
/// 1. **Pre-warming:** Keeps a queue of idle workers ready to receive a job.
/// 2. **Execution:** Pops a warm worker, sends the job, and lets it die via [Isolate.exit] (Zero-Copy).
/// 3. **Replenishment:** Immediately spawns new background workers to refill the queue.
/// 4. **Cancellation:** Kills the active worker immediately if a new search starts.
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
  
  /// The currently active worker processing the user's latest query.
  /// Kept referenced so we can kill it if the user types again.
  _WorkerHandle? _activeWorker;
  
  /// Tracks how many workers are currently being spawned in the background
  /// so we don't over-spawn during rapid typing.
  int _spawningCount = 0;

  /// Tracks the current "generation" of the search request. 
  /// Used to invalidate stale results from async gaps.
  int _currentSearchId = 0;

  DaKanjiDbSearchManager({
    required this.daKanjiDB,
    this.debounceMilliseconds = 1000 ~/ 2,
    this.debug = false,
    this.targetIdleWorkers = 2,
  }) {
    _replenishQueue();
  }

  /// Cancels debounce timer, kills the currently active worker, 
  /// and invalidates any pending operations (via generation ID).
  void cancelCurrentOperations() {
    _debounceTimer?.cancel();
    _killActiveWorker();
    // Increment generation to ensure any pending spawns/results are ignored
    _currentSearchId++;
  }

  /// Schedules a search after the debounce delay.
  void search(
    DictionarySearchParams params, {
    required void Function(DictionarySearchResult?) onResult,
  }) {
    _debounceTimer?.cancel();
    
    // Increment generation immediately so previous pending searches become stale
    final int thisSearchId = ++_currentSearchId;

    _debounceTimer = Timer(Duration(milliseconds: debounceMilliseconds), () {
      _executeSearch(params, onResult, thisSearchId);
    });
  }

  /// Immediately executes a search, bypassing the debounce delay.
  void searchImmediate(
    DictionarySearchParams params, {
    required void Function(DictionarySearchResult?) onResult,
  }) {
    _debounceTimer?.cancel();
    final int thisSearchId = ++_currentSearchId;
    _executeSearch(params, onResult, thisSearchId);
  }

  /// Internal method to orchestrate the search execution.
  Future<void> _executeSearch(
    DictionarySearchParams params,
    void Function(DictionarySearchResult?) onResult,
    int searchId,
  ) async {
    
    // Pre-check: Has the user typed again since this was scheduled?
    if (searchId != _currentSearchId) return;

    // Handle empty input immediately
    if (params.query.isEmpty) {
      _killActiveWorker();
      onResult(null);
      return;
    }

    // Kill the previous active worker (Hard Cancellation).
    // This frees the CPU immediately for the new job.
    _killActiveWorker();

    // Get a warm worker from the pool
    _WorkerHandle worker;
    if (_idleWorkers.isNotEmpty) {
      if (debug) print("[Controller] Using WARM worker (${_idleWorkers.length - 1} left)");
      worker = _idleWorkers.removeFirst();
    } else {
      // Fallback: Queue empty? Spawn one on demand (slower, but necessary).
      if (debug) print("[Controller] Queue empty! Spawning COLD worker...");
      try {
        //  
        // Note: While we await here, the user might type again!
        worker = await _spawnWorker();

        // CHECK: While we were spawning, did the generation change?
        if (searchId != _currentSearchId) {
          if (debug) print("[Controller] Worker spawned too late. Storing as idle.");
          // Don't kill it, it's fresh! Just save it for the next guy.
          _idleWorkers.add(worker);
          return; 
        }

      } catch (e) {
        if (debug) print("[Controller] Failed to spawn cold worker: $e");
        return;
      }
    }

    _activeWorker = worker;

    // Create a dedicated port for the result of THIS specific job.
    // The worker will exit to this port.
    final resultPort = ReceivePort();

    resultPort.listen((message) {
      // CHECK: Is this result still relevant? 
      // If searchId != _currentSearchId, the user has already searched for something else.
      if (searchId == _currentSearchId) {
        if (message is DictionarySearchResult) {
          onResult(message);
        } else if (message is _ErrorResult) {
          if (debug) print("[Controller] Worker Error: ${message.error}");
        }
      } else {
         if (debug) print("[Controller] Ignoring stale result (Gen: $searchId vs Current: $_currentSearchId)");
      }
      
      // Cleanup: This worker is now dead (exited).
      // We only clear _activeWorker if it refers to THIS worker (not replaced yet).
      if (_activeWorker == worker) {
        _activeWorker = null;
      }
      
      resultPort.close();
      // The worker isolate dies automatically due to Isolate.exit, 
      // but we clear the reference just in case.
      _killHandle(worker); 
    });

    // Send Job
    worker.sendPort.send(_WorkerJob(
      replyPort: resultPort.sendPort,
      params: params,
      debug: debug,
    ));

    // Replenish the queue in the background to be ready for next keystroke.
    _replenishQueue();
  }

  /// Ensures the idle queue stays full up to [targetIdleWorkers].
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

  /// Kills the currently active worker isolate if it exists.
  void _killActiveWorker() {
    if (_activeWorker != null) {
      _killHandle(_activeWorker!);
      _activeWorker = null;
    }
  }

  /// Helper to kill a specific worker handle.
  void _killHandle(_WorkerHandle handle) {
    handle.isolate.kill(priority: Isolate.immediate);
  }

  /// Spawns a new worker isolate, connects to DB, and waits for handshake.
  Future<_WorkerHandle> _spawnWorker() async {
    final handshakePort = ReceivePort(); 
    final completer = Completer<_WorkerHandle>();

    try {
      // Get thread-safe connection token (must be done on main isolate)
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

      // Wait for the worker to send back its command port
      handshakePort.listen((message) {
        if (message is SendPort) {
          completer.complete(_WorkerHandle(
            isolate: isolate,
            sendPort: message, // The worker's command port
          ));
          handshakePort.close(); 
        }
      });

    } catch (e) {
      completer.completeError(e);
      handshakePort.close();
    }

    return completer.future;
  }

  /// Disposes everything: timers, active worker, and idle pool.
  void dispose() {
    cancelCurrentOperations();
    for (final w in _idleWorkers) {
      w.isolate.kill(priority: Isolate.immediate);
    }
    _idleWorkers.clear();
  }

  // ====================================================================
  //                         STATIC WORKER LOGIC
  // ====================================================================

  static void _workerEntry(_InitMessage init) async {
    final commandPort = ReceivePort();
    
    // Handshake: Send our command port back to main
    init.handshakeSendPort.send(commandPort.sendPort);

    // Connect to DB (Drift handles pooling via the token)
    final QueryExecutor executor = await init.dbConnection.connect();
    final DaKanjiDB db = DaKanjiDB(
      executor: executor,
      inMemory: init.inMemory
    );

    // Wait for exactly ONE job
    await for (final msg in commandPort) {
      if (msg is _WorkerJob) {
        try {
          if (msg.debug) print("[Worker] Running: '${msg.params.query}'");

          // Run the heavy search
          final result = await db.dBQueriesDao.dictionarySearch(
            msg.params,
            printDebugInfo: msg.debug,
          );

          // Close DB connection before exiting
          await db.close();

          // Return Result via Zero-Copy Exit
          // Transfers memory to main thread and terminates isolate immediately.
          Isolate.exit(msg.replyPort, result);

        } catch (e, stack) {
          if (msg.debug) print("[Worker] Crash: $e\n$stack");
          
          try { await db.close(); } catch (_) {}
          
          Isolate.exit(msg.replyPort, _ErrorResult(e.toString()));
        }
      }
    }
  }
}

// -- Helper DTOs --

/// Handle to track a running worker isolate.
class _WorkerHandle {
  final Isolate isolate;
  /// Port to send the job TO the worker.
  final SendPort sendPort;

  _WorkerHandle({
    required this.isolate,
    required this.sendPort,
  });
}

/// Initial configuration passed to the worker on spawn.
class _InitMessage {
  final SendPort handshakeSendPort;
  final DriftIsolate dbConnection;
  final bool inMemory;

  _InitMessage({
    required this.handshakeSendPort, 
    required this.dbConnection, 
    required this.inMemory
  });
}

/// The actual job payload sent when execution is requested.
class _WorkerJob {
  /// The port to return the result to (via exit).
  final SendPort replyPort;
  final DictionarySearchParams params;
  final bool debug;

  _WorkerJob({
    required this.replyPort, 
    required this.params, 
    required this.debug
  });
}

/// Wrapper for errors occurring inside the worker.
class _ErrorResult {
  final String error;
  _ErrorResult(this.error);
}