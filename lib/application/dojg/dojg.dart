import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:file_picker/file_picker.dart';
import 'package:universal_io/io.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';



/// Let the user select the anki DoJG deck and import it.
Future<bool> importDoJGDeck () async {

  bool imported = false;

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ["apkg"]
  );
  if(result != null){
    // TODO validate the selected file


    // get current file path and dakanji directory
    File dojg = File(result.files.single.path!);
    String copyTo = p.join(g_documentsDirectory.path, "DaKanji", "dojg");

    // extract the zip to the dakanji directory
    final inputStream = InputFileStream(dojg.path);
    final archive = ZipDecoder().decodeBuffer(inputStream);
    extractArchiveToDisk(archive, copyTo);
  }

  return imported;

}

Future<void> deleteDojg() async {

}

Future<bool> checkDojgImported() async {

  String dojgPath = p.join(
    g_documentsDirectory.path, "DaKanji", "dojg", "collection.anki2"
  );
  
  return await File(dojgPath).existsSync();

}

Future<bool> checkDojgWithMediaImported() async {

  String dojgPath = p.join(
    g_documentsDirectory.path, "DaKanji", "dojg", "1"
  );
  
  return File(dojgPath).existsSync();

}

List<List<String>> getAllEntries() {

  Database dojgDb = sqlite3.open(
    p.join(g_documentsDirectory.path, "DaKanji", "dojg", "collection.anki2")
  );

  ResultSet r = dojgDb.select("SELECT \"tags\", \"flds\", \"sfld\" FROM \"notes\" LIMIT 0,30");

  return r.rows.map((row) => 
    row.map((e) => 
      e.toString()
    ).toList()
  ).toList();

}