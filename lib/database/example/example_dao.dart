// Package imports:
import "package:dakanji_db/database/example/example_entry.dart";
import "package:dakanji_db/database/example/example_entry_translation.dart";
import "package:dakanji_db/database/example/example_tables.dart";
import "package:dakanji_db/database/example/example_view.dart";
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
    'example_fts5.drift'
  }
)
class ExampleDao extends DatabaseAccessor<DaKanjiDB> with _$ExampleDaoMixin {
  
  ExampleDao(super.db);

  Future<List<ExampleEntry>> searchExamples(String query) async {

    List<ExampleTableData> results = await customSelect(
      'SELECT T.* FROM example_table AS T '
      'INNER JOIN example_fts AS F ON F.rowid = T.id '
      'WHERE example_fts MATCH :query',
      // The variables map will be used to expand the :query parameter.
      variables: [Variable.withString(query)],
      // We need to tell drift how to parse the result set.
      readsFrom: {exampleTable, exampleFts},
    ).map((row) => exampleTable.map(row.data)).get();
    List<int> ids = results.map((e) => e.id).toList();

    (select(exampleTable)
    ..join([
      innerJoin(exampleFts, exampleFts.rowId.equalsExp(exampleTable.id)),
    ])
    ..where((_) => exampleFts.match(query)));

    final _query = (selectOnly(exampleTable)
      .join([
        // join translations via its relation table
        innerJoin(
          exampleTranslationRelationsTable,
          exampleTable.id.equalsExp(exampleTranslationRelationsTable.exampleId)
        ),
        innerJoin(
          exampleTranslationTable,
          exampleTranslationRelationsTable.translationId.equalsExp(exampleTranslationTable.id)
        )
      ])
    )
    
    ..groupBy([exampleTable.id]) 
    ..addColumns([
      exampleTable.exampleSentence,
      
      exampleTranslationTable.exampleTranslation.groupConcat(distinct: true)
      
    ]);
    final joined = await _query.get();

    print(joined);

    return results.map((e) => ExampleEntry(
      example: e.exampleSentence,
      tokenizedExample: e.exampleSentenceTokenized,
      translations: []
    )).toList();

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
