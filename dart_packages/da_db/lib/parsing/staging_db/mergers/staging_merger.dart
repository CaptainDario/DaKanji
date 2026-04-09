import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/index/yomitan_index.dart';



/// Defines the interface that each merger must implement to merge a specific
/// file type (e.g. TermBank, KanjiBank, example, etc.) from the worker DB into
/// the main DB.
abstract class StagingMerger {
  /// Merges the specific data type (e.g. Terms, Kanji) from the worker DB.
  Future<void> merge({
    /// database to merge into
    required DaDb targetDb,
    /// The alias of the attached worker DB (e.g. 'worker_1')
    required String workerAlias,
    /// The yomitan index data of this dictionary
    required YomitanIndex index,
    /// the id of this index entry in the index table
    required int indexId,
  });
}