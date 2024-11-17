import 'dart:io';
import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:dakanji_db/parsing/kanji/kanji_bank_v3_parser.dart';
import 'package:drift/isolate.dart';
import 'package:path/path.dart' as p;
import 'package:archive/archive_io.dart';
import 'package:tuple/tuple.dart';



/// A list containing the names of files that are valid yomtain files
List<String> validDictionaryFiles = [
  "kanji_bank"
];

/// Parses the given yomitan dictionary zip
Future parseDictionaryZip (File dictZip, DaKanjiDB db) async {

  // TODO implement

  // Use an InputFileStream to access the zip file without storing it in memory.
  final inputStream = InputFileStream('test.zip');
  // Decode the zip from the InputFileStream. The archive will have the contents of the
  // zip, without having stored the data in memory. 
  final archive = ZipDecoder().decodeStream(inputStream);
  // For all of the entries in the archive
  for (var file in archive.files) {
    // If it's a file and not a directory 
    if (file.isFile) {
      // Write the file content to a directory called 'out'.
      // In practice, you should make sure file.name doesn't include '..' paths
      // that would put it outside of the extraction directory.
      // An OutputFileStream will write the data to disk.
      final outputStream = OutputFileStream('out/${file.name}');
      // The writeContent method will decompress the file content directly to disk without
      // storing the decompressed data in memory. 
      file.writeContent(outputStream);
      // Make sure to close the output stream so the File is closed.
      outputStream.close();
    }
  }

}


/// Parses the given yomitan dictionary folder
Future parseDictionaryFolder(Directory dictDir, DaKanjiDB db) async {

  /// Get all files from the given folder that can be parsed
  List<File> validFiles = dictDir.listSync().where((f) => 
    f.statSync().type == FileSystemEntityType.file &&
    validDictionaryFiles.any((ext) => p.basename(f.path).contains(ext))
  )
  .map((f) => File(f.path)).toList();

  for (var file in validFiles) {
    await parseDictionaryFile(Tuple2(file, db));
  }

}

/// Depending on the file name applies the correct conversion method
Future parseDictionaryFile(Tuple2<File, DaKanjiDB> args) async {

  File dictFile = args.item1;
  DaKanjiDB db = args.item2;

  // parse all files that are `kanji_bank`
  if(p.basename(dictFile.path).contains("kanji_bank")){

    print("Parsing ${p.basename(dictFile.path)} as `kanji_bank`");
    await parseKanjiBankV3(dictFile, db);
    
  }
  // TODO other dictionary file types

}