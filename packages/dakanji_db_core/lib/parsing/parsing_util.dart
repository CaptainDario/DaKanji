import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';



/// Reads a DaKanji DB compatabile data source (KanjiVG, Yomitan, ...)
/// Can read a zip file or a folder
Iterable<String> dakanjiDBDataSourceIterator(String folderPath) sync* {

  if(folderPath.endsWith(".zip")){
    yield* archiveIteratorStreamed(folderPath);
  } else {
    yield* folderIteratorStreamed(folderPath);
  }

}

/// Reads a zip file in a streamed manner, ie it does not load the entire
/// archive into memory at once
Iterable<String> archiveIteratorStreamed(String zipFilePath) sync* {

  final inputStream = InputFileStream(zipFilePath);
  final archive = ZipDecoder().decodeStream(inputStream);

  for (final file in archive) {
    if (file.isFile) {
      // get the file's content as a string
      final content = utf8.decode(file.content);
      yield content;
    }
  }

  inputStream.close();
}

Iterable<String> folderIteratorStreamed(String folderPath) sync* {

  final folder = Directory(folderPath);
  final entities = folder.listSync();

  for (var entity in entities) {
    if (entity is File) {
      final content = entity.readAsStringSync();
      yield content;
    }
  }

}