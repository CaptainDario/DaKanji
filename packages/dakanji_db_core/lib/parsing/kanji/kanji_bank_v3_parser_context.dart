// Project imports:
import '/database/dakanji_db.dart';
import '/database/kanji/kanji_bank_v3_tables.dart';



/// Simple class to keep track of the different IDs needed to parse a kanji dict
class KanjiBankV3ParserContext {

  /// The SQLite id of the dictionary that is currently being parsed
  int dictId = 0;

  ///
  List<KanjiTableCompanion> kanjiCompanions = [];
  ///
  int kanjiId = 0;
  ///
  Map<String, int> kanjisInDB = {};

  /// List of [KanjiBankV3TableCompanion] that should be batch inserted
  List<KanjiBankV3TableCompanion> kanjiBankCompanions = [];
  /// The currently highest id in the [KanjiBankV3Table]
  int kanjiBankId = 0;

  /// List of [ReadingTableCompanion] that should be batch inserted
  List<ReadingTableCompanion> readingCompanions  = [];
  /// The currently highest id in the [ReadingTable]
  int readingId = 0;
  /// List of [KanjiBankV3_X_OnyomiReadingTableCompanion] that should be batch inserted
  List<KanjiBankV3_X_OnyomiReadingTableCompanion> kanjiOnyomiReadingRelCompanions = [];
  /// List of [KanjiBankV3_X_KunyomiReadingTableCompanion] that should be batch inserted
  List<KanjiBankV3_X_KunyomiReadingTableCompanion> kanjiKunyomiReadingRelCompanions = [];
  /// A local cache for readings. Every reading should only be looked up once
  /// in the database
  Map<String, int> readingsInDB = {};

  List<int> onyomisOrder = [];
  List<int> kunyomisOrder = [];
  
  /// List of [KanjiBankV3_X_TagBankV3TableCompanion] that should be batch inserted
  List<KanjiBankV3_X_TagBankV3TableCompanion> tagRelCompanions = [];
  /// The currently highest id in the [KanjiBankV3TagsKanjiRelationsTableData]
  int tagId = 0;
  /// A local cache for tags. Every tag should only be looked up once
  /// in the database
  Map<String, int> tagsInDB = {};
  
  /// List of [DefinitionTableCompanion] that should be batch inserted
  List<DefinitionTableCompanion> definitionsCompanions  = [];
  /// The currently highest id in the [DefinitionTable]
  int definitionId = 0;
  /// List of [KanjiBankV3_X_DefinitionTableCompanion] that should be batch inserted
  List<KanjiBankV3_X_DefinitionTableCompanion> definitionRelCompanions = [];
  /// A local cache for definitions. Every definition should only be looked up once
  /// in the database
  Map<String, int> definitionsInDB = {};

  List<int> definitionsOrder = [];

  /// List of [KanjiBankV3StatsTableCompanion] that should be batch inserted
  List<KanjiBankV3StatsTableCompanion> statCompanions = [];
  /// List of [KanjiBankV3StatNamesTableCompanion] that should be batch inserted
  List<KanjiBankV3StatNamesTableCompanion> statNamesCompanions  = [];
  /// List of [KanjiBankV3StatValuesTableCompanion] that should be batch inserted
  List<KanjiBankV3StatValuesTableCompanion> statValuesCompanions  = [];
  /// The currently highest id in the [KanjiBankV3StatsTable]
  int statsId = 0;
  /// The currently highest id in the [KanjiBankV3StatValuesTable]
  int statNamesId = 0;
  /// The currently highest id in the [KanjiBankV3StatNamesTable]
  int statValuesId = 0;
  /// List of [KanjiBankV3_X_KanjiBankV3StatsTableCompanion] that should be batch inserted
  List<KanjiBankV3_X_KanjiBankV3StatsTableCompanion> statValueRelCompanions = [];
  /// A local cache for stat names. Every stat name should only be looked up
  /// once in the database
  Map<String, int> statNamesInDB = {};
  /// A local cache for stat values. Every stat value should only be looked up
  /// once in the database
  Map<String, int> statValuesInDB = {};

}