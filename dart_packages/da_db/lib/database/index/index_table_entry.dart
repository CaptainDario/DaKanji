import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/data/frequency_mode.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/index/yomitan_index.dart';
import 'package:da_db/util/data_converters/bool_as_int_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:language_processing/language_processing.dart';

part 'index_table_entry.freezed.dart';
part 'index_table_entry.g.dart';



@Freezed()
@JsonSerializable()
/// Class representing one term meta entry of the database
class IndexEntry with _$IndexEntry  {

  /// The id of this entry in the SQLite DB
  @override
  final int id;

  /// Whether this is a dictionary included with the db by default or not
  @override
  @BoolAsIntConverter()
  final bool isDefaultDictionary;
  /// Whether this dictionary is enabled or not
  @override
  @BoolAsIntConverter()
  final bool enabled;
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

  @override
  /// Yomitan data
  final YomitanIndex yomitanData;

  /// Shortcuts to access yomitan data fields
  String get title => yomitanData.title;
  String get revision => yomitanData.revision;
  bool? get sequenced => yomitanData.sequenced;
  int? get format => yomitanData.format;
  int? get version => yomitanData.version;
  String? get author => yomitanData.author;
  bool? get isUpdatable => yomitanData.isUpdatable;
  String? get indexUrl => yomitanData.indexUrl;
  String? get downloadUrl => yomitanData.downloadUrl;
  String? get url => yomitanData.url;
  String? get description => yomitanData.description;
  String? get attribution => yomitanData.attribution;
  Iso639_3? get sourceLanguage => yomitanData.sourceLanguage;
  Iso639_3? get targetLanguage => yomitanData.targetLanguage;
  FrequencyMode? get frequencyMode => yomitanData.frequencyMode;

  bool get dictCanBeUpdated => yomitanData.dictCanBeUpdated;
  bool compareRevision(String other) => yomitanData.compareRevision(other);

    
  IndexEntry({
    required this.id,
    required this.isDefaultDictionary,
    required this.enabled,
    required this.dictionaryType,
    required this.currentSortingOrder,
    required this.currentFrequencyDictionary,
    required this.yomitanData
  }) ;

  IndexEntry.fromIndexTableData(IndexTableData data) :
    id = data.id,
    isDefaultDictionary = data.isDefaultDictionary,
    enabled = data.enabled,
    dictionaryType = data.dictionaryType,
    currentSortingOrder = data.currentSortingOrder,
    currentFrequencyDictionary = data.currentFrequencyDictionary,
    yomitanData = YomitanIndex(
      title: data.title,
      revision: data.revision,
      sequenced: data.sequenced,
      format: data.format,
      version: data.version,
      author: data.author,
      isUpdatable: data.isUpdatable,
      indexUrl: data.indexUrl,
      downloadUrl: data.downloadUrl,
      url: data.url,
      description: data.description,
      attribution: data.attribution,
      sourceLanguage: data.sourceLanguage,
      targetLanguage: data.targetLanguage,
      frequencyMode: data.frequencyMode
    );


  Map<String, Object?> toJson() => _$IndexEntryToJson(this);

  factory IndexEntry.fromJson(Map<String, Object?> json) 
    => _$IndexEntryFromJson(json);

}
