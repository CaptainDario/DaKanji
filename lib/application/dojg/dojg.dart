import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
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
    String copyTo = p.join(
      (await path_provider.getApplicationDocumentsDirectory()).path, "DaKanji", "dojg"  
    );

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
    (await path_provider.getApplicationDocumentsDirectory()).path, "DaKanji", "dojg", "collection.anki2"
  );
  
  return await File(dojgPath).existsSync();

}

Future<bool> checkDojgWithMediaImported() async {

  String dojgPath = p.join(
    (await path_provider.getApplicationDocumentsDirectory()).path, "DaKanji", "dojg", "1"
  );
  
  return await File(dojgPath).existsSync();

}