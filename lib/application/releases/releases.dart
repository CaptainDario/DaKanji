import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:da_kanji_mobile/domain/releases/version.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



void openStoreListing(){
  if(Platform.isAndroid) {
    launchUrlString(g_PlaystorePage);
  }
  else if(Platform.isIOS || Platform.isMacOS) {
    launchUrlString(g_AppStorePage);
  }
  else if(Platform.isWindows) {
    launchUrlString(g_MicrosoftStorePage);
  }
  else if(Platform.isLinux) {
    launchUrlString(g_SnapStorePage);
  }
  else {
    throw Exception("Platform not supported");
  }
}

/// Checks if a new version of DaKanji is available on Github.
/// Returns the changelog of the newest version if there is a new version,
/// otherwise null.
Future<String?> updateAvailable() async {

  String? ret = null;

  Response response = await Dio().get(g_GithubReleasesApi);
  List<Version> versions = (List<String?>.from(
    // extract tag name (version)
    response.data.map((e) => e["tag_name"])))
    // assure its a valid DaKanji version
    .nonNulls.where((String element) => element.startsWith("v"))
    // remove the "v" from the version
    .map((String e) => e.replaceAll("v", ""))
    // assure its a valid version (not beta, etc.)
    .where((String element) => int.tryParse(element.replaceAll(".", "")) != null)
    // convert to a list of tuples
    .map((e) => Version.fromString(e)).toList()
    // sort based on version number parts
    ..sort(((a, b) => b.compareTo(a)));

  // check if the newest version on GH is newer than the current version
  List newVersions = [];
  for (var ghVersion in versions){
    if(g_Version < ghVersion){
      newVersions.add(ghVersion);
      break;
    }
  }

  if (newVersions != 0){
    if(ret == null){
      ret =  "# ${LocaleKeys.HomeScreen_new_version_available_heading.tr()} \n\n";
      if(newVersions == 1)
        ret += "${LocaleKeys.HomeScreen_new_version_available_text.tr()} ";
      else
        ret += "${LocaleKeys.HomeScreen_new_versions_available_text.tr().replaceAll("{NEW_VERSIONS}", newVersions.length.toString())} ";
      ret += "${LocaleKeys.HomeScreen_new_version_comparison.tr()}\n\n\n\n"
        .replaceAll("{NEW_VERSION_NUMBER}", versions.first.toString())
        .replaceAll("{VERSION_NUMBER}", g_Version.toString());
        
    }

    for (var version in newVersions) {
      var release = response.data.firstWhere(
        (e) => e["tag_name"] == "v${version.toList().join(".")}"
      );
      ret = (ret ?? "") + "\n\n\n\n ## ${release["name"]}\n\n${release['body']}\n\n";
    }
  }

  return ret;
}