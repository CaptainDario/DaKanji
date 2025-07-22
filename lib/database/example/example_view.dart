import 'package:dakanji_db/database/example/example_relation_tables.dart';
import 'package:dakanji_db/database/example/example_tables.dart';
import 'package:drift/drift.dart';



abstract class ExampleView extends View {
  // This view now needs to know about all three tables involved.
  ExampleTable get exampleTable;
  ExampleTranslationTable get exampleTranslationTable;
  ExampleTranslationRelationsTable get exampleTranslationRelationsTable;

  // The columns you want in your final view are defined as expressions.
  // These are sourced from the original tables.
  Expression<int> get exampleId => exampleTable.id;
  Expression<String> get sentence => exampleTable.exampleSentence;
  Expression<String> get sentenceTokenized => exampleTable.exampleSentenceTokenized;
  Expression<String> get exampleTranslation => exampleTranslationTable.exampleTranslation;
  Expression<int> get languageCodeId => exampleTranslationTable.languageCodeId;

  @override
  Query as() =>
    // The query now performs a double join through the relations table.
    select([
      exampleId,
      sentence,
      sentenceTokenized,
      exampleTranslation,
      languageCodeId,
    ]).from(exampleTable).join([
      // 1. Join ExampleTable to the relations table using the example's ID.
      innerJoin(
        exampleTranslationRelationsTable,
        exampleTranslationRelationsTable.exampleId.equalsExp(exampleTable.id),
      ),
      // 2. Join the relations table to the translation table using the translation's ID.
      innerJoin(
        exampleTranslationTable,
        exampleTranslationTable.id.equalsExp(exampleTranslationRelationsTable.translationId),
      ),
    ]);
  
}