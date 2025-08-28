// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji_bank_v3_dao.dart';

// ignore_for_file: type=lint
mixin _$KanjiBankV3DaoMixin on DatabaseAccessor<DaKanjiDB> {
  $KanjiTableTable get kanjiTable => attachedDatabase.kanjiTable;
  $IndexTableTable get indexTable => attachedDatabase.indexTable;
  $KanjiBankV3TableTable get kanjiBankV3Table =>
      attachedDatabase.kanjiBankV3Table;
  $ReadingTableTable get readingTable => attachedDatabase.readingTable;
  $KanjiBankV3OnyomiReadingRelationsTableTable
  get kanjiBankV3OnyomiReadingRelationsTable =>
      attachedDatabase.kanjiBankV3OnyomiReadingRelationsTable;
  $KanjiBankV3KunyomiReadingRelationsTableTable
  get kanjiBankV3KunyomiReadingRelationsTable =>
      attachedDatabase.kanjiBankV3KunyomiReadingRelationsTable;
  $TagBankV3TableTable get tagBankV3Table => attachedDatabase.tagBankV3Table;
  $KanjiBankV3TagsKanjiRelationsTableTable
  get kanjiBankV3TagsKanjiRelationsTable =>
      attachedDatabase.kanjiBankV3TagsKanjiRelationsTable;
  $DefinitionTableTable get definitionTable => attachedDatabase.definitionTable;
  $KanjiBankV3DefinitionsKanjiRelationsTableTable
  get kanjiBankV3DefinitionsKanjiRelationsTable =>
      attachedDatabase.kanjiBankV3DefinitionsKanjiRelationsTable;
  $KanjiBankV3StatNamesTableTable get kanjiBankV3StatNamesTable =>
      attachedDatabase.kanjiBankV3StatNamesTable;
  $KanjiBankV3StatValuesTableTable get kanjiBankV3StatValuesTable =>
      attachedDatabase.kanjiBankV3StatValuesTable;
  $KanjiBankV3StatsTableTable get kanjiBankV3StatsTable =>
      attachedDatabase.kanjiBankV3StatsTable;
  $KanjiBankV3StatKanjiRelationsTableTable
  get kanjiBankV3StatKanjiRelationsTable =>
      attachedDatabase.kanjiBankV3StatKanjiRelationsTable;
  KanjiDetailsView get kanjiDetailsView => attachedDatabase.kanjiDetailsView;
  $TermTableTable get termTable => attachedDatabase.termTable;
  Selectable<KanjiBankV3SearchResult> kanji_bank_v3_search(String query) {
    return customSelect(
      'SELECT kanji, \'[\' || COALESCE(GROUP_CONCAT(DISTINCT \'"\' || onyomi_reading || \'"\'), \'\') || \']\' AS onyomis, \'[\' || COALESCE(GROUP_CONCAT(DISTINCT \'"\' || kunyomi_reading || \'"\'), \'\') || \']\' AS kunyomis, \'[\' || COALESCE(GROUP_CONCAT(DISTINCT json_object(\'id\', tag_id, \'name\', tag_name, \'category\', tag_category, \'sortingOrder\', tag_sorting_order, \'notes\', tag_notes, \'score\', tag_score)), \'\') || \']\' AS tags, \'[\' || COALESCE(GROUP_CONCAT(DISTINCT \'"\' || definition || \'"\'), \'\') || \']\' AS definitions, \'[\' || COALESCE(GROUP_CONCAT(DISTINCT json_object(\'name\', stat_name, \'value\', stat_value)), \'\') || \']\' AS stats FROM kanji_details_view WHERE kanji = ?1 GROUP BY kanji',
      variables: [Variable<String>(query)],
      readsFrom: {
        kanjiBankV3Table,
        kanjiTable,
        kanjiBankV3OnyomiReadingRelationsTable,
        readingTable,
        kanjiBankV3KunyomiReadingRelationsTable,
        kanjiBankV3TagsKanjiRelationsTable,
        tagBankV3Table,
        kanjiBankV3DefinitionsKanjiRelationsTable,
        definitionTable,
        kanjiBankV3StatKanjiRelationsTable,
        kanjiBankV3StatsTable,
        kanjiBankV3StatNamesTable,
        kanjiBankV3StatValuesTable,
      },
    ).map(
      (QueryRow row) => KanjiBankV3SearchResult(
        kanji: row.read<String>('kanji'),
        onyomis: row.read<String>('onyomis'),
        kunyomis: row.read<String>('kunyomis'),
        tags: row.read<String>('tags'),
        definitions: row.read<String>('definitions'),
        stats: row.read<String>('stats'),
      ),
    );
  }
}

class KanjiBankV3SearchResult {
  final String kanji;
  final String onyomis;
  final String kunyomis;
  final String tags;
  final String definitions;
  final String stats;
  KanjiBankV3SearchResult({
    required this.kanji,
    required this.onyomis,
    required this.kunyomis,
    required this.tags,
    required this.definitions,
    required this.stats,
  });
}
