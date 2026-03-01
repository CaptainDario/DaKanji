import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/staging_db/mergers/staging_merger.dart';
import 'package:da_db/parsing/yomitan/staging_db/mergers/kanji_bank_v3_merger.dart';
import 'package:da_db/parsing/yomitan/staging_db/mergers/kanji_meta_bank_v3_merger.dart';
import 'package:da_db/parsing/yomitan/staging_db/mergers/tag_bank_v3_merger.dart';
import 'package:da_db/parsing/yomitan/staging_db/mergers/term_bank_v3_merger.dart';
import 'package:da_db/parsing/yomitan/staging_db/mergers/term_meta_bank_v3_merger.dart';


/// Merges the [workerAlias] staging database into the main [db] by attaching
/// the worker DB, running each merger, and then detaching the worker DB.
/// The [indexId] is assigned to all merged entries to link them to the correct
/// dictionary.
Future<void> mergeStagingDb({
  required DaDb db,
  required String workerAlias,
  required int indexId,
}) async {
  
  final mergers = <StagingMerger>[
    TagBankMerger(),
    TermBankV3Merger(),
    TermMetaBankV3Merger(),
    KanjiBankV3Merger(),
    KanjiMetaBankV3Merger()
  ];

  try {
    for (final merger in mergers) {
      await merger.merge(
        targetDb: db, 
        workerAlias: workerAlias, 
        indexId: indexId,
      );
    }
  }
  catch (e) {
    print("Merge Error: $e");
    rethrow;
  }
}