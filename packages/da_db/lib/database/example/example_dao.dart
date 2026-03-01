
import "package:drift/drift.dart";
import 'package:language_processing/language_processing.dart';

import "/database/example/example_entry.dart";
import "/database/example/example_tables.dart";
import "../da_db.dart";

part 'example_dao.g.dart';



// Dao class that contains all queries related to the `ExampleTable`
@DriftAccessor(
  tables: [
    ExampleTable, ExampleSentenceTable,
    ExampleAudioTable,
  ],
)
class ExampleDao extends DatabaseAccessor<DaDb> with _$ExampleDaoMixin {
  
  ExampleDao(super.db);

  Future<List<ExampleEntry>> searchExamples(
    String query,
    List<Iso639_3> languages, 
    {
      int limit = -1,
      int offset = 0,
    }
  ) async {
    final langCodes = languages.map((l) => l.name).toList();

    // Phase 1: Search IDs (Quotes are handled in the .drift file)
    final finalQuery = db.languageProcessor.parse(query, ProcessorOptions())
      .segments.nonNulls.join(" ");
    final matchingIds = await db.searchExampleIds(
      finalQuery, langCodes, limit, offset).get();

    if (matchingIds.isEmpty) return [];

    // Phase 2: Fetch and Hydrate
    final viewRows = await db.getExamplesByIds(matchingIds).get();

    // Sort back to FTS rank
    final rowMap = {for (final row in viewRows) row.id: row};
    
    return matchingIds
      .where((id) => rowMap.containsKey(id))
      .map((id) => ExampleEntry.fromViewData(rowMap[id]!))
      .toList();
  }

  // ---------------------------------------------------------------------------
  /// Get the maximum id of the [ExampleTable]
  Future<int> maxExampleId() async {
    
    final query = await (selectOnly(exampleTable)
        ..addColumns([exampleTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(exampleTable.id.max()) ?? 0;

  }

  /// Get the maximum id of the [exampleSentenceTable]
  Future<int> maxExampleSentenceId() async {
    
    final query = await (selectOnly(exampleSentenceTable)
        ..addColumns([exampleSentenceTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(exampleSentenceTable.id.max()) ?? 0;

  }

  /// Get the maximum id of the [exampleAudioTable]
  Future<int> maxExampleAudioTableId() async {
    
    final query = await (selectOnly(exampleAudioTable)
        ..addColumns([exampleAudioTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(exampleAudioTable.id.max()) ?? 0;

  }

}
