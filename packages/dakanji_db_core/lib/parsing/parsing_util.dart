import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:path/path.dart' as p;



/// Reads a DaKanji DB compatabile data source (KanjiVG, Yomitan, ...)
/// Can read a zip file or a folder
Iterable<(String fileName, String fileContent)> dakanjiDBDataSourceIterator(String folderPath) sync* {

  if(folderPath.endsWith(".zip")){
    yield* archiveIteratorStreamed(folderPath);
  } else {
    yield* folderIteratorStreamed(folderPath);
  }

}

/// Reads a zip file in a streamed manner, ie it does not load the entire
/// archive into memory at once
Iterable<(String fileName, String fileContent)> archiveIteratorStreamed(String zipFilePath) sync* {

  final inputStream = InputFileStream(zipFilePath);
  final archive = ZipDecoder().decodeStream(inputStream);

  for (final entity in archive) {
    if (entity.isFile) {
      // get the file's content as a string
      final content = utf8.decode(entity.content);
      yield (entity.name, content);
    }
  }

  inputStream.close();
}

Iterable<(String fileName, String fileContent)> folderIteratorStreamed(String folderPath) sync* {

  final folder = Directory(folderPath);
  final entities = folder.listSync();

  for (var entity in entities) {
    if (entity is File) {
      final content = entity.readAsStringSync();
      yield (p.basename(entity.path), content);
    }
  }

}