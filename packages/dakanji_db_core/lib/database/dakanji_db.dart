
import 'package:dakanji_db_core/data/dictionary_types.dart';
import 'package:dakanji_db_core/database/audio/audio_dao.dart';
import 'package:dakanji_db_core/database/audio/audio_relation_tables.dart';
import 'package:dakanji_db_core/database/audio/audio_tables.dart';
import 'package:dakanji_db_core/database/db_queries/db_queries_dao.dart';
import 'package:dakanji_db_core/database/general_tables/media_dao.dart';
import 'package:dakanji_db_core/database/general_tables/media_tables.dart';
import 'package:dakanji_db_core/delete/deletion_dao.dart';
import 'package:dakanji_sqlite_extensions/dakanji_sqlite_extensions.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/native_assets.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:universal_io/io.dart';

import '/database/dakanji_db_dao.dart';
import '/database/example/example_dao.dart';
import '/database/example/example_relation_tables.dart';
import '/database/example/example_tables.dart';
import '/database/general_tables/definition_dao.dart';
import '/database/general_tables/definition_tables.dart';
import '/database/general_tables/kanji_dao.dart';
import '/database/general_tables/kanji_tables.dart';
import '/database/general_tables/language_code_dao.dart';
import '/database/general_tables/language_code_table.dart';
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
import '/database/term/term_bank_v3_dao.dart';
import '/database/term/term_bank_v3_relation_tables.dart';
import '/database/term/term_bank_v3_tables.dart';
import '/database/term_meta/term_meta_bank_relation_tables.dart';
import '/database/term_meta/term_meta_bank_v3_dao.dart';
import '/database/term_meta/term_meta_bank_v3_tables.dart';
import '/helper/zlib_text_converter_io.dart';   // neccessary for drift generator
// ignore: unused_import
import '../helper/sql_json_converter.dart'; // neccessary for drift generator
import 'audio_source_list/audio_source_list_tables.dart';

part 'dakanji_db.g.dart';

@DriftDatabase(
  tables: [
    AudioSourceListTable,
    KanjiTable, TermTable, ReadingTable, MediaTable,
    DefinitionTable, TermBankV3DefinitionJsonTable, LanguageCodeTable,

    AudioTable, AudioTable_X_TermTable,

    RadicalsTable, Radical_X_KanjiRelationsTable,
    KanjiVGTable,

    IndexTable,

    TagBankV3Table,

    KanjiBankV3Table,
    KanjiBankV3_X_KunyomiReadingTable, KanjiBankV3_X_OnyomiReadingTable,
    KanjiBankV3_X_TagBankV3Table,
    KanjiBankV3_X_DefinitionTable,
    KanjiBankV3StatsTable, KanjiBankV3_X_KanjiBankV3StatsTable,
    KanjiBankV3StatNamesTable, KanjiBankV3StatValuesTable,

    KanjiMetaBankV3Table, KanjiMetaBankV3TypeTable,
    
    TermBankV3Table,
    TermBankV3_X_DefinitionTagTable,
    TermBankV3RuleIdentifierTable, TermBankV3_X_RuleIdentifierTable,
    TermBankV3_X_DefinitionTable,
    TermBankV3_X_TagBankTable,

    TermMetaBankV3Table,
    TermMetaBankV3TypeTable, 
    TermMetaBankV3PitchTable, TermMetaBankV3_X_PitchTable, 
    TermMetaBankV3IpaTable_X_TagBankV3Table,
    TermMetaBankV3IpaTable, TermMetaBankV3_X_IpaTable, 
    TermMetaBankV3PitchTable_X_TagBankV3Table,

    ExampleTable,
    ExampleTranslationTable,
    ExampleTable_X_ExampleTranslationTable,
  ],
  daos: [
    DaKanjiDBDao,
    KanjiDao, TermDao, ReadingDao, DefinitionDao, LanguageCodeDao,
    AudioDao, MediaDao,
    RadicalDao, KanjiVGDao,
    IndexDao, TagBankV3Dao,
    KanjiBankV3Dao, KanjiMetaBankV3Dao,
    TermBankV3Dao,
    TermMetaBankV3Dao,
    ExampleDao,
    DBQueriesDao,
    DeletionDao,
  ],
  views: [

  ],
  include: {
    'kanji_vg/kanji_vg_queries.drift',

    'index/index_views.drift',
    'tag/tag_bank_v3_views.drift',

    'example/example_fts5_table.drift', 'example/example_views.drift', 'example/example_queries.drift',
    //'general_tables/reading_spellfix_table.drift',
    'general_tables/hiragana_spellfix_cost.drift',
    'audio/audio_views.drift', 'audio/audio_queries.drift',
    
    'kanji/kanji_bank_v3_views.drift', 'kanji/kanji_bank_v3_queries.drift',
    'kanji_meta/kanji_meta_bank_v3_views.drift', 'kanji_meta/kanji_meta_bank_v3_queries.drift',

    'term_meta/term_meta_bank_v3_views.drift', 'term_meta/term_meta_bank_v3_queries.drift',
    'term/term_bank_v3_views.drift', 'term/term_bank_v3_queries.drift',

    'db_queries/stat_queries.drift',

    'db_queries/dictionary_search/dictionary_search_queries.drift',
    'db_queries/dictionary_search/dictionary_search_fts_tables.drift',

    'db_queries/kanji_dictionary_search/kanji_dictionary_search_queries.drift',
    'db_queries/kanji_dictionary_search/kanji_dictionary_search_views.drift',
  }
)
class DaKanjiDB extends _$DaKanjiDB {

  bool inMemory;

  DaKanjiDB({
    this.dbPath,
    QueryExecutor? executor,
    required this.inMemory,
  }) : super(executor ?? _openConnection(dbPath!, inMemory));

  @override
  int get schemaVersion => 1;
  /// The path of this db
  String? dbPath;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        // First, create all the tables defined in the @DriftDatabase annotation
        await m.createAll();

        // Init data tables
        await populdate_fts_data_types();
        await populateHiraganaSpellfixCostTable();
      },
    );
  }
  
  static QueryExecutor _openConnection(String path, bool inMemory) {

    if(inMemory) {
      return NativeDatabase.memory(
        sqlite3: loadExtensions,
        setup: setupDb,
      );
    }

    QueryExecutor qe = NativeDatabase.createInBackground(
      File(path),
      sqlite3: loadExtensions,
      setup: setupDb,
      readPool: 3 // each dictionary search query runs 3 differen queries
    );

    return qe;
  }

  Future<List<GetMbSizesDriftResult>> getDbStats() async {
    return await get_mb_sizes_drift().get();
  }

  /// **WARNING**: This closes the database and DELETES the file
  Future deleteDB() async {

    await close();
    File file = File(dbPath!);
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

void setupDb (Database database) {
  // This is important, as accessing the database across threads otherwise
  // causes "database locked" errors.
  // With write-ahead logging (WAL) enabled, a single writer and multiple
  // readers can operate on the database in parallel.
  database.execute('PRAGMA journal_mode = WAL;');
}

Sqlite3 loadExtensions() {

  sqlite3Native.loadSqliteVectorExtension();
  return sqlite3Native;
}