// Flutter imports:
// Project imports:
import 'package:da_kanji_mobile/core/releases/changelog.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// The "changelog"-screen.
/// 
/// Shows the complete CHANGELOG.md 
class ChangelogScreen extends StatelessWidget {

  const ChangelogScreen({super.key});
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("$g_AppConfig.appTitle - ${LocaleKeys.ChangelogScreen_title.tr()}"),
      ),
      body: PopScope(
        child: Center(
          child: Column(
              children: [
                Expanded(
                  child: Markdown(
                    data: GetIt.I<Changelog>().wholeChangelog,
                    selectable: false,
                    onTapLink: 
                    (String text, String? url, String? title) async {
                      if(await canLaunchUrlString(url!)) {
                        launchUrlString(url);
                      }
                    },
                  )
                ),
              ]
            )
        ),
      ),
    );
  }
}
