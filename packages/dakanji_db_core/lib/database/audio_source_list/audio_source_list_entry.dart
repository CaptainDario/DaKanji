
import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_source_list_entry.freezed.dart';
part 'audio_source_list_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
@JsonSerializable()
/// Class representing one audio entry of the database
class AudioSourceListEntry with _$AudioSourceListEntry {
  /// The name of the audio source
  @override
  String name;
  /// The URI of the audio source
  @override
  String uri;

  AudioSourceListEntry(
    {
      required this.name,
      required this.uri,
    }){
      name = name.trim();
      uri = uri.trim();
    }


  factory AudioSourceListEntry.fromJson(Map<String, Object?> json)
    => _$AudioSourceListEntryFromJson(json);

  Map<String, Object?> toJson() => _$AudioSourceListEntryToJson(this);

}
