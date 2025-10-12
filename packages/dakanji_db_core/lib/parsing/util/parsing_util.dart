import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';



/// Read a .tar.bz2 file and **streams** the content of the first file line by
/// line
Stream<String> getStringStreamFromTarBz2File(File file) {
  
  final bzip2Bytes = file.readAsBytesSync();
  final tarBytes = BZip2Decoder().decodeBytes(bzip2Bytes);
  final tarArchive = TarDecoder().decodeBytes(tarBytes);

  // Get the first file from the archive
  final firstFile = tarArchive.files.first;
  final contentBytes = firstFile.content as List<int>;

  final byteStream = Stream.fromIterable([contentBytes]);

    // 2. Transform the stream to decode UTF-8 and split by lines.
    final linesStream = byteStream
      .transform(utf8.decoder)
      .transform(const LineSplitter());

  return linesStream;

}

/// Reads a DaKanji DB compatabile data source (KanjiVG, Yomitan, ...)
/// Can read a zip file from disk or from .
/// 
/// [fileOrder] can be used to define a custom order in which the files should
/// be processed. The name can be a RegExp pattern that will be matched. If the
/// list is short than the number of files in the archive the unspecified files
/// are processed in the order they are read.
Iterable<({String fileName, Uint8List fileContent})> dakanjiDBDataSourceIterator(
  {
    String? archivePath,
    Uint8List? archiveBytes,
    List<String> fileOrder=const [],
    List<String> filesToExclude = const []
  }
) sync* {

  assert(archivePath != null || archiveBytes != null);

  late final InputStream inputStream;

  if (archiveBytes != null) inputStream = InputMemoryStream(archiveBytes);
  else if (archivePath != null) inputStream = InputFileStream(archivePath);

  try {
    final Archive archive = ZipDecoder().decodeStream(inputStream);
    yield* _archiveIteratorStreamed(
      archive,
      fileOrder: fileOrder,
      filesToExclude: filesToExclude
    ); 
  }
  finally {
    inputStream.close();  
  }

}

/// Reads a zip file in a streamed manner, ie it does not load the entire
/// archive into memory at once
/// 
/// [fileOrder] can be used to define a custom order in which the files should
/// be processed. The name can be a RegExp pattern that will be matched. If the
/// list is short than the number of files in the archive the unspecified files
/// are processed in sorted are read.
Iterable<({String fileName, Uint8List fileContent})> _archiveIteratorStreamed(
  Archive archive,
  {
    List<String> fileOrder=const [],
    List<String> filesToExclude = const []
  }
) sync* {

  List processedFiles = [];
  for (var f in fileOrder) {

    // skip files that should be excluded
    if (filesToExclude.contains(p.basename(f))) continue;

    // get all files that match the current search order file name
    List<ArchiveFile> matchedFiles = archive.files
      .where((e) => e.name.contains(RegExp(f)))
      .toList();

    // Iterate over the files for which an order was specified
    for (ArchiveFile matchedFile in matchedFiles) {
      final content = matchedFile.readBytes()!;
      processedFiles.add(matchedFile.name);
      yield (fileName: matchedFile.name, fileContent: content); 
    }
  }

  print("asjkhdg ${archive.files}");
  // iterate over the remaining files
  for (final entity in archive.files.sorted((a, b) => a.name.compareTo(b.name))) {
    if (entity.isFile && !processedFiles.contains(entity.name)) {
      // get the file's content as a string
      final content = entity.readBytes()!;
      yield (fileName: entity.name, fileContent: content);
    }
  }
}
