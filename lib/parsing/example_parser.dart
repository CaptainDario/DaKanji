// Package imports:
import 'package:dakanji_db/parsing/example/example_bank_parser.dart';
import 'package:dakanji_db/parsing/example/example_text_parser.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';



/// A list containing the names of files that are valid yomtain files
List<String> validExampleFiles = [exampleFile, exampleTextFile];

/// The naming pattern for multi example files
String exampleFile = "example_bank_";
/// The naming pattern for japanese only example files
String exampleTextFile = "example_text_";

/// Parses the given yomitan dictionary zip
Future parseExampleZip (File dictZip, DaKanjiDB db) async {

  // TODO

}

/// Parses the given dakanji example folder
Future parseExampleFolder(Directory exampleDir, DaKanjiDB db) async {

  /// Get all files from the given folder that can be parsed
  List<File> validFiles = exampleDir.listSync().where((f) => 
    f.statSync().type == FileSystemEntityType.file &&
    validExampleFiles.any((ext) => p.basename(f.path).contains(ext))
  )
  .map((f) => File(f.path)).toList();

  // parse the example bank files
  for (var file in validFiles) {
    
    // parse `example_bank`-files
    if(p.basename(file.path).contains(exampleFile)){
      print("Parsing ${p.basename(file.path)} as `$exampleFile`");
      await parseExampleFile(file, db); 
    }

    // parse `example_text`-files
    if(p.basename(file.path).contains(exampleTextFile)){
      print("Parsing ${p.basename(file.path)} as `$exampleTextFile`");
      await parseExampleTextFile(file, db); 
    }

  }

}
