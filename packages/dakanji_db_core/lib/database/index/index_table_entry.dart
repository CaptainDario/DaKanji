import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/dictionary_types.dart';
import 'package:dakanji_db_core/helper/bool_as_int_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'index_table_entry.freezed.dart';
part 'index_table_entry.g.dart';



@Freezed()
@JsonSerializable()
/// Class representing one term meta entry of the database
class IndexEntry with _$IndexEntry {

  @override
  final int id;
  /// Type of dictionary stored in this index.
  @override
  final DictionaryTypes dictionaryType;
  /// Current sorting order of this dictionary (DESC)
  @override
  final int currentSortingOrder;
  /// Whether this dictionary is used to override frequency data when searching
  @override
  @BoolAsIntConverter()
  final bool currentFrequencyDictionary;

  /// --- Yomitan fields ----------
  /// Title of the dictionary.
  @override
  final String title;
  /// Revision of the dictionary. This value is displayed, and used to check for dictionary updates.
  @override
  final String revision;
  /// Whether or not this dictionary contains sequencing information for related terms.
  @override
  @NullableBoolAsIntConverter()
  final bool? sequenced;
  /// Format of data found in the JSON data files.
  @override
  final int? format;
  /// Alias for format.
  @override
  final int? version;
  /// Creator of the dictionary.
  @override
  final String? author;
  /// Whether this dictionary contains links to its latest version.
  @override
  final bool? updatable;
  /// URL for the index file of the latest revision of the dictionary, used to check for updates.
  @override
  final String? indexUrl;
  /// URL for the download of the latest revision of the dictionary.
  @override
  final String? downloadUrl;
  /// URL for the source of the dictionary, displayed in the dictionary details.
  @override
  final String? url;
  /// Description of the dictionary data.
  @override
  final String? description;
  /// Attribution information for the dictionary data.
  @override
  final String? attribution;
  /// Language of the terms in the dictionary.
  @override
  final String? sourceLanguage;
  /// Main language of the definitions in the dictionary.
  @override
  final String? targetLanguage;
  /// The mode of the frequency in this dictionary, one of
  /// "occurrence-based", "rank-based"
  @override
  final String? frequencyMode;

    
  IndexEntry({
    required this.id,
    required this.dictionaryType,
    required this.currentSortingOrder,
    required this.currentFrequencyDictionary,
    required this.title,
    required this.revision,
    this.sequenced,
    this.format,
    this.version,
    this.author,
    this.updatable,
    this.indexUrl,
    this.downloadUrl,
    this.url,
    this.description,
    this.attribution,
    this.sourceLanguage,
    this.targetLanguage,
    this.frequencyMode,
  }) ;

  factory IndexEntry.fromKanjiDictionarySearchViewData(KanjiDictionarySearchViewData r) {
    return IndexEntry._fromDataSource(r);
  }
    
  factory IndexEntry.fromDictionarySearchDrift(DictionarySearchDriftFindTermBankDetailsResult r) {
    return IndexEntry._fromDataSource(r);
  }

  factory IndexEntry._fromDataSource(dynamic r) {

    return IndexEntry(
      id: r.indexId,
      dictionaryType: r.dictionaryType,
      currentSortingOrder: r.currentSortingOrder,
      currentFrequencyDictionary: r.currentFrequencyDictionary,
      title: r.title,
      revision: r.revision,
      sequenced: r.sequenced,
      format: r.format,
      version: r.version,
      author: r.author,
      updatable: r.updatable,
      indexUrl: r.indexUrl,
      downloadUrl: r.downloadUrl,
      url: r.url,
      description: r.description,
      attribution: r.attribution,
      sourceLanguage: r.sourceLanguage,
      targetLanguage: r.targetLanguage,
      frequencyMode: r.frequencyMode
    );
  }

  factory IndexEntry.fromJson(Map<String, Object?> json) 
    => _$IndexEntryFromJson(json);

}
