// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';


part 'audio_entry.freezed.dart';
part 'audio_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
@JsonSerializable()
/// Class representing one audio entry of the database
class AudioEntry with _$AudioEntry {
  /// The name of the audio source
  @override
  String name;
  /// The URI of the audio source
  @override
  String uri;  @override
  /// Is this a local audio source
  @override
  bool local;

  AudioEntry(
    {
      required this.name,
      required this.uri,
      required this.local,
    }){
      name = name.trim();
      uri = uri.trim();
    }


  factory AudioEntry.fromJson(Map<String, Object?> json)
    => _$AudioEntryFromJson(json);

  Map<String, Object?> toJson() => _$AudioEntryToJson(this);

}
