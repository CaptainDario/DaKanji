import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/db_file_parser.dart';
import 'package:da_db/parsing/util/db_optimization.dart';
import 'package:da_db/parsing/util/parsing_util.dart';
import 'package:da_db/parsing/yomitan/staging_db/parsers/tag_bank_v3_parser.dart';
import 'package:da_db/parsing/yomitan/staging_db/workers/worker_protocol.dart';
import 'package:drift/native.dart';
import 'package:language_processing/language_processing.dart';

import '../parsers/example_bank_parser.dart';
import '../parsers/example_text_parser.dart'; // Add your new text parser import

Future<void> exampleWorkerEntry(SendPort mainSendPort) async {
  final receivePort = ReceivePort();
  mainSendPort.send(receivePort.sendPort);

  StagingDatabase? db;
  LanguageProcessor? lp;
  ProcessorOptions? processorOptions;
  
  String? _zipPath;
  int currentLocalId = 0; 

  final List<DbFileParser> parsers = [
    ExampleBankParser(),
    TagBankParser(),
    ExampleTextParser(),
  ];

  await for (final message in receivePort) {
    if (message is MsgInit) {
      db = StagingDatabase(NativeDatabase(File(message.dbPath)));
      await optimizeStagingDbForRawInsert(db);

      if (message.languageProcessorJson.isNotEmpty) {
        lp = LanguageProcessor.fromJsonString(message.languageProcessorJson);
        await lp.init();
      }
      
      processorOptions = const ProcessorOptions();
      _zipPath = message.zipPath;
      message.replyPort.send(MsgReady(receivePort.sendPort));
    }
    else if (message is MsgProcessFile) {
      if (db == null) continue;

      try {
        final parser = parsers.firstWhere(
          (p) => p.canHandle(message.fileName),
          orElse: () => throw Exception("No parser found for ${message.fileName}")
        );

        final archive = daDbDataSourceIterator(archivePath: _zipPath);
        final mainFile = archive.firstWhereOrNull((f) => f.name == message.fileName);

        if (mainFile == null) throw Exception("File not found");

        // 1. Prepare the payload list starting with the main file
        List<Uint8List> payloadBytes = [mainFile.content];

        // 2. If processing a .txt file, hunt for its .json companion
        if (message.fileName.endsWith('.txt')) {
          final companionName = message.fileName.replaceAll('.txt', '.json');
          final companionFile = archive.firstWhereOrNull((f) => f.name == companionName);
          
          if (companionFile != null) {
            payloadBytes.add(companionFile.content);
          }
        }

        // 3. Pass the assembled payload to the parser
        currentLocalId = await parser.parseFileContent(
          payloadBytes, db, lp, processorOptions!, currentLocalId);
          
        mainSendPort.send(MsgDone());
      }
      catch (e, s) {
        print("Error processing ${message.fileName}: $e, \n$s");
        mainSendPort.send(MsgError("Error in ${message.fileName}: $e"));
      }
    }
    else if (message is MsgTerminate) {
      if (db != null) {
        await preIndex(db);
        await db.close();
      }
      lp?.close();
      mainSendPort.send("CLOSED");
      receivePort.close();
      return;
    }
  }
}

Future<void> preIndex(StagingDatabase db) async {
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stg_ex_lang ON ${db.exampleStagingTable.actualTableName}(language_code)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stg_ex_term ON ${db.exampleTermStagingTable.actualTableName}(term)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stg_ex_tag ON ${db.exampleTagStagingTable.actualTableName}(tag_name)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stg_exa_tag ON ${db.exampleAudioTagStagingTable.actualTableName}(tag_name)');
  
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stg_ex_stat ON ${db.exampleStatStagingTable.actualTableName}(stat_name)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stg_exa_stat ON ${db.exampleAudioStatStagingTable.actualTableName}(stat_name)');
}