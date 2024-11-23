import 'dart:io';
import 'package:euc/euc.dart';



Map<String, List<String>> convertKradToMap(String filePath){

  // Open the file and read its contents with a specific encoding
  final file = File(filePath);
  final content = file.readAsBytesSync();
  final decoded = EucJP().decode(content);
  final lines = decoded.split("\n");

  Map<String, List<String>> kanjiToRadical = {};
  for (var i = 0; i < lines.length; i++) {

    String line = lines[i];

    if(line.startsWith("#") || line == ""){
      continue;
    }
    
    List<String> lineSplit = line.split(":");
    String kanji = lineSplit[0];
    List<String> radicals = lineSplit[1].split(" ");
    
    kanjiToRadical[kanji] = radicals;
    
  }

  return kanjiToRadical;

}