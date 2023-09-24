// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:archive/archive_io.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/downloads/download_popup.dart';

/// Tries to copy `asset` from assets and if that fails,
/// downloads it from `url` (github). `path` is the destination folder inside of
/// `applications_documents_directory/DaKanji/` where, the file extracts the
/// zip will be extracted.
/// 
/// Note: `asset` is expected to be a zipped file in assets/github
Future<void> getAsset(FileSystemEntity asset, String dest, String url,
  BuildContext context, bool askToDownload) async
{
  // Search and create db file destination folder if not exist

  // if the file already exists delete it
  final file = File(p.joinAll([g_documentsDirectory.path, "DaKanji", ...asset.path.split("/")]));
  if (file.existsSync()) {
    file.deleteSync();
    debugPrint("Deleted ${asset.uri.pathSegments.last}");
  }
  // otherwise create the folder structure
  else{
    file.parent.createSync(recursive: true);
  }

  try {
    await copyFromAssets(asset.path, file.parent);
  }
  catch (e){
    if(askToDownload) {
      // ignore: use_build_context_synchronously
      await downloadPopup(
        context: context,
        btnOkOnPress: () {}
      ).show();
    }

    while(true){
      try{
        await downloadAssetFromGithubRelease(file, url,);
        break;
      }
      catch (e){
        // ignore: use_build_context_synchronously
        await AwesomeDialog(
          context: context,
          headerAnimationLoop: false,
          desc: LocaleKeys.HomeScreen_download_failed_popup_text.tr(),
          btnOkText: LocaleKeys.HomeScreen_download_failed_popup_retry.tr(),
          btnOkColor: g_Dakanji_green,
          dialogType: DialogType.noHeader,
          btnOkOnPress: (){}
        ).show();
        debugPrint("Download failed, retrying...");
      }
    }
  }
}

/// copies the zipped database from assets to the user's documents directory
/// and unzips it, if it does not exist already
/// 
/// Caution: throws exception if the asset does not exist
Future<void> copyFromAssets(String assetPath,  Directory dest) async {

  assetPath = "${assetPath.split(".").first}.zip";
  debugPrint(assetPath);

  // Get the zipped file from assets
  ByteData data = await rootBundle.load(assetPath);
  final archive = ZipDecoder().decodeBytes(data.buffer.asInt8List());
  extractArchiveToDisk(archive, dest.path);
}

/// Downloads the given `assetName` from the GitHub (`url`), uses the release
/// matching this version
Future<void> downloadAssetFromGithubRelease(File destination, String url) async 
{
  // get all releases
  Dio dio = Dio(); String downloadUrl = "";
  Response response = await dio.get(url);
  String extension = destination.uri.pathSegments.last.split(".").length > 1
    ? ".${destination.uri.pathSegments.last.split(".").last}"
    : "";

  // iterate over the releases
  for (var release in response.data){
    // if the version number matches the current version
    if(release["tag_name"] == "v${g_Version.versionString}"){
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
    downloadUrl, "${destination.path}.zip",
    onReceiveProgress: (received, total) {
      if (total != -1) {
        String progress =
          "${fileName.split(".")[0]}: ${"${(received / total * 100).toStringAsFixed(0)}%"}";
        g_downloadFromGHStream.add(progress);
      }
    }
  );
  debugPrint("Downloaded $fileName to ${destination.path}");

  // unzip the asset
  await extractFileToDisk(
    "${destination.path}.zip",
    destination.parent.path
  );
  debugPrint("Extracted $destination");
  
  // delete the zip file
  File("${destination.path}.zip").deleteSync();
}
