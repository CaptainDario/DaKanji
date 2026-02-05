import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/util/import_context.dart';



class TermMetaBankV3ParserContext extends ParserContext {

  int currentMaxTermMetaId;
  
  Map allTerms;
  int currentMaxTermId;
  
  Map allTypes;
  int currentMaxTypeId;
  
  Map allReadings;
  int currentMaxReadingId;
  
  Map allTags;
  int currentMaxTagId;
  
  int currentMaxPitchId;
  
  int currentMaxIpaId;
  

  // Add any fields or methods needed for parsing term meta bank v3 files
  TermMetaBankV3ParserContext._({
    required this.currentMaxTermMetaId,
    required this.allTerms,

    required this.currentMaxTermId,
    required this.allTypes,
    required this.currentMaxTypeId,
    required this.allReadings,
    required this.currentMaxReadingId,
    required this.allTags,
    required this.currentMaxTagId,
    required this.currentMaxPitchId,
    required this.currentMaxIpaId,
  });

  static Future<TermMetaBankV3ParserContext> create(DaKanjiDB db, int indexId) async {
    return TermMetaBankV3ParserContext._(
      
      allTerms: { for (var e in await db.termDao.getAllTerms()) e.term : e.id },
      allTypes: { for (var e in await db.termMetaBankV3Dao.getAllTypes()) e.type : e.id },
      allReadings: { for (var e in await db.readingDao.getAllReadings()) e.reading : e.id },
      allTags: { for (var e in await db.tagBankV3Dao.getAllTags(indexId)) e.name : e.id },

      currentMaxTermMetaId: await db.termMetaBankV3Dao.maxTermMetaBankV3Id(),      
      currentMaxTermId: await db.termDao.maxTermId(),
      currentMaxTypeId: await db.termMetaBankV3Dao.maxTermMetaBankV3TypeId(),
      currentMaxReadingId: await db.readingDao.maxReadingId(),
      currentMaxTagId: await db.tagBankV3Dao.maxTagBankId(),
      currentMaxPitchId: await db.termMetaBankV3Dao.maxTermMetaBankV3PitchId(),
      currentMaxIpaId: await db.termMetaBankV3Dao.maxTermMetaBankV3IpaId(),
    );
  }
}