import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/db/staging_db.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/parsers/tag_bank_v3_parser.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/parsers/term_bank_v3_parser.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/parsers/term_meta_bank_v3_parser.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/parsers/yomitan_file_parser.dart';
import 'package:drift/native.dart';
import 'package:language_processing/language_processor.dart';
import 'package:language_processing/language_processor_options.dart';

import 'worker_protocol.dart'; 


Future<void> workerEntry(SendPort mainSendPort) async {
  final receivePort = ReceivePort();
  mainSendPort.send(receivePort.sendPort);

  StagingDatabase? db;
  LanguageProcessor? lp;
  ProcessorOptions? processorOptions;
  
  InputFileStream? zipInputStream;
  Archive? archiveHeaders; 
  
  int currentLocalId = 0; 

  final List<YomitanFileParser> parsers = [
    TagBankParser(),
    TermBankV3Parser(),
    TermMetaBankV3Parser(),
    // TODO
  ];

  bool saveJson = false;

  await for (final message in receivePort) {
    
    if (message is MsgInit) {
      db = StagingDatabase(NativeDatabase(File(message.dbPath)));
      
      // SQLite speed optimizations for bulk insert
      await db.customStatement('PRAGMA synchronous = OFF;');
      await db.customStatement('PRAGMA journal_mode = MEMORY;'); 
      await db.customStatement('PRAGMA cache_size = -4000;'); 

      if (message.languageProcessorJson.isNotEmpty) {
        lp = LanguageProcessor.fromJsonString(message.languageProcessorJson);
        await lp.init();
      }
      
      processorOptions = ProcessorOptions();
      saveJson = message.saveOriginalJson;

      try {
        zipInputStream = InputFileStream(message.zipPath);
        archiveHeaders = ZipDecoder().decodeStream(zipInputStream);
        message.replyPort.send(MsgReady(receivePort.sendPort));
      }
      catch (e) {
        message.replyPort.send(MsgError("Failed to open zip: $e"));
        continue;
      }
    }
    
    else if (message is MsgProcessFile) {
      if (db == null) continue;

      try {
        final parser = parsers.firstWhere(
          (p) => p.canHandle(message.fileName),
          orElse: () => throw Exception("No parser found for ${message.fileName}")
        );

        final fileHeader = archiveHeaders!.findFile(message.fileName)!;
        final jsonObject = jsonDecode(utf8.decode(fileHeader.content));

        if (jsonObject is List) {
          currentLocalId = await parser.parseFileContent(
            jsonObject, db, lp, 
            processorOptions!, saveJson, currentLocalId 
          );
        }

        mainSendPort.send(MsgDone());

      }
      catch (e, s) {
        print("Error processing ${message.fileName}: $e");
        mainSendPort.send(MsgError("Error in ${message.fileName}: $e"));
      }
    }
    
    else if (message is MsgTerminate) {
      if (db != null) {
        await preIndex(db);
        await db.close();
      }
      
      lp?.close();
      zipInputStream?.close(); 
      
      mainSendPort.send("CLOSED");
      receivePort.close();
      return;
    }
  }
}

Future<void> preIndex(StagingDatabase db) async {

  // 1. Tag indexes
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stg_meta_tag ON ${db.tagStagingTable.actualTableName}(tag_name)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stg_rule ON ${db.termRuleStagingTable.actualTableName}(rule_id)');

  // 2. Term indexes
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_st_term ON ${db.termStagingTable.actualTableName}(term)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_st_reading ON ${db.termStagingTable.actualTableName}(reading)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_sd_def ON ${db.termDefinitionStagingTable.actualTableName}(definition)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_sd_link ON ${db.termDefinitionStagingTable.actualTableName}(term_local_id)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stg_tag_split ON ${db.termTagStagingTable.actualTableName}(is_definition_tag, tag_name)');

  // 3. Term Meta indexes
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stm_term ON ${db.termMetaStagingTable.actualTableName}(term)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stm_reading ON ${db.termMetaStagingTable.actualTableName}(reading)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stm_mode ON ${db.termMetaStagingTable.actualTableName}(mode)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stm_tag_composite ON ${db.termMetaTagStagingTable.actualTableName}(parent_type, tag_name)');

}