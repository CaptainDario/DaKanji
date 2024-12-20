import 'package:dakanji_db/database/general_tables/kanji_dao.dart';
import 'package:dakanji_db/database/general_tables/kanji_tables.dart';
import 'package:dakanji_db/database/general_tables/reading_dao.dart';
import 'package:dakanji_db/database/general_tables/reading_tables.dart';
import 'package:dakanji_db/database/general_tables/term_dao.dart';
import 'package:dakanji_db/database/general_tables/term_tables.dart';
import 'package:dakanji_db/database/index/index_dao.dart';
import 'package:dakanji_db/database/index/index_tables.dart';
import 'package:dakanji_db/database/kanji/kanji_bank_v3_relation_tables.dart';
import 'package:dakanji_db/database/kanji/kanji_bank_v3_tables.dart';
import 'package:dakanji_db/database/kanji/kanji_bank_v3_dao.dart';
import 'package:dakanji_db/database/kanji_meta/kanji_meta_bank_v3_dao.dart';
import 'package:dakanji_db/database/kanji_meta/kanji_meta_bank_v3_tables.dart';
import 'package:dakanji_db/database/kanji_vg/kanji_vg_dao.dart';
import 'package:dakanji_db/database/kanji_vg/kanji_vg_tables.dart';
import 'package:dakanji_db/database/radicals/radical_dao.dart';
import 'package:dakanji_db/database/radicals/radical_relation_tables.dart';
import 'package:dakanji_db/database/radicals/radical_tables.dart';
import 'package:dakanji_db/database/tag/tag_bank_v3_dao.dart';
import 'package:dakanji_db/database/tag/tag_bank_v3_relation_tables.dart';
import 'package:dakanji_db/database/tag/tag_bank_v3_tables.dart';
import 'package:dakanji_db/database/term_meta/term_meta_bank_relation_tables.dart';
import 'package:dakanji_db/database/term_meta/term_meta_bank_v3_dao.dart';
import 'package:dakanji_db/database/term_meta/term_meta_bank_v3_tables.dart';
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';
import 'package:drift/native.dart';
import 'package:dakanji_db/helper/zlib_text_converter.dart';

part 'dakanji_db.g.dart';



@DriftDatabase(tables: [

    KanjiTable,
    TermTable,
    ReadingTable,

    RadicalsTable, RadicalKanjiRelationsTable,
    KanjiVGTable,

    IndexTable,

    TagBankV3Table,
    TagBankV3CategoryTable,
    TagBankV3TagCategoryRelationsTable,

    KanjiBankV3Table,
    KanjiBankV3KunyomiReadingRelationsTable, KanjiBankV3OnyomiReadingRelationsTable,
    KanjiBankV3TagsKanjiRelationsTable,
    KanjiBankV3MeaningsTable, KanjiBankV3MeaningsKanjiRelationsTable,
    KanjiBankV3StatsTable, KanjiBankV3StatKanjiRelationsTable,
    KanjiBankV3StatNamesTable, KanjiBankV3StatValuesTable,

    KanjiMetaBankV3Table, KanjiMetaBankV3TypeTable,
    
    TermMetaBankV3Table,
    TermMetaBankV3TypeTable, 
    TermMetaBankV3PitchTable, TermMetaBankV3PitchRelationsTable,
    TermMetaBankV3IpaTable, TermMetaBankV3IpaTagTable, TermMetaBankV3IpaRelationsTable
  ],
  daos: [
    KanjiDao, TermDao, ReadingDao,
    RadicalDao, KanjiVGDao,
    IndexDao, TagBankV3Dao,
    KanjiBankV3Dao, KanjiMetaBankV3Dao,
    TermMetaBankV3Dao
  ],
  
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

  /// **WARNING**: This closes the database and deletes ALL its content
  Future deleteDB() async {

    await close();
    File file = File(path!);
    if(file.existsSync()){
      file.deleteSync();
    }

  }

}