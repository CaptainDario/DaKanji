import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;



/// Reads a DaKanji DB compatabile data source (KanjiVG, Yomitan, ...)
/// Can read a zip file from disk or from .
/// 
/// [fileOrder] can be used to define a custom order in which the files should
/// be processed. The name can be a RegExp pattern that will be matched. If the
/// list is short than the number of files in the archive the unspecified files
/// are processed in the order they are read.
Iterable<({String fileName, String fileContent})> dakanjiDBDataSourceIterator(
  {
    String? archivePath,
    Uint8List? archiveBytes,
    List<String> fileOrder=const [],
    List<String> extensionsToInclude = const [".json", ".txt"]
  }
) sync* {

  assert(archivePath != null || archiveBytes != null);

  late final InputStream inputStream;

  if (archiveBytes != null) inputStream = InputMemoryStream(archiveBytes);
  else if (archivePath != null) inputStream = InputFileStream(archivePath);

  final Archive archive = ZipDecoder().decodeStream(inputStream);
  yield* _archiveIteratorStreamed(
    archive,
    fileOrder: fileOrder,
    extensionsToInclude: extensionsToInclude
  );

  inputStream.close();

}

/// Reads a zip file in a streamed manner, ie it does not load the entire
/// archive into memory at once
/// 
/// [fileOrder] can be used to define a custom order in which the files should
/// be processed. The name can be a RegExp pattern that will be matched. If the
/// list is short than the number of files in the archive the unspecified files
/// are processed in the order they are read.
Iterable<({String fileName, String fileContent})> _archiveIteratorStreamed(
  Archive archive,
  {
    List<String> fileOrder=const [],
    List<String> extensionsToInclude = const [".json", ".txt"]
  }
) sync* {

  List processedFiles = [];
  for (var f in fileOrder) {
    // get all files that match the current search order file name
    List<ArchiveFile> matchedFiles = archive.files
      .where((e) => e.name.contains(RegExp(f)))
      .toList();

    // Iterate over the files for which an order was specified
    for (ArchiveFile matchedFile in matchedFiles) {
      final content = utf8.decode(matchedFile.readBytes()!);
      processedFiles.add(matchedFile.name);
      yield (fileName: matchedFile.name, fileContent: content); 
    }
  }

  // iterate over the remaining files
  for (final entity in archive.files.sorted((a, b) => a.name.compareTo(b.name))) {
    if (entity.isFile && !processedFiles.contains(entity.name)
        && extensionsToInclude.contains(p.extension(entity.name))) {
      // get the file's content as a string
      final content = utf8.decode(entity.readBytes()!);
      yield (fileName: entity.name, fileContent: content);
    }
  }
}
