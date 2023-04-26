import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:archive/archive_io.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:universal_io/io.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path/path.dart' as p;

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/downloads/download_popup.dart';
import 'package:da_kanji_mobile/globals.dart';



/// Tries to copy `asset` from assets and if that fails,
/// downloads it from `url` (github). `path` is the destination folder inside of
/// `applications_documents_directory/DaKanji/` where, the file extracts the
/// zip will be extracted.
/// 
/// Note: `asset` is expected to be a zipped file in assets/github
Future<void> getAsset(FileSystemEntity asset, String dest, String url,
  BuildContext context) async
{
  // Search and create db file destination folder if not exist
  final documentsDirectory = await path_provider.getApplicationDocumentsDirectory();

  // if the file already exists delete it
  final dbFile = File(p.joinAll([documentsDirectory.path, "DaKanji", ...asset.path.split("/")]));
  if (dbFile.existsSync()) {
    dbFile.deleteSync();
    print("Deleted ${asset.uri.pathSegments.last} ISAR");
  }
  // otherwise create the folder structure
  else{
    dbFile.parent.createSync(recursive: true);
  }

  try {
    await copyFromAssets(asset.path, dbFile.parent);
  }
  catch (e){
    if(!g_userAllowedToDownload)
      await downloadPopup(
        context: context,
        btnOkOnPress: () => g_userAllowedToDownload = true
      ).show();

    while(true){
      try{
        await downloadAssetFromGithubRelease(dbFile, url,);
        break;
      }
      catch (e){
        await AwesomeDialog(
          context: context,
          headerAnimationLoop: false,
          desc: LocaleKeys.HomeScreen_download_failed_popup_text.tr(),
          btnOkText: LocaleKeys.HomeScreen_download_failed_popup_retry.tr(),
          btnOkColor: g_Dakanji_green,
          dialogType: DialogType.noHeader,
          btnOkOnPress: (){}
        ).show();
        print("Download failed, retrying...");
      }
    }
  }
}

/// copies the zipped database from assets to the user's documents directory
/// and unzips it, if it does not exist already
/// 
/// Caution: throws exception if the asset does not exist
Future<void> copyFromAssets(String assetPath,  Directory dest) async {

  assetPath = assetPath.split(".").first + ".zip";
  print(assetPath);

  // Get the zipped file from assets
  ByteData data = await rootBundle.load(assetPath);
  final archive = ZipDecoder().decodeBytes(data.buffer.asInt8List());
  extractArchiveToDisk(archive, dest.path);
}

/// Downloads the given `assetName` from the given GitHub release
Future<void> downloadAssetFromGithubRelease(File destination, String url) async 
{
  // get all releases
  Dio dio = Dio(); String downloadUrl = "";
  Response response = await dio.get(url);
  String extension = destination.uri.pathSegments.last.split(".").length > 1
    ? "." + destination.uri.pathSegments.last.split(".").last
    : "";

  // iterate over the releases
  for (var release in response.data){
    // if the version number matches the current version
    if(release["tag_name"] == "v" + g_VersionNumber){
      // iterate over the assets in this release
      for (var element in release["assets"]) {
        if((element["name"] as String).startsWith(destination.uri.pathSegments.last.replaceAll(extension, ""))) {
          downloadUrl = element["browser_download_url"];
          break;
        }
      }
    }
  }
    
  // download the asset
  String fileName = destination.uri.pathSegments.last;
  await Dio().download(
    downloadUrl, destination.path + ".zip",
    onReceiveProgress: (received, total) {
      if (total != -1) {
        String progress =
          "${fileName.split(".")[0]}: ${(received / total * 100).toStringAsFixed(0) + "%"}";
        g_initTextStream.add(progress);
        print(progress);
      }
    }
  );
  print("Downloaded ${fileName} to ${destination.path}");

  // unzip the asset
  await extractFileToDisk(
    destination.path + ".zip",
    destination.parent.path
  );
  print("Extracted $destination");
  
  // delete the zip file
  File(destination.path + ".zip").deleteSync();
}
