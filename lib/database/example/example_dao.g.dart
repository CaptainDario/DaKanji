// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_dao.dart';

// ignore_for_file: type=lint
mixin _$ExampleDaoMixin on DatabaseAccessor<DaKanjiDB> {
  $ExampleTableTable get exampleTable => attachedDatabase.exampleTable;
  $LanguageCodeTableTable get languageCodeTable =>
      attachedDatabase.languageCodeTable;
  $ExampleTranslationTableTable get exampleTranslationTable =>
      attachedDatabase.exampleTranslationTable;
  $ExampleTranslationRelationsTableTable get exampleTranslationRelationsTable =>
      attachedDatabase.exampleTranslationRelationsTable;
  ExampleView get exampleView => attachedDatabase.exampleView;
  ExampleFts get exampleFts => attachedDatabase.exampleFts;
  Selectable<ExampleFtsSearchResult> example_fts_search(
    String query,
    List<String?> languageCodes,
    int limit,
    int offset,
  ) {
    var $arrayStartIndex = 4;
    final expandedlanguageCodes = $expandVar(
      $arrayStartIndex,
      languageCodes.length,
    );
    $arrayStartIndex += languageCodes.length;
    return customSelect(
      'SELECT EDV.id, EDV.example_sentence, \'[\' || COALESCE(GROUP_CONCAT(DISTINCT CASE WHEN EDV.example_translation IS NOT NULL THEN json_object(\'translation\', EDV.example_translation, \'languageCode\', EDV.language_code) END), \'\') || \']\' AS translations FROM example_view AS EDV INNER JOIN example_fts AS FTS ON FTS."rowid" = EDV.id WHERE example_fts MATCH ?1 AND(EDV.language_code IN ($expandedlanguageCodes) OR EDV.translation_id IS NULL)GROUP BY EDV.id LIMIT ?2 OFFSET ?3',
      variables: [
        Variable<String>(query),
        Variable<int>(limit),
        Variable<int>(offset),
        for (var $ in languageCodes) Variable<String>($),
      ],
      readsFrom: {
        exampleFts,
        exampleTable,
        exampleTranslationRelationsTable,
        exampleTranslationTable,
        languageCodeTable,
      },
    ).map(
      (QueryRow row) => ExampleFtsSearchResult(
        id: row.read<int>('id'),
        exampleSentence: row.read<String>('example_sentence'),
        translations: row.read<String>('translations'),
      ),
    );
  }
}

class ExampleFtsSearchResult {
  final int id;
  final String exampleSentence;
  final String translations;
  ExampleFtsSearchResult({
    required this.id,
    required this.exampleSentence,
    required this.translations,
  });
}
