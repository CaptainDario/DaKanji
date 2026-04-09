import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/index/yomitan_index.dart';

import 'package:da_db/parsing/audio/mergers/audio_bank_merger.dart';

/// Attaches the populated audio staging database to the main database and 
/// executes the merge pipeline.
/// 
/// Uses a timestamped alias (e.g., `worker_1623...`) to ensure thread-safety 
/// and prevent SQLite alias collisions if multiple imports occur sequentially.
Future<void> mergeAudioStagingDb({
  required DaDb db,
  required String workerAlias,
  required YomitanIndex index,
  required int indexId,
}) async {
    
  try {
    await AudioBankMerger().merge(
      targetDb: db, 
      workerAlias: workerAlias, 
      index: index,
      indexId: indexId,
    );
  }
  catch (e) {
    print("Audio Merge Error: $e");
    rethrow;
  }
}