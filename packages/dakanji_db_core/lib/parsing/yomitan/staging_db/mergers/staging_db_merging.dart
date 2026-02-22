import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/util/db_optimization.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/mergers/kanji_bank_v3_merger.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/mergers/kanji_meta_bank_v3_merger.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/mergers/staging_merger.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/mergers/tag_bank_v3_merger.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/mergers/term_bank_v3_merger.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/mergers/term_meta_bank_v3_merger.dart';


/// Merges the [workerDbPath] staging database into the main [db] by attaching
/// the worker DB, running each merger, and then detaching the worker DB.
/// The [indexId] is assigned to all merged entries to link them to the correct
/// dictionary.
Future<void> mergeStagingDb({
  required DaKanjiDB db,
  required String workerDbPath,
  required int indexId,
}) async {
  
  final workerAlias = 'worker_${DateTime.now().millisecondsSinceEpoch}';
  
  await optimizeTargetDbForMerge(db);

  await db.customStatement('ATTACH DATABASE ? AS $workerAlias', [workerDbPath]);

  final mergers = <StagingMerger>[
    TagBankMerger(),
    TermBankV3Merger(),
    TermMetaBankV3Merger(),
    KanjiBankV3Merger(),
    KanjiMetaBankV3Merger()
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
  }
  catch (e) {
    print("Merge Error: $e");
    rethrow;
  }
  finally {
    await db.customStatement('DETACH DATABASE $workerAlias');
    await restoreTargetDbAfterMerge(  db);
  }
}