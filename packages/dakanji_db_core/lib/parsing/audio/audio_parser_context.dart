// Project imports:
import 'package:dakanji_db_core/parsing/util/import_context.dart';

import '/database/dakanji_db.dart';

class AudioParserContext extends ParserContext{

  /// The current maximum term ID in the database
  int currentMaxTermId;
  /// A map of all terms in the database to their IDs
  Map<String, int> allTerms;

  /// The current maximum reading ID in the database
  int currentMaxReadingId;
  /// A map of all readings in the database to their IDs
  Map<String, int> allReadings;

  /// A list of all [TermTableCompanion]s that should be inserted in the DB
  List<TermTableCompanion> termComps= [];
  /// A list of all [AudioTableCompanion]s that should be inserted in the DB
  List<AudioTableCompanion> audioComps = [];



  AudioParserContext._({
    required this.currentMaxTermId,
    required this.allTerms,
    required this.currentMaxReadingId,
    required this.allReadings,
  });

  static Future<AudioParserContext> create(DaKanjiDB db) async {

    return AudioParserContext._(
      currentMaxTermId: await db.termDao.maxTermId(),
      allTerms: { for (var e in await db.termDao.getAllTerms()) e.term : e.id },
      
      currentMaxReadingId: await db.readingDao.maxReadingId(),
      allReadings: { for (var e in await db.readingDao.getAllReadings()) e.reading : e.id },
    );

  }

}