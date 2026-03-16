
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_source_list_entry.freezed.dart';
part 'audio_source_list_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
@JsonSerializable()
/// Class representing one audio entry of the database
class AudioSourceListEntry with _$AudioSourceListEntry {

  @override
  int id;
  /// The name of the audio source
  @override
  String name;
  /// The URI of the audio source
  @override
  String uri;
  @override
  IndexEntry indexEntry;

  AudioSourceListEntry(
    {
      required this.id,
      required this.name,
      required this.uri,
      required this.indexEntry,
    }){
      name = name.trim();
      uri = uri.trim();
    }

  factory AudioSourceListEntry.fromJson(Map<String, Object?> json)
    => _$AudioSourceListEntryFromJson(json);

  Map<String, Object?> toJson() => _$AudioSourceListEntryToJson(this);

}
