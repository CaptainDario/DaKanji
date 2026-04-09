import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/index/yomitan_index.dart';
import 'package:da_db/parsing/example/mergers/example_merger.dart';
import 'package:da_db/parsing/staging_db/mergers/staging_merger.dart';
import 'package:da_db/parsing/yomitan/staging_db/mergers/tag_bank_v3_merger.dart';


Future<void> mergeExampleStagingDb({
  required DaDb db,
  required String workerAlias,
  required YomitanIndex index,
  required int indexId,
}) async {
  final mergers = <StagingMerger>[
    TagBankMerger(),
    ExampleMerger(),
  ];

  try {
    await db.transaction(() async {
      for (final merger in mergers) {
        await merger.merge(
          targetDb: db, 
          workerAlias: workerAlias, 
          index: index,
          indexId: indexId,
        );
      }
    });
  }
  catch (e) {
    print("Example Merge Error: $e");
    rethrow;
  }
}