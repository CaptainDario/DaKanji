// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:archive/archive_io.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path/path.dart' as p;
import 'package:tuple/tuple.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/downloads/download_popup.dart';
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_loading_indicator.dart';

/// Download the audio files from the github release matching this version
void downloadAudio(BuildContext context) async {

  await downloadPopup(
    context: context,
    dismissable: true,
    btnOkOnPress: () async {
      downloadAssetFromGithubRelease(
        File(g_DakanjiPathManager.audiosDirectory.path),
        g_GithubApiDependenciesRelase,
      ).then((value) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      });
      AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        dismissOnTouchOutside: false,
        customHeader: Image.asset("assets/images/dakanji/icon.png"),
        dialogType: DialogType.noHeader,
        body: StreamBuilder(
          stream: g_initAppInfoStream.stream,
          builder: (context, snapshot) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const DaKanjiLoadingIndicator(),
                    const SizedBox(height: 8,),
                    Text(
                      snapshot.data ?? ""
                    ),
                  ],
                ),
              ),
            );
          }
        )
      ).show();
    }
  ).show();

}

/// Tries to copy `asset` from assets and if that fails,
/// downloads it from `url` (github). `path` is the destination folder inside of
/// `applications_documents_directory/DaKanji/` where, the file extracts the
/// zip will be extracted.
/// 
/// Note: `asset` is expected to be a zipped file in assets/github
Future<void> getAsset(FileSystemEntity asset, String dest, String url,
  BuildContext context, bool askToDownload) async
{

  // if the file already exists delete it
  final file = File(p.joinAll([
      g_DakanjiPathManager.dakanjiSupportDirectory.path,
      ...asset.path.split("/")
    ]));
  if (file.existsSync()) {
    file.deleteSync();
    debugPrint("Deleted ${asset.uri.pathSegments.last}");
  }
  // otherwise create the folder structure
  else{
    file.parent.createSync(recursive: true);
  }

  try {
    await copyFromAssets(asset, file.parent);
  }
  catch (e){
    if(askToDownload) {
      
      await downloadPopup(
        // ignore: use_build_context_synchronously
        context: context,
        btnOkOnPress: () {}
      ).show();
    }

    while(true){
      try{
        bool downloaded = await downloadAssetFromGithubRelease(file, url,);
        if(!downloaded) { throw Exception(); }
        break;
      }
      catch (e){
        debugPrint(e.toString());
        await AwesomeDialog(
          // ignore: use_build_context_synchronously
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
Future<void> copyFromAssets(FileSystemEntity assetPath, Directory dest) async {

  String assetPathString = "${assetPath.path.split(".").first}.zip";
  debugPrint(assetPathString);

  // Get the zipped file from assets
  ByteData data = await rootBundle.load(assetPathString);
  final archive = ZipDecoder().decodeBytes(data.buffer.asInt8List());
  g_initAppInfoStream.add(
    "Unpacking: ${p.withoutExtension(assetPath.uri.pathSegments.lastWhere((e) => e!=""))}");

  Stopwatch s = Stopwatch()..start();
  await compute(
    extractAssetArchiveToDisk,
    Tuple2(archive, dest.path),
    debugLabel: "Extraction isolate: ${dest.uri}"
  );
  debugPrint(s.elapsed.toString());

}

/// Wrapper for `extractArchiveToDisk` to run it in an isolate
void extractAssetArchiveToDisk(Tuple2 params) async {

  await extractArchiveToDisk(params.item1, params.item2);

}

/// Downloads the given `assetName` from the GitHub (`url`), uses the release
/// matching this version
Future<bool> downloadAssetFromGithubRelease(File destination, String url) async 
{
  // get all releases
  Dio dio = Dio(); String downloadUrl = "";
  bool downloadError = false;
  Response? response = await dio.get(url)
    .then((value) {
      return value;
    }).catchError((error, stackTrace) {
      debugPrint(error.toString());
      downloadError = true;
      return Response(requestOptions: RequestOptions());
    });

  if(downloadError) {
    debugPrint("Encountered error while downloading: $downloadError");
    return false;
  }

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
  downloadError = false;
  await Dio().download(
    downloadUrl, "${destination.path}.zip",
    onReceiveProgress: (received, total) {
      if (total != -1) {
        String progress =
          "${fileName.split(".")[0]}: ${"${(received / total * 100).toStringAsFixed(0)}%"}";
        g_initAppInfoStream.add(progress);
      }
    }
  ).onError((error, stackTrace) {
    debugPrint(error.toString());
    downloadError = true;
    return Response(requestOptions: RequestOptions());
  });

  if(downloadError) {
    debugPrint("Encountered error while downloading: $downloadError");
    return false;
  }

  debugPrint("Downloaded $fileName to ${destination.path}");

  await compute(
    (Tuple2<String, String> paths) async {
      await extractFileToDisk(paths.item1, paths.item2);
    },
    Tuple2("${destination.path}.zip", destination.parent.path));
  debugPrint("Extracted $destination");
  
  // delete the zip file
  File("${destination.path}.zip").deleteSync();

  return true;
}
