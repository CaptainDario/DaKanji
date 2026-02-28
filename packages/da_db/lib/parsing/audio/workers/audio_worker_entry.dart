import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:da_db/parsing/audio/util/audio_staging_helper.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/parsing_constants.dart';
import 'package:da_db/parsing/util/parsing_util.dart';
import 'package:da_db/parsing/yomitan/staging_db/workers/worker_protocol.dart';
import 'package:drift/native.dart';
import 'package:language_processing/language_processing.dart';
import 'package:path/path.dart' as p;


/// Represents cached data parsed from an `index.json` or `entries.json` file.
class AudioMetadata {
  final List<String> terms;
  final String reading;
  final int? pitchPattern;
  AudioMetadata(this.terms, this.reading, this.pitchPattern);
}

/// The isolated worker responsible for parsing and staging Audio Dictionary files.
/// 
/// This worker supports three formats:
/// 1. `index.json` metadata + binary files.
/// 2. `entries.json` metadata + binary files.
/// 3. Fallback: Extracts term/reading/pitch directly from the audio file's name.
Future<void> audioWorkerEntry(SendPort mainSendPort) async {
  final receivePort = ReceivePort();
  mainSendPort.send(receivePort.sendPort);

  StagingDatabase? stagingDb;
  LanguageProcessor? lp;
  AudioStagingHelper? helper;
  String? _zipPath;
  
  // --- Worker State ---
  // If a metadata JSON file is encountered, its data is cached here in RAM. 
  // Subsequent binary files will query this map for their linguistic metadata.
  final Map<String, AudioMetadata> metadataCache = {};
  bool usesMetadataFile = false;
  
  // Fallback Regex for Format 3 (e.g., "Term [Reading] (Pitch).mp3")
  final RegExp format1Pattern = RegExp(r'^(.+?)(?:\s*[\[【](.+?)[\]】])?(?:\s*[\(（](\d+)[\)）])?$');

  await for (final message in receivePort) {
    if (message is MsgInit) {
      stagingDb = StagingDatabase(NativeDatabase(File(message.dbPath)));
      lp = LanguageProcessor.fromJsonString(message.languageProcessorJson);
      await lp.init();
      
      helper = AudioStagingHelper(
        stagingDb: stagingDb, 
        lp: lp, 
        onStatus: (msg) => mainSendPort.send(MsgDone()) 
      );
      
      _zipPath = message.zipPath;
      message.replyPort.send(MsgReady(receivePort.sendPort));
    }
    
    else if (message is MsgProcessFile) {
      if (stagingDb == null || helper == null) continue;

      try {
        final name = p.basename(message.fileName);
        final fileHandle = daDbDataSourceIterator(archivePath: _zipPath)
          .firstWhereOrNull((f) => f.name == message.fileName);

        if (fileHandle == null) throw Exception("File not found");
        final bytes = fileHandle.readBytes()!;

        // --- 1. Process Metadata Files ---
        if (name == audioIndexFile) {
          usesMetadataFile = true;
          final jsonMap = jsonDecode(utf8.decode(bytes)) as Map;
          final headwords = (jsonMap['headwords'] as Map).map((k, v) => MapEntry(k, List<String>.from(v)));
          final files = (jsonMap["files"] as Map).map((k, v) => MapEntry(k, Map<String, String>.from(v)));
          
          headwords.forEach((headword, fileList) {
            for (final file in fileList) {
              if (files.containsKey(file)) {
                final String? pitchStr = files[file]!["pitch_number"];
                metadataCache[file] = AudioMetadata(
                  [headword], files[file]!["kana_reading"] ?? "", int.tryParse(pitchStr ?? "")
                );
              }
            }
          });
        } 
        else if (name == audioEntriesFile) {
          usesMetadataFile = true;
          final jsonList = jsonDecode(utf8.decode(bytes)) as List;
          for (final entry in jsonList) {
            final kanjis = List<String>.from(entry["kanji"]);
            for (final accent in entry["accents"]) {
              if (accent["soundFile"] != null) {
                metadataCache[accent["soundFile"]] = AudioMetadata(
                  kanjis, accent["accent"][0]["pronunciation"], accent["accent"][0]["pitchAccent"]
                );
              }
            }
          }
        } 
        
        // --- 2. Process Binary Audio Files ---
        else {
          List<String> terms = [];
          String? reading;
          int? pitch;

          // Apply JSON metadata if available
          if (usesMetadataFile) {
            if (metadataCache.containsKey(name)) {
              final meta = metadataCache[name]!;
              terms = meta.terms;
              reading = meta.reading;
              pitch = meta.pitchPattern;
            }
          } 
          // Otherwise, attempt to parse the file name itself
          else {
            final String cleanName = p.basenameWithoutExtension(name);
            final Match? match = format1Pattern.firstMatch(cleanName);
            terms = match != null ? [match.group(1)!.trim()] : [cleanName];
            reading = match?.group(2)?.trim();
            pitch = match?.group(3) != null ? int.tryParse(match!.group(3)!) : null;
          }

          // Stage the physical bytes and metadata
          await helper.addEntry(
            terms: terms, reading: reading, pitchPattern: pitch,
            originalFilePath: message.fileName, fileContent: bytes
          );
        }
        
        mainSendPort.send(MsgDone());
      }
      catch (e, s) {
        print("Audio Worker Error processing ${message.fileName}: $e, \n$s");
        mainSendPort.send(MsgError("Error in ${message.fileName}: $e"));
      }
    }
    
    else if (message is MsgTerminate) {
      await helper?.flush();
      await stagingDb?.close();
      lp?.close();
      mainSendPort.send("CLOSED");
      receivePort.close();
      return;
    }
  }
}