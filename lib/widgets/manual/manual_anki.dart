// Flutter imports:
import 'dart:io';

import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:da_kanji_mobile/application/anki/anki.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

/// The manual for the TextScreen
class ManualAnki extends StatelessWidget {

  /// heading 1 text style
  final TextStyle heading_1 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  /// heading 2 text style
  final TextStyle heading_2 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  const ManualAnki(
    {
      super.key
    }
  );

  /// handle tap on a url
  void handleUrlTap(String text, String? href, String title, {bool useExternal = false})async {
    
    if(href != null){
      if(await canLaunchUrlString(href)){
        launchUrlString(href,
          mode: useExternal 
            ? LaunchMode.externalApplication
            : LaunchMode.platformDefault);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              Text(LocaleKeys.ManualScreen_anki_setup_title.tr(), style: heading_1,),
          
              const SizedBox(height: 10),
          
              Text(LocaleKeys.ManualScreen_anki_setup_intro.tr()),
          
              const SizedBox(height: 15),
              
              ExpansionTile(
                title: Text(LocaleKeys.ManualScreen_anki_setup_android_title.tr(), style: heading_2,),
                initiallyExpanded: Platform.isAndroid,
                children: [
                  MarkdownBody(
                    data: LocaleKeys.ManualScreen_anki_setup_android_text.tr(),
                    onTapLink: (String text, String? href, String title)
                      => handleUrlTap(text, href, title, useExternal: true)
                  ),
                  const SizedBox(height: 5,)
                ]
              ),
          
              const SizedBox(height: 15),
          
              ExpansionTile(
                title: Text(LocaleKeys.ManualScreen_anki_setup_desktop_title.tr(), style: heading_2,),
                initiallyExpanded: g_desktopPlatform,
                children: [
                  MarkdownBody(
                    data: LocaleKeys.ManualScreen_anki_setup_desktop_text.tr(),
                    onTapLink: handleUrlTap
                  ),
                  const SizedBox(height: 5),
                ],
              ),
          
              const SizedBox(height: 15),
              
              ExpansionTile(
                title: Text(LocaleKeys.ManualScreen_anki_setup_ios_title.tr(), style: heading_2,),
                initiallyExpanded: Platform.isIOS,
                children: [
                  MarkdownBody(
                    data: LocaleKeys.ManualScreen_anki_setup_ios_text.tr(),
                    onTapLink: handleUrlTap
                  ),
                  const SizedBox(height: 5),
                ],
              ),
          
              const SizedBox(height: 15),
          
              Text(LocaleKeys.ManualScreen_anki_setup_general_title.tr(), style: heading_2,),
              const SizedBox(height: 5),
              MarkdownBody(
                data: LocaleKeys.ManualScreen_anki_setup_general_text.tr(),
                onTapLink: handleUrlTap
              ),
          
              const SizedBox(height: 15),
          
              Text(LocaleKeys.ManualScreen_anki_connection_test_title.tr(), style: heading_2,),
              const SizedBox(height: 5),
              MarkdownBody(
                data: LocaleKeys.ManualScreen_anki_connection_test_text.tr(),
                onTapLink: handleUrlTap
              ),
          
              const SizedBox(height: 30),
              // test anki setup button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    bool success = await GetIt.I<Anki>().testAnkiSetup(context);
          
                    if(success){
                      GetIt.I<UserData>().ankiSetup = true;
                      await GetIt.I<UserData>().save();
                    }
                  },
                  child: Text(
                    LocaleKeys.ManualScreen_anki_test_connection.tr(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
