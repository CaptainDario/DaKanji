import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/util/db_optimization.dart';

import 'audio_bank_merger.dart';

/// Attaches the populated audio staging database to the main database and 
/// executes the merge pipeline.
/// 
/// Uses a timestamped alias (e.g., `worker_1623...`) to ensure thread-safety 
/// and prevent SQLite alias collisions if multiple imports occur sequentially.
Future<void> mergeAudioStagingDb({
  required DaDb db,
  required String workerDbPath,
  required int indexId,
}) async {
  final workerAlias = 'worker_${DateTime.now().millisecondsSinceEpoch}';
  
  // Temporarily disable synchronous PRAGMAs to boost transfer speed
  await optimizeTargetDbForMerge(db);
  
  await db.customStatement('ATTACH DATABASE ? AS $workerAlias', [workerDbPath]);

  try {
    await AudioBankMerger().merge(
      targetDb: db, 
      workerAlias: workerAlias, 
      indexId: indexId,
    );
  }
  catch (e) {
    print("Audio Merge Error: $e");
    rethrow;
  }
  finally {
    // Guarantee detachment to prevent file locks or memory leaks
    await db.customStatement('DETACH DATABASE $workerAlias');
    await restoreTargetDbAfterMerge(db);
  }
}