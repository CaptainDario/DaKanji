// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_dao.dart';

// ignore_for_file: type=lint
mixin _$ExampleDaoMixin on DatabaseAccessor<DaKanjiDB> {
  $ExampleTableTable get exampleTable => attachedDatabase.exampleTable;
  ExampleFts get exampleFts => attachedDatabase.exampleFts;
  $LanguageCodeTableTable get languageCodeTable =>
      attachedDatabase.languageCodeTable;
  $ExampleTranslationTableTable get exampleTranslationTable =>
      attachedDatabase.exampleTranslationTable;
  $ExampleTranslationRelationsTableTable get exampleTranslationRelationsTable =>
      attachedDatabase.exampleTranslationRelationsTable;
  $ExampleViewView get exampleView => attachedDatabase.exampleView;
  Selectable<ExampleFtsSearchSqlResult> example_fts_search_sql(
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
      'SELECT ET.id, ET.example_sentence, GROUP_CONCAT(ETT.example_translation, \'|||\') AS translations, GROUP_CONCAT(LCT.language_code, \'|||\') AS language_codes FROM example_table AS ET INNER JOIN example_fts AS FTS ON FTS."rowid" = ET.id LEFT JOIN example_translation_relations_table AS ETRT ON ETRT.example_id = ET.id LEFT JOIN example_translation_table AS ETT ON ETRT.translation_id = ETT.id LEFT JOIN language_code_table AS LCT ON LCT.id = ETT.language_code_id WHERE example_fts MATCH ?1 AND(LCT.language_code IN ($expandedlanguageCodes) OR ETT.id IS NULL)GROUP BY ET.id LIMIT ?2 OFFSET ?3',
      variables: [
        Variable<String>(query),
        Variable<int>(limit),
        Variable<int>(offset),
        for (var $ in languageCodes) Variable<String>($),
      ],
      readsFrom: {
        exampleTable,
        exampleTranslationTable,
        languageCodeTable,
        exampleFts,
        exampleTranslationRelationsTable,
      },
    ).map(
      (QueryRow row) => ExampleFtsSearchSqlResult(
        id: row.read<int>('id'),
        exampleSentence: row.read<String>('example_sentence'),
        translations: row.readNullable<String>('translations'),
        languageCodes: row.readNullable<String>('language_codes'),
      ),
    );
  }
}

class ExampleFtsSearchSqlResult {
  final int id;
  final String exampleSentence;
  final String? translations;
  final String? languageCodes;
  ExampleFtsSearchSqlResult({
    required this.id,
    required this.exampleSentence,
    this.translations,
    this.languageCodes,
  });
}
