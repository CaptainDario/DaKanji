// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/releases/version.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Checks if a new version of DaKanji is available on Github.
/// Returns the changelog of the newest version if there is a new version,
/// otherwise null.
Future<void> updateAvailable() async {

  try {
    Dio().get(g_GithubReleasesApi).then((response) async {

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

      //  get all versions that are newer than the current one
      List<Version> newVersions = [];
      for (var ghVersion in versions){
        if(g_Version < ghVersion){
          newVersions.add(ghVersion);
        }
      }

      List<String> updates = [];

      if (newVersions.isNotEmpty){
        if(updates.isEmpty){
          if(newVersions.length == 1) {
            updates.add("${LocaleKeys.HomeScreen_new_version_available_text.tr()} ");
          } else {
            updates.add("${LocaleKeys.HomeScreen_new_versions_available_text.tr().replaceAll("{NEW_VERSIONS}", newVersions.length.toString())} ");
          }
          updates[0] += "${LocaleKeys.HomeScreen_new_version_comparison.tr()}\n\n\n\n"
            .replaceAll("{NEW_VERSION_NUMBER}", versions.first.toString())
            .replaceAll("{VERSION_NUMBER}", g_Version.toString());
            
        }

        for (var version in newVersions) {
          var release = response.data.firstWhere(
            (e) => e["tag_name"] == "v${version.toList().join(".")}"
          );
          String releaseNotes = "\n\n\n\n ## ${release["name"]}\n\n${release['body']}\n\n";
          // remove the "Which release do I need?" from the release notes
          releaseNotes = releaseNotes.substring(0, releaseNotes.indexOf("Which release do I need?")-2);
          updates.add(releaseNotes);
        }
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList("updateAvailable", updates);
      prefs.setString("updateVersion", versions.first.fullVersionString);

    }).onError((e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    });
  }
  on Exception catch (e) {
    debugPrint("Could not check for new version $e");
    return;
  }

}
