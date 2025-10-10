import 'dart:convert';

import 'package:flutter/services.dart';

import 'globals.dart';

import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';



/// Copies the prebuilt database from the assets to the file system and returns
/// the path to the copied database file.
Future<String> copyDbFromAssetsToFS() async {

  final Directory docDir = await getApplicationDocumentsDirectory();
  final String dbPath = p.join(docDir.path, dbFileName);

   final bool exists = await File(dbPath).exists();

  if (!exists) {
    ByteData data = await rootBundle.load(dbFileAssetPath);

    // Convert the ByteData to a List<int> (a raw byte list)
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // 4. Write the bytes to the local file system
    await File(dbPath).writeAsBytes(bytes, flush: true);
    
    print('Database copied from assets to: $dbPath');

  } else {
    print('Database already exists at: $dbPath');
  }

  return dbPath;

}

Future<void> printAssetList() async {
  final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  print(manifest.listAssets());
}