// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:isar/isar.dart';
import 'package:tuple/tuple.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/dojg/dojg_entry.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/repositories/dojg/dojg.dart';

/// Let the user select the anki DoJG deck and import it.
/// Returns `true` if the base dojg (no media) has been successfully been
/// imported
Future<bool> importDoJGDeck (PlatformFile dojgFile) async {

  bool imported = false;

  try {
    // get current file path and dakanji directory
    File dojg = File(dojgFile.path!);
    String copyTo = g_DakanjiPathManager.dojgDirectory.path;

    // extract the zip (in a separate isolate) to the dakanji directory
    await compute((Tuple2 params) {
      final inputStream = InputFileStream(params.item1.path);
      final archive = ZipDecoder().decodeStream(inputStream);
      extractArchiveToDisk(archive, params.item2);
    }, Tuple2(dojg, copyTo));

    // convert SQLite -> Isar
    List<DojgEntry> entries = convertSQLiteToDojgEntry();
    Isar isar = Isar.getInstance("dojg") ??
      Isar.openSync([DojgEntrySchema], directory: copyTo, name: "dojg");

    isar.writeTxnSync(() => isar.dojgEntrys.putAllSync(entries));
    
    imported = entries.length == 629;
  } 
  catch (e){
    debugPrint("Cannot load DoJG deck! Encountered: $e");
  }
  

  return imported;

}