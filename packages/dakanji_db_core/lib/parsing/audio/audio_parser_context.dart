
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

  /// The current maximum [AudioTable] ID in the database
  int currentMaxAudioId;

  /// The current maximum media ID in the database
  int currentMaxMediaId;

  /// A list of all [TermTableCompanion]s that should be inserted in the DB
  List<TermTableCompanion> termComps= [];
  /// A list of all [ReadingTableCompanion]s that should be inserted in the DB
  List<ReadingTableCompanion> readingComps = [];
  /// A list of all [AudioTableCompanion]s that should be inserted in the DB
  List<AudioTableCompanion> audioComps = [];
  /// A list of all [AudioTable_X_TermTableCompanion]s that should be inserted
  /// in the DB
  List<AudioTable_X_TermTableCompanion> audioXTermComps = [];



  AudioParserContext._({
    required this.currentMaxTermId,
    required this.allTerms,
    required this.currentMaxReadingId,
    required this.allReadings,
    required this.currentMaxAudioId,
    required this.currentMaxMediaId,
  });

  static Future<AudioParserContext> create(DaKanjiDB db) async {

    return AudioParserContext._(
      currentMaxTermId: await db.termDao.maxTermId(),
      allTerms: { for (var e in await db.termDao.getAllTerms()) e.term : e.id },
      
      currentMaxReadingId: await db.readingDao.maxReadingId(),
      allReadings: { for (var e in await db.readingDao.getAllReadings()) e.reading : e.id },

      currentMaxAudioId: await db.audioDao.maxAudioId(),

      currentMaxMediaId: await db.mediaDao.maxMediaId(),
    );

  }

}