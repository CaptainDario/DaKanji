import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:da_kanji_mobile/domain/dojg/dojg_entry.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:file_picker/file_picker.dart';
import 'package:isar/isar.dart';
import 'package:universal_io/io.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';



/// Let the user select the anki DoJG deck and import it.
/// Returns `true` if the base dojg (no media) has been successfully been
/// imported
Future<bool> importDoJGDeck () async {

  bool imported = false;

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom, allowedExtensions: ["apkg"]
  );
  if(result != null){
    try {
      // get current file path and dakanji directory
      File dojg = File(result.files.single.path!);
      String copyTo = p.join(g_documentsDirectory.path, "DaKanji", "dojg");

      // extract the zip to the dakanji directory
      final inputStream = InputFileStream(dojg.path);
      final archive = ZipDecoder().decodeBuffer(inputStream);
      extractArchiveToDisk(archive, copyTo);

      // convert SQLite -> Isar
      List<DojgEntry> entries = convertSQLiteToDojgEntry();
      Isar isar = Isar.openSync([DojgEntrySchema], directory: copyTo, name: "dojg");
      isar.writeTxnSync(() => isar.dojgEntrys.putAllSync(entries));
      
      imported = entries.length == 629;
    } 
    catch (e){
      print("Cannot load DoJG deck! Encountered: $e");
    }
  }

  return imported;

}

/// Converts the sql database from the anki deck to isar
List<DojgEntry> convertSQLiteToDojgEntry() {

  List<List<String>> sqlDojgEntries    = getAllEntries();
  Map<String, String> dojgMediaMapping = getAllMediaFiles();

  List<DojgEntry> dojgEntries = [];
  for (List<String> entry in sqlDojgEntries){
    //String tag = entry[0];
    String data = entry[1];
    //String concept = entry[2];

    List<String> dataSplit = data.split("");

    // get all examples and separte key sentences from examples
    List<String> examples = dataSplit.sublist(9, 41);
    List<String> keySentencesJp = [], keySentencesEn = [], examplesJp = [], examplesEn = [];
    for (int i = 0; i < examples.length;i+=2){
      if(examples[i] == "") continue;

      // key sentence
      if(examples[i].startsWith("<span class=\"green\">(ks")){
        keySentencesJp.add(examples[i]); keySentencesEn.add(examples[i+1]);
      }
      // normal example
      else {
        examplesJp.add(examples[i]); examplesEn.add(examples[i+1]);
      }
    }

    dojgEntries.add(DojgEntry(
      grammaticalConcept: dataSplit[0],
      usage: dataSplit[1] != "" ? dataSplit[1] : null,
      equivalent: dataSplit[2] != "" ? dataSplit[2] : null,
      pos: dataSplit[44] != "" ? dataSplit[44] : null,
      relatedExpression: dataSplit[45] != "" ? dataSplit[45] : null,
      antonymExpression: dataSplit[46] != "" ? dataSplit[46] : null,

      formation: dataSplit[43] != "" ? dataSplit[43] : null,

      volume: dataSplit[4],
      volumeTag: dataSplit[5],
      volumeJp: dataSplit[6],
      page: int.parse(dataSplit[7]),

      cloze: dataSplit[8],
      keySentencesJp: keySentencesJp, keySentencesEn: keySentencesEn,
      examplesJp: examplesJp, examplesEn : examplesEn,

      note: dataSplit[42] != "" ? dataSplit[42] : null,
      noteImageName: dataSplit[41] != ""
      ? dojgMediaMapping[
        dataSplit[41].replaceFirst("<img src=\"", "").replaceFirst("\" />", "")
      ]!
      : dataSplit[41],
    ));
  }

  return dojgEntries;

}

bool checkDojgImported() {

  String dojgPath = p.join(
    g_documentsDirectory.path, "DaKanji", "dojg", "collection.anki2"
  );
  
  return File(dojgPath).existsSync();

}

bool checkDojgWithMediaImported() {

  String dojgPath = p.join(
    g_documentsDirectory.path, "DaKanji", "dojg", "1"
  );
  
  return File(dojgPath).existsSync();

}

/// Get all DoJG deck entries from the SQLite database
List<List<String>> getAllEntries() {

  Database dojgDb = sqlite3.open(
    p.join(g_documentsDirectory.path, "DaKanji", "dojg", "collection.anki2")
  );

  ResultSet r = dojgDb.select("SELECT \"tags\", \"flds\", \"sfld\" FROM \"notes\"");

  return r.rows.map((row) => 
    row.map((e) => 
      e.toString()
    ).toList()
  ).toList();

}