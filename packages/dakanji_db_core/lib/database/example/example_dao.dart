// Package imports:
import "dart:convert";

import "/database/example/example_entry.dart";
import "/database/example/example_tables.dart";
import 'package:language_processing/iso/iso_table.dart';
import "package:drift/drift.dart";

// Project imports:
import "../dakanji_db.dart";

part 'example_dao.g.dart';



// Dao class that contains all queries related to the `ExampleTable`
@DriftAccessor(
  tables: [
    ExampleTable, ExampleTranslationTable
  ],
)
class ExampleDao extends DatabaseAccessor<DaKanjiDB> with _$ExampleDaoMixin {
  
  ExampleDao(super.db);

  Future<List<ExampleEntry>> searchExamples(
    String query,
    List<Iso639_1> languages,
    {
      int limit=-1,
      int offset=0
    }) async {

    // check laguages are set and parse 
    List<String> langs = languages.map((e) => e.name,).toList();

    final ftsResults = (await db.example_fts_search_drift(
      query, jsonEncode(langs), limit, offset).get());
    List<ExampleEntry> entries = ftsResults.map((e) => 
      ExampleEntry.fromExampleFtsSearchSql(e)
    ).toList();

    return entries;

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

  /// Get the maximum id of the [ExampleTranslationTable]
  Future<int> maxExampleTranslationId() async {
    
    final query = await (selectOnly(exampleTranslationTable)
        ..addColumns([exampleTranslationTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(exampleTranslationTable.id.max()) ?? 0;

  }

}
