import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/util/import_context.dart';



class KanjiMetaBankV3ParserContext extends ParserContext {

  Map typesInDB ;
  int maxTypeId;
  
  Map<String, int> kanjisInDB;
  int maxKanjiId;
  

  // Add any fields or methods needed for parsing term meta bank v3 files
  KanjiMetaBankV3ParserContext._({
    required this.typesInDB,
    required this.maxTypeId,
    required this.kanjisInDB,
    required this.maxKanjiId
});

  static Future<KanjiMetaBankV3ParserContext> create(DaKanjiDB db) async {
    return KanjiMetaBankV3ParserContext._(
      typesInDB: { for (var e in await db.termMetaBankV3Dao.getAllTypes()) e.type : e.id },
      kanjisInDB: { for (var e in await db.kanjiDao.getAllKanjis()) e.kanji : e.id },

      maxTypeId: await db.termMetaBankV3Dao.maxTermMetaBankV3TypeId(),
      maxKanjiId: await db.kanjiDao.maxKanjiId()
    );
  }
}