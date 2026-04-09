import 'package:da_db/data/frequency_mode.dart';
import 'package:da_db/util/data_converters/bool_as_int_converter.dart';
import 'package:da_db/util/data_converters/iso639_3_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:language_processing/language_processing.dart';

part 'yomitan_index.freezed.dart';
part 'yomitan_index.g.dart';

@Freezed()
@JsonSerializable()
/// Class representing only the pure Yomitan index.json data
class YomitanIndex with _$YomitanIndex {

  /// Title of the dictionary.
  @override
  final String title;
  /// Revision of the dictionary. This value is displayed, and used to check for dictionary updates.
  @override
  final String revision;
  
  /// Whether or not this dictionary contains sequencing information for related terms.
  @override
  @FlexibleNullableBoolConverter()
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
  @FlexibleNullableBoolConverter()
  final bool? isUpdatable;
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
  @Iso6393Converter()
  final Iso639_3? sourceLanguage;
  /// Main language of the definitions in the dictionary.
  @override
  @Iso6393Converter()
  final Iso639_3? targetLanguage;
  /// The mode of the frequency in this dictionary, one of
  /// "occurrence-based", "rank-based"
  @override
  final FrequencyMode? frequencyMode;

    
  YomitanIndex({
    required this.title,
    required this.revision,
    this.sequenced,
    this.format,
    this.version,
    this.author,
    this.isUpdatable,
    this.indexUrl,
    this.downloadUrl,
    this.url,
    this.description,
    this.attribution,
    this.sourceLanguage,
    this.targetLanguage,
    this.frequencyMode,
  });

  bool get dictCanBeUpdated
    => (isUpdatable ?? false) && (indexUrl != null) && (downloadUrl != null);

  bool compareRevision (String other) {
    final simpleVersionTest = RegExp(r'^(\d+\.)*\d+$');

    // 1. If strict format check fails, fall back to string comparison
    if (!simpleVersionTest.hasMatch(revision) || !simpleVersionTest.hasMatch(other)) {
      return revision.compareTo(other) < 0;
    }

    final currentParts = revision.split('.').map(int.parse).toList();
    final latestParts = other.split('.').map(int.parse).toList();

    // 2. If length mismatch, fall back to string comparison
    if (currentParts.length != latestParts.length) {
      return revision.compareTo(other) < 0;
    }

    // 3. Compare parts numerically
    for (var i = 0; i < currentParts.length; i++) {
      if (currentParts[i] != latestParts[i]) {
        return currentParts[i] < latestParts[i];
      }
    }

    return false;
  }

  Map<String, Object?> toJson() => _$YomitanIndexToJson(this);

  factory YomitanIndex.fromJson(Map<String, Object?> json) 
    => _$YomitanIndexFromJson(json);

}