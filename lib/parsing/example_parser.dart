// Package imports:
import 'package:dakanji_db/parsing/example/example_parser.dart';
import 'package:dakanji_db/parsing/example/multi_example_parser.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';



/// A list containing the names of files that are valid yomtain files
List<String> validExampleFiles = [exampleFile, multiExampleFile];

/// The naming pattern for japanese only example files
String exampleFile = "example_bank_";
/// The naming pattern for multi example files
String multiExampleFile = "multi_example_bank_";

/// Parses the given yomitan dictionary zip
Future parseDictionaryZip (File dictZip, DaKanjiDB db) async {



}

/// Parses the given dakanji example folder
Future parseExampleFolder(Directory exampleDir, DaKanjiDB db) async {

  /// Get all files from the given folder that can be parsed
  List<File> validFiles = exampleDir.listSync().where((f) => 
    f.statSync().type == FileSystemEntityType.file &&
    validExampleFiles.any((ext) => p.basename(f.path).contains(ext))
  )
  .map((f) => File(f.path)).toList();

  // parse the kanji bank files
  for (var file in validFiles) {
    
    // parse `kanji_bank`-files
    if(p.basename(file.path).contains(exampleFile)){
      print("Parsing ${p.basename(file.path)} as `$exampleFile`");
      await parseExampleFile(file, db); 
    }

    // parse `kanji_meta_bank`-files
    if(p.basename(file.path).contains(multiExampleFile)){
      print("Parsing ${p.basename(file.path)} as `$multiExampleFile`");
      await parseMultiExampleFile(file, db); 
    }

  }

}
