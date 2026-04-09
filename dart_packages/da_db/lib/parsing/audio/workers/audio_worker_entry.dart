import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:da_db/data/supported_audio_formats.dart';
import 'package:da_db/parsing/audio/parsers/audio_entries_json_parser.dart';
import 'package:da_db/parsing/audio/parsers/audio_file_name_parser.dart';
import 'package:da_db/parsing/audio/parsers/audio_index_json_parser.dart';
import 'package:da_db/parsing/audio/util/audio_staging_helper.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/parsing_constants.dart';
import 'package:da_db/parsing/util/parsing_util.dart';
import 'package:da_db/parsing/util/worker_protocol.dart';
import 'package:drift/native.dart';
import 'package:language_processing/language_processing.dart';
import 'package:path/path.dart' as p;

Future<void> audioWorkerEntry(SendPort mainSendPort) async {
  final receivePort = ReceivePort();
  mainSendPort.send(receivePort.sendPort);

  StagingDatabase? stagingDb;
  LanguageProcessor? lp;
  AudioStagingHelper? helper;
  String? zipPath;
  
  // --- Worker State ---
  final Map<String, ({List<String> terms, String reading, String? pitchPattern})> metadataCache = {};
  bool usesMetadataFile = false;

  await for (final message in receivePort) {
    if (message is MsgInit) {
      stagingDb = StagingDatabase(NativeDatabase(File(message.dbPath)));
      lp = LanguageProcessor.fromJsonString(message.languageProcessorJson);
      await lp.init();
      
      helper = AudioStagingHelper(
        stagingDb: stagingDb, 
        lp: lp, 
        onStatus: (msg) => mainSendPort.send(msg) 
      );
      
      zipPath = message.zipPath;
      message.replyPort.send(MsgReady(receivePort.sendPort));
    }
    
    else if (message is MsgProcessFile) {
      if (stagingDb == null || helper == null || lp == null) continue;

      try {
        if (message.fileName == processFullAudioArchive) {
          
          // 1. Open the archive ONCE and force the index/entries files to yield first
          final allFiles = daDbDataSourceIterator(
            archivePath: zipPath,
            fileOrder: [audioIndexFile, audioEntriesFile] 
          );

          int processedCount = 0;

          // 2. Single-pass iteration
          for (final fileHandle in allFiles) {
            if (!fileHandle.isFile) continue;

            final name = p.basename(fileHandle.name);
            
            // Skip the main yomitan_index.json (Orchestrator already handled it)
            if (name == yomitanIndexFile) continue;

            final bytes = fileHandle.readBytes();
            if (bytes == null) continue;

            // --- A. Cache Metadata First ---
            if (name == audioIndexFile) {
              usesMetadataFile = true;
              metadataCache.addAll(AudioIndexJsonParser.parseMetadata(utf8.decode(bytes), lp));
            } 
            else if (name == audioEntriesFile) {
              usesMetadataFile = true;
              metadataCache.addAll(AudioEntriesJsonParser.parseMetadata(utf8.decode(bytes), lp));
            } 
            
            // --- B. Process Binary Audio Files ---
            else if (SupportedAudioFormats.values.any((ext) => name.endsWith(".${ext.name}"))) {
              late List<String> terms;
              String? reading;
              String? pitchPattern;

              if (usesMetadataFile) {
                if (metadataCache.containsKey(name)) {
                  final meta = metadataCache[name]!;
                  terms = meta.terms;
                  reading = meta.reading;
                  pitchPattern = meta.pitchPattern;
                } else {
                  terms = [p.basenameWithoutExtension(name)];
                }
              } else {
                final parsed = AudioFileNameParser.parseFileName(p.basenameWithoutExtension(name), lp);
                terms = parsed.terms;
                reading = parsed.reading;
                pitchPattern = parsed.pitchPattern;
              }

              await helper.addEntry(
                terms: terms, 
                reading: reading, 
                pitchPattern: pitchPattern,
                originalFilePath: fileHandle.name, 
                fileContent: bytes
              );

              processedCount++;
              if (processedCount % 500 == 0) {
                mainSendPort.send("Processed $processedCount audio files...");
              }
            }
          }
          
          mainSendPort.send(MsgDone());
        }
      }
      catch (e, s) {
        print("Audio Worker Error processing archive: $e\n$s");
        mainSendPort.send(MsgError("Error extracting audio archive: $e"));
      }
    }
    
    else if (message is MsgTerminate) {
      await helper?.flush();
      if (stagingDb != null) {
        await preIndex(stagingDb);
        await stagingDb.close();
      }
      lp?.close();
      mainSendPort.send("CLOSED");
      receivePort.close();
      return;
    }
  }
}

Future<void> preIndex(StagingDatabase db) async {
  // Speeds up the JOIN to the main Term table
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stg_audio_term ON ${db.audioStagingTable.actualTableName}(term)');
  
  // Speeds up the GROUP BY and JOINs mapping metadata to the physical media files
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stg_audio_file ON ${db.audioStagingTable.actualTableName}(original_file_name)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stg_media_file ON ${db.mediaStagingTable.actualTableName}(file_name)');
}