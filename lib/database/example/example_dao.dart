// Package imports:
import "package:dakanji_db/database/example/example_entry.dart";
import "package:dakanji_db/database/example/example_tables.dart";
import "package:dakanji_db/database/example/example_view.dart";
import "package:dakanji_db/iso/iso_table.dart";
import "package:drift/drift.dart";

// Project imports:
import "../dakanji_db.dart";

part 'example_dao.g.dart';



// Dao class that contains all queries related to the `ExampleTable`
@DriftAccessor(
  tables: [
    ExampleTable, ExampleTranslationTable
  ],
  views: [
    ExampleView
  ],
  include: {
    'example_queries.drift',
  }
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
    assert (languages.isNotEmpty);
    List<String> langs = languages.map((e) => e.name,).toList();

    final ftsResults = await example_fts_search_sql(
      query, langs, limit, offset).get();
    List<ExampleEntry> entries = ftsResults.map((e) => 
      ExampleEntry.fromExampleFtsSearchSql(e)
    ).toList();

    return entries;

  }

  Future getExampleById(int id) async {

    int m = await maxExampleId();
    var exampleQuery = (select(exampleTable)
      ..where((tbl) => tbl.id.equals(m)));

    // get the actual text
    var example = await exampleQuery.getSingle();
    return example.exampleSentenceTokenized;

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
