import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:da_db/database/index/yomitan_index.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/db_file_parser.dart';
import 'package:da_db/parsing/util/db_optimization.dart';
import 'package:da_db/parsing/util/parsing_util.dart';
import 'package:da_db/parsing/yomitan/staging_db/parsers/kanji_bank_v3_parser.dart';
import 'package:da_db/parsing/yomitan/staging_db/parsers/kanji_meta_bank_v3_parser.dart';
import 'package:da_db/parsing/yomitan/staging_db/parsers/tag_bank_v3_parser.dart';
import 'package:da_db/parsing/yomitan/staging_db/parsers/term_bank_v3_parser.dart';
import 'package:da_db/parsing/yomitan/staging_db/parsers/term_meta_bank_v3_parser.dart';
import 'package:drift/native.dart';
import 'package:language_processing/language_processing.dart';

import '../../../util/worker_protocol.dart'; 


Future<void> workerEntry(SendPort mainSendPort) async {
  final receivePort = ReceivePort();
  mainSendPort.send(receivePort.sendPort);

  StagingDatabase? db;
  LanguageProcessor? lp;
  ProcessorOptions? processorOptions;
  late YomitanIndex currentIndexEntry;
  String? zipPath;
  int currentLocalId = 0; 

  final List<DbFileParser> parsers = [
    TagBankParser(),
    TermBankV3Parser(),
    TermMetaBankV3Parser(),
    KanjiBankV3Parser(),
    KanjiMetaBankV3Parser()
  ];

  await for (final message in receivePort) {
    
    if (message is MsgInit) {
      db = StagingDatabase(NativeDatabase(File(message.dbPath)));
      
      // SQLite speed optimizations for bulk insert
      await optimizeStagingDbForRawInsert(db);

      if (message.languageProcessorJson.isNotEmpty) {
        lp = LanguageProcessor.fromJsonString(message.languageProcessorJson);
        await lp.init();
      }
      
      processorOptions = ProcessorOptions();
      currentIndexEntry = message.index;
      zipPath = message.zipPath;
      message.replyPort.send(MsgReady(receivePort.sendPort));
    }
    
    else if (message is MsgProcessFile) {
      if (db == null) continue;

      try {
        final parser = parsers.firstWhere(
          (p) => p.canHandle(message.fileName),
          orElse: () => throw Exception("No parser found for ${message.fileName}")
        );

        final fileHandle = daDbDataSourceIterator(archivePath: zipPath)
          .firstWhereOrNull((f) => f.name == message.fileName);

        if (fileHandle == null) throw Exception("File not found");

        currentLocalId = await parser.parseFileContent(
          [fileHandle.content], db, lp, processorOptions!, currentLocalId,
          currentIndexEntry
        );
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
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stm_term_cov ON ${db.termMetaStagingTable.actualTableName}(term, term_normalized)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stm_reading_cov ON ${db.termMetaStagingTable.actualTableName}(reading, reading_normalized)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stm_mode ON ${db.termMetaStagingTable.actualTableName}(mode)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_stm_tag_composite ON ${db.termMetaTagStagingTable.actualTableName}(parent_type, tag_name)');

  // 4. Kanji Bank Indexes
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_sk_kanji ON ${db.kanjiStagingTable.actualTableName}(kanji)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_sk_reading_composite ON ${db.kanjiReadingStagingTable.actualTableName}(type, reading)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_sk_def ON ${db.kanjiDefinitionStagingTable.actualTableName}(definition)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_sk_tag ON ${db.kanjiTagStagingTable.actualTableName}(tag_name)');
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_sk_stat_tag ON ${db.kanjiStatStagingTable.actualTableName}(tag_name)');

  // 5. Kanji Meta Bank Indexes
  await db.customStatement('CREATE INDEX IF NOT EXISTS idx_skm_kanji_type ON ${db.kanjiMetaStagingTable.actualTableName}(kanji, type)');

}