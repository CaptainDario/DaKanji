import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/mergers/staging_merger.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/mergers/term_bank_v3_merger.dart';


/// Merges the [workerDbPath] staging database into the main [db] by attaching
/// the worker DB, running each merger, and then detaching the worker DB.
/// The [indexId] is assigned to all merged entries to link them to the correct
/// dictionary.
Future<void> mergeStagingDb({
  required DaKanjiDB db,
  required String workerDbPath,
  required int indexId,
  required bool addJsonDefs,
}) async {
  
  final workerAlias = 'worker_${DateTime.now().millisecondsSinceEpoch}';
  
  // 1. Disable disk sync (Speed)
  await db.customStatement('PRAGMA synchronous = OFF;');
  // 2. Disable Foreign Keys (Speed - Trusts worker data structure)
  await db.customStatement('PRAGMA foreign_keys = OFF;');

  await db.customStatement('ATTACH DATABASE ? AS $workerAlias', [workerDbPath]);

  final mergers = <StagingMerger>[
    TermBankV3Merger(addJsonDefs: addJsonDefs),
  ];

  try {
    await db.transaction(() async {
      for (final merger in mergers) {
        await merger.merge(
          targetDb: db, 
          workerAlias: workerAlias, 
          indexId: indexId, 
        );
      }
    });
  } catch (e) {
    print("Merge Error: $e");
    rethrow;
  } finally {
    await db.customStatement('DETACH DATABASE $workerAlias');
    // Restore Foreign Keys
    await db.customStatement('PRAGMA foreign_keys = ON;');
    // Restore Synchronous
    await db.customStatement('PRAGMA synchronous = NORMAL;');
  }
}