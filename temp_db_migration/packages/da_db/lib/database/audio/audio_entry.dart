
import 'dart:convert';
import 'dart:typed_data';

import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_entry.freezed.dart';
part 'audio_entry.g.dart';



@Freezed()
@JsonSerializable()
/// Class representing one audio entry of the database
class AudioEntry with _$AudioEntry {

  /// The id of this entry in the audio table
  @override
  int id;
  /// The index (dictionary) in which this entry is defined
  @override
  IndexEntry indexEntry;
  /// The terms associated with this audio entry
  @override
  final List<String> terms;
  /// The reading associated with this audio entry, if any
  @override
  final String? reading;
  /// The pitch accent pattern of this audio entry, if any
  @override
  final String? pitchAccentPattern;
  /// the path of the audio file as found in the original data source
  @override
  final String? filePath;
  /// The name of the audio file
  @override
  final String fileName;
  
  /// The actual audio data
  @override
  @JsonKey(toJson: base64Encode, fromJson: base64Decode)
  final Uint8List fileData;
  
  AudioEntry({
    required this.id,
    required this.indexEntry,
    required this.terms,
    required this.reading,
    required this.pitchAccentPattern,
    required this.filePath,
    required this.fileName,
    required this.fileData,
  }) {
    terms.sort();
  }
    
  factory AudioEntry.fromAudioEntryViewData(AudioEntryViewData data) {
    return AudioEntry(
      id: data.id,
      indexEntry: IndexEntry.fromJson(jsonDecode(data.indexEntry)),
      terms: List<String>.from(jsonDecode(data.termsJsonList)),
      reading: data.reading,
      pitchAccentPattern: data.pitchAccentPattern,
      filePath: data.path,
      fileName: data.name!,
      fileData: data.data!
    );
  }

  factory AudioEntry.fromJson(Map<String, Object?> json) 
    => _$AudioEntryFromJson(json);

  Map<String, Object?> toJson() => _$AudioEntryToJson(this);

}
