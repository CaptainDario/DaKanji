
import 'package:dakanji_db_core/database/dictionary_types.dart';
import 'package:drift/drift.dart';

/// Contains the main Kanji entries to which the other tables link
class IndexTable extends Table {

  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// Type of dictionary stored in this index.
  TextColumn get dictionaryType => textEnum<DictionaryTypes>()() ;
  /// Current sorting order of this dictionary (DESC)
  IntColumn get currentSortingOrder => integer()();
  /// Whether this dictionary is used to override frequency data when searching
  BoolColumn get currentFrequencyDictionary => boolean().withDefault(const Constant(false))();

  // --- Yomitan fields ----------
  /// Title of the dictionary.
  TextColumn get title => text()();
  /// Revision of the dictionary. This value is displayed, and used to check for dictionary updates.
  TextColumn get revision => text()();

  /// Whether or not this dictionary contains sequencing information for related terms.
  BoolColumn get sequenced => boolean().nullable()();
  /// Format of data found in the JSON data files.
  IntColumn get format => integer().nullable()();
  /// Alias for format.
  IntColumn get version => integer().nullable()();
  /// Creator of the dictionary.
  TextColumn get author => text().nullable()();
  /// Whether this dictionary contains links to its latest version.
  BoolColumn get updatable => boolean().nullable()();
  /// URL for the index file of the latest revision of the dictionary, used to check for updates.
  TextColumn get indexUrl => text().nullable()();
  /// URL for the download of the latest revision of the dictionary.
  TextColumn get downloadUrl => text().nullable()();
  /// URL for the source of the dictionary, displayed in the dictionary details.
  TextColumn get url => text().nullable()();
  /// Description of the dictionary data.
  TextColumn get description => text().nullable()();
  /// Attribution information for the dictionary data.
  TextColumn get attribution => text().nullable()();
  /// Language of the terms in the dictionary.
  TextColumn get sourceLanguage => text().nullable()();
  /// Main language of the definitions in the dictionary.
  TextColumn get targetLanguage => text().nullable()();
  /// The mode of the frequency in this dictionary, one of
  /// "occurrence-based", "rank-based"
  TextColumn get frequencyMode => text().nullable()();

}
