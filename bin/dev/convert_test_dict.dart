import 'package:dakanji_db/parsing/dictionary_parser.dart';
import 'dart:io';
import 'setup_conversion.dart';



void main() async {
  
  final setup = setupConversion(ConversionTarget.sample);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(setup.item1, setup.item2);
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  exit(0);

}
