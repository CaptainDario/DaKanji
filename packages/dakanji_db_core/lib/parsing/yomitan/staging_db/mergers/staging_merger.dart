import 'package:dakanji_db_core/database/dakanji_db.dart';

abstract class StagingMerger {
  /// Merges the specific data type (e.g. Terms, Kanji) from the worker DB.
  Future<void> merge({
    required DaKanjiDB targetDb,
    required String workerAlias, // The alias of the attached worker DB (e.g. 'worker_1')
    required int indexId,
    required bool addJsonDefs,
  });
}