import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'globals.dart';



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
    
    debugPrint('Database copied from assets to: $dbPath');

  } else {
    debugPrint('Database already exists at: $dbPath');
  }

  return dbPath;

}

Future<void> printAssetList() async {
  final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  debugPrint("${manifest.listAssets()}");
}