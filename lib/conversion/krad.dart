import 'dart:io';
import 'package:euc/euc.dart';
import 'package:tuple/tuple.dart';



Map<String, Tuple2<int, List<String>>> convertRadkToMap(String filePath){

  // Open the file and read its contents with a specific encoding
  final file = File(filePath);
  final content = file.readAsBytesSync();
  final decoded = EucJP().decode(content);
  final lines = decoded.split("\n");

  Map<String, Tuple2<int, List<String>>> radicalToKanji = {};
  for (var i = 0; i < lines.length; i++) {
    
    String line = lines[i];
    List<String> lineSplit = line.split(" ");

    if(line.startsWith("#")){
      continue;
    }
    else if(line.startsWith("\$")){
      radicalToKanji[lineSplit[1]] = Tuple2(
        int.parse(lineSplit[2]), lines[++i].split(""));
    }
    
  }

  return radicalToKanji;

}