// Package imports:
import '/database/dakanji_db_dao.dart';
import '/database/example/example_dao.dart';
import '/database/example/example_relation_tables.dart';
import '/database/example/example_tables.dart';
import '/database/general_tables/language_code_dao.dart';
import '/database/general_tables/language_code_table.dart';
import '/database/term/term_bank_v3_dao.dart';
import '/database/term/term_bank_v3_relation_tables.dart';
import '/database/term/term_bank_v3_tables.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:universal_io/io.dart';

// Project imports:
import '/database/general_tables/kanji_dao.dart';
import '/database/general_tables/kanji_tables.dart';
import '/database/general_tables/definition_dao.dart';
import '/database/general_tables/definition_tables.dart';
import '/database/general_tables/reading_dao.dart';
import '/database/general_tables/reading_tables.dart';
import '/database/general_tables/term_dao.dart';
import '/database/general_tables/term_tables.dart';
import '/database/index/index_dao.dart';
import '/database/index/index_tables.dart';
import '/database/kanji/kanji_bank_v3_dao.dart';
import '/database/kanji/kanji_bank_v3_relation_tables.dart';
import '/database/kanji/kanji_bank_v3_tables.dart';
import '/database/kanji_meta/kanji_meta_bank_v3_dao.dart';
import '/database/kanji_meta/kanji_meta_bank_v3_tables.dart';
import '/database/kanji_vg/kanji_vg_dao.dart';
import '/database/kanji_vg/kanji_vg_tables.dart';
import '/database/radicals/radical_dao.dart';
import '/database/radicals/radical_relation_tables.dart';
import '/database/radicals/radical_tables.dart';
import '/database/tag/tag_bank_v3_dao.dart';
import '/database/tag/tag_bank_v3_tables.dart';
import '/database/term_meta/term_meta_bank_relation_tables.dart';
import '/database/term_meta/term_meta_bank_v3_dao.dart';
import '/database/term_meta/term_meta_bank_v3_tables.dart';
// this is NECCESSARY
// ignore: unused_import
import '/helper/zlib_text_converter.dart';

part 'dakanji_db.g.dart';



@DriftDatabase(
  tables: [
    KanjiTable, TermTable, ReadingTable, DefinitionTable, LanguageCodeTable,

    RadicalsTable, RadicalKanjiRelationsTable,
    KanjiVGTable,

    IndexTable,

    TagBankV3Table,

    KanjiBankV3Table,
    KanjiBankV3KunyomiReadingRelationsTable, KanjiBankV3OnyomiReadingRelationsTable,
    KanjiBankV3TagsKanjiRelationsTable,
    KanjiBankV3DefinitionsKanjiRelationsTable,
    KanjiBankV3StatsTable, KanjiBankV3StatKanjiRelationsTable,
    KanjiBankV3StatNamesTable, KanjiBankV3StatValuesTable,

    KanjiMetaBankV3Table, KanjiMetaBankV3TypeTable,
    
    TermBankV3Table,
    TermBankV3DefinitionTagsTable, TermBankV3DefinitionTagRelationsTable,
    TermBankV3RuleIdentifierTable, TermBankV3RuleIdentifierRelationsTable,
    TermBankV3DefinitionsRelationsTable,
    TermBankV3DefinitionJsonTable,
    TermBankV3TagBankRelationsTable,

    TermMetaBankV3Table,
    TermMetaBankV3TypeTable, 
    TermMetaBankV3PitchTable, TermMetaBankV3PitchRelationsTable, TermMetaBankV3PitchTagRelationsTable,
    TermMetaBankV3IpaTable, TermMetaBankV3IpaRelationsTable, TermMetaBankV3IpaTagRelationsTable,
    TermMetaBankV3TagTable,

    ExampleTable,
    ExampleTranslationTable, ExampleTranslationTable,
    ExampleTranslationRelationsTable
  ],
  daos: [
    DaKanjiDBDao,
    KanjiDao, TermDao, ReadingDao, DefinitionDao, LanguageCodeDao,
    RadicalDao, KanjiVGDao,
    IndexDao, TagBankV3Dao,
    KanjiBankV3Dao, KanjiMetaBankV3Dao,
    TermBankV3Dao,
    TermMetaBankV3Dao,
    ExampleDao
  ],
  views: [

  ],
  include: {
    'example/example_fts5_table.drift', 'example/example_views.drift', 'example/example_queries.drift',
    'kanji/kanji_bank_v3_views.drift', 'kanji/kanji_bank_v3_queries.drift',
    'term/term_bank_v3_views.drift', 'term/term_bank_v3_queries.drift',
    'dakanji_db_stat_queries.drift'
  }
)
class DaKanjiDB extends _$DaKanjiDB {
  // After generating code, this class needs to define a schemaVersion getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/getting-started/#open
  DaKanjiDB({
    this.path,
    QueryExecutor? executor,
  }) : super(executor ?? _openConnection(path!));

  @override
  int get schemaVersion => 1;
  /// The path of this db
  String? path;

  static QueryExecutor _openConnection(String path) {
    return NativeDatabase.createInBackground(
      File(path),
      setup: (database) {
        // This is important, as accessing the database across threads otherwise
        // causes "database locked" errors.
        // With write-ahead logging (WAL) enabled, a single writer and multiple
        // readers can operate on the database in parallel.
        //database.execute('pragma journal_mode = WAL;');
      },
      readPool: 6
    );
  }

  Future<List<GetMbSizesResult>> getDbStats() async {
    return await get_mb_sizes().get();
  }

  /// **WARNING**: This closes the database and DELETES the file
  Future deleteDB() async {

    await close();
    File file = File(path!);
    if(file.existsSync()){
      file.deleteSync();
    }

  }

  /// **WARNING**: This DELETES all contents of the db
  Future clearDB() async {
    await transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }

}
