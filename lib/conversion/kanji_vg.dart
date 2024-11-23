import 'dart:io';



Map<String, String> convertKanjiVGFolderToMap(String folderPath){

  // Open the file and read its contents with a specific encoding
  final folder = Directory(folderPath);
  final entities = folder.listSync();

  Map<String, String> kanjiToSVG = {};
  for (var entity in entities) {
    
    // read the file
    final file = File(entity.path);
    final content = file.readAsStringSync();

    // Remove comments
    final commentRegExp = RegExp(r'<!--.*?-->', dotAll: true);
    String cleanedContent = content.replaceAll(commentRegExp, '');

    // get the kanji
    final regex = RegExp(r'kvg:element="([^"]+)"');
    final kanji = regex.firstMatch(cleanedContent)!.group(1)!;

    kanjiToSVG[kanji] = cleanedContent;

  }

  return kanjiToSVG;

}