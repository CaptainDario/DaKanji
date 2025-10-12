import 'dart:convert';
import 'dart:typed_data';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/media/media_importer.dart';
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';





Future parseAudioDataSource({
  String? audioDataSourceFile,
  Uint8List? audioDataSourceBytes,
  required DaKanjiDB db
  }) async {

  assert(audioDataSourceFile != null && audioDataSourceBytes != null);

  Iterable<({String fileName, Uint8List fileContent})> dataSources =
    dakanjiDBDataSourceIterator(
      archivePath: audioDataSourceFile,
      archiveBytes: audioDataSourceBytes,
      fileOrder: ["index.json", "entries.json"]
  );

  if(dataSources.first.fileName == "index.json") {
    await parseAidopDataSource2Json(utf8.decode(dataSources.first.fileContent), db);
    await parseAudioDataSource2(dataSources, db);
  } else if(dataSources.first.fileName == "entries.json") {
    await parseAudioDataSource3(dataSources, db);
  } else {
    await parseAudioDataSource1(dataSources, db);
  }


}

Future parseAudioDataSource1(
  Iterable<({String fileName, Uint8List fileContent})> dataSources,
  DaKanjiDB db
) async {
  for (final dataSource in dataSources) {
    print("Processing audio source file: ${dataSource.fileName}");
    await importMediaFile(dataSource.fileName, dataSource.fileContent, 1, db);
  }
}

Future parseAudioDataSource2(
  Iterable<({String fileName, Uint8List fileContent})> dataSources,
  DaKanjiDB db
) async {
  for (final dataSource in dataSources) {
    print("Processing audio source file: ${dataSource.fileName}");
    await importMediaFile(dataSource.fileName, dataSource.fileContent, 2, db);
  }
}

Future parseAidopDataSource2Json(
  String jsonString,
  DaKanjiDB db
) async {

  Map jsonMap = jsonDecode(jsonString);
  // parse meta
  jsonMap["meta"];
  // parse headwords
  List headwords = jsonMap["headwords"];
  headwords = [];
  // parse file contents
  List files = jsonMap["files"];

}

Future parseAudioDataSource3(
  Iterable<({String fileName, Uint8List fileContent})> dataSources,
  DaKanjiDB db
) async {
  for (final dataSource in dataSources) {
    print("Processing audio source file: ${dataSource.fileName}");
    await importMediaFile(dataSource.fileName, dataSource.fileContent, 3, db);
  }
}