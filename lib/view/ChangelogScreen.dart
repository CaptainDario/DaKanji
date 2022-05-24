import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/model/Changelog.dart';



/// The "changelog"-screen.
/// 
/// Shows the complete CHANGELOG.md 
class ChangelogScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("$APP_TITLE - ${LocaleKeys.ChangelogScreen_title.tr()}"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Center(
          child: 
            Container(
              child: Column(
                children: [
                  Expanded(
                    child: Markdown(
                      data: GetIt.I<Changelog>().wholeChangelog,
                      selectable: false,
                      onTapLink: 
                      (String text, String? url, String? title) async {
                        if(await canLaunchUrlString(url!))
                          launchUrlString(url);
                      },
                    )
                  ),
                ]
              )
            )
        ),
      ),
    );
  }
}
