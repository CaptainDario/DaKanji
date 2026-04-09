
import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/data/frequency_mode.dart'; // neccessary for drift generator
import 'package:da_db/data/search_result_sort_order.dart';
import 'package:da_db/database/audio/audio_dao.dart';
import 'package:da_db/database/audio/audio_relation_tables.dart';
import 'package:da_db/database/audio/audio_tables.dart';
import 'package:da_db/database/audio_source_list/audio_source_list_dao.dart';
import 'package:da_db/database/audio_source_list/audio_source_list_tables.dart';
import 'package:da_db/database/da_db_dao.dart';
import 'package:da_db/database/db_queries/dictionary_search_dao.dart';
import 'package:da_db/database/db_queries/kanji_search_dao.dart';
import 'package:da_db/database/example/example_dao.dart';
import 'package:da_db/database/example/example_relation_tables.dart';
import 'package:da_db/database/example/example_tables.dart';
import 'package:da_db/database/general_tables/definition_dao.dart';
import 'package:da_db/database/general_tables/definition_tables.dart';
import 'package:da_db/database/general_tables/kanji_dao.dart';
import 'package:da_db/database/general_tables/kanji_tables.dart';
import 'package:da_db/database/general_tables/media_dao.dart';
import 'package:da_db/database/general_tables/media_tables.dart';
import 'package:da_db/database/general_tables/reading_dao.dart';
import 'package:da_db/database/general_tables/reading_tables.dart';
import 'package:da_db/database/general_tables/term_dao.dart';
import 'package:da_db/database/general_tables/term_tables.dart';
import 'package:da_db/database/index/index_dao.dart';
import 'package:da_db/database/index/index_tables.dart';
import 'package:da_db/database/kanji/kanji_bank_v3_dao.dart';
import 'package:da_db/database/kanji/kanji_bank_v3_relation_tables.dart';
import 'package:da_db/database/kanji/kanji_bank_v3_tables.dart';
import 'package:da_db/database/kanji_meta/kanji_meta_bank_v3_dao.dart';
import 'package:da_db/database/kanji_meta/kanji_meta_bank_v3_tables.dart';
import 'package:da_db/database/kanji_vg/kanji_vg_dao.dart';
import 'package:da_db/database/kanji_vg/kanji_vg_tables.dart';
import 'package:da_db/database/radicals/radical_dao.dart';
import 'package:da_db/database/radicals/radical_relation_tables.dart';
import 'package:da_db/database/radicals/radical_tables.dart';
import 'package:da_db/database/search_profiles/search_profile_tables.dart';
import 'package:da_db/database/search_profiles/search_profiles_dao.dart';
import 'package:da_db/database/stats/stat_tables.dart';
import 'package:da_db/database/tag/tag_bank_v3_dao.dart';
import 'package:da_db/database/tag/tag_bank_v3_tables.dart';
import 'package:da_db/database/term/term_bank_v3_dao.dart';
import 'package:da_db/database/term/term_bank_v3_relation_tables.dart';
import 'package:da_db/database/term/term_bank_v3_tables.dart';
import 'package:da_db/database/term_meta/term_meta_bank_relation_tables.dart';
import 'package:da_db/database/term_meta/term_meta_bank_v3_dao.dart';
import 'package:da_db/database/term_meta/term_meta_bank_v3_tables.dart';
import 'package:da_db/delete/deletion_dao.dart';
import 'package:da_db/util/data_converters/sort_order_converter.dart';
import 'package:da_db/util/data_converters/sql_json_converter.dart';   // neccessary for drift generator
import 'package:da_db/util/data_converters/sql_nullable_json_converter.dart';
import 'package:da_db/util/data_converters/zlib_text_converter_io.dart'; // neccessary for drift generator
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:language_processing/language_processing.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite_extensions/sqlite_extensions.dart';
import 'package:universal_io/io.dart';

part 'da_db.g.dart';



@DriftDatabase(
  tables: [
    AudioSourceListTable,
    KanjiTable, TermTable, ReadingTable, MediaTable,
    DefinitionTable, TermBankV3DefinitionJsonTable,

    AudioTable, AudioTable_X_TermTable,

    AudioSourceListTable,

    RadicalsTable, Radical_X_KanjiRelationsTable,
    KanjiVGTable,

    IndexTable,

    SearchProfilesTable,

    KanjiBankV3Table,
    KanjiBankV3_X_KunyomiReadingTable, KanjiBankV3_X_OnyomiReadingTable,
    KanjiBankV3_X_TagBankV3Table,
    KanjiBankV3_X_DefinitionTable,
    KanjiBankV3StatsTable, KanjiBankV3_X_KanjiBankV3StatsTable,

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

    TagBankV3Table,

    StatNameTable, StatTable, 

    ExampleTable, ExampleSentenceTable, ExampleAudioTable,

    ExampleTable_X_ExampleAudioTable, ExampleSentenceTable_X_TermTable,
    ExampleTable_X_StatTable, ExampleAudioTable_X_StatTable,
    ExampleTable_X_TagBankTable, ExampleAudioTable_X_TagBankTable
  ],
  daos: [
    DaDbDao,
    KanjiDao, TermDao, ReadingDao, DefinitionDao,
    AudioDao, AudioSourceListDao, MediaDao,
    RadicalDao, KanjiVGDao,
    IndexDao, TagBankV3Dao,
    SearchProfilesDao,
    KanjiBankV3Dao, KanjiMetaBankV3Dao,
    TermBankV3Dao,
    TermMetaBankV3Dao,
    ExampleDao,
    DictionarySearchDao, KanjiSearchDao,
    DeletionDao,
  ],
  views: [

  ],
  include: {
    'kanji_vg/kanji_vg_queries.drift',

    'index/index_views.drift',
    'tag/tag_bank_v3_views.drift',

    'example/example_fts5_table.drift', 'example/example_views.drift', 'example/example_queries.drift',
    'audio/audio_views.drift', 'audio/audio_queries.drift',
    
    'kanji/kanji_bank_v3_views.drift', 'kanji/kanji_bank_v3_queries.drift',
    'kanji_meta/kanji_meta_bank_v3_views.drift', 'kanji_meta/kanji_meta_bank_v3_queries.drift',

    'term_meta/term_meta_bank_v3_views.drift', 'term_meta/term_meta_bank_v3_queries.drift',
    'term/term_bank_v3_views.drift', 'term/term_bank_v3_queries.drift',

    'stats/stat_views.drift',

    'db_queries/db_stat_queries.drift', 

    'db_queries/dictionary_search/dictionary_search_queries.drift',
    'db_queries/dictionary_search/dictionary_search_fts_tables.drift',

    'db_queries/kanji_dictionary_search/kanji_dictionary_search_queries.drift',
  }
)
class DaDb extends _$DaDb {

  bool inMemory;

  LanguageProcessor languageProcessor;

  DaDb({
    this.dbPath,
    QueryExecutor? executor,
    required this.inMemory,
    required this.languageProcessor,
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
        //await populateHiraganaSpellfixCostTable();
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
      readPool: 4 // each dictionary search query runs 4 differen queries
    );

    return qe;
  }

  Future<List<GetDbMbSizesDriftResult>> getDbStats() async {
    return await get_db_mb_sizes_drift().get();
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

  sqlite3.loadSqliteVectorExtension();
  sqlite3.loadSqliteBetterTrigramExtension();
  sqlite3.loadSqliteCrsqliteExtension();
  return sqlite3;
}