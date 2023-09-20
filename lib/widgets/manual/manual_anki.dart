
import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/application/anki/anki.dart';


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

  ManualAnki(
    {
      super.key
    }
  );

  /// handle tap on a url
  void handleUrlTap(String text, String? href, String title){
    
    if(href != null){
      launchUrlString(href);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(LocaleKeys.ManualScreen_anki_setup_title.tr(), style: heading_1,),

            const SizedBox(height: 10),

            Text(LocaleKeys.ManualScreen_anki_setup_intro.tr()),

            const SizedBox(height: 15),
            
            Text(LocaleKeys.ManualScreen_anki_setup_android_title.tr(), style: heading_2,),
            const SizedBox(height: 5),
            MarkdownBody(
              data: LocaleKeys.ManualScreen_anki_setup_android_text.tr(),
              onTapLink: handleUrlTap
            ),

            const SizedBox(height: 15),

            Text(LocaleKeys.ManualScreen_anki_setup_desktop_title.tr(), style: heading_2,),
            const SizedBox(height: 5),
            MarkdownBody(
              data: LocaleKeys.ManualScreen_anki_setup_desktop_text.tr(),
              onTapLink: handleUrlTap
            ),

            const SizedBox(height: 15),

            Text(LocaleKeys.ManualScreen_anki_setup_ios_title.tr(), style: heading_2,),
            const SizedBox(height: 5),
            MarkdownBody(
              data: LocaleKeys.ManualScreen_anki_setup_ios_text.tr(),
              onTapLink: handleUrlTap
            ),

            const SizedBox(height: 30),
            // test connection button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if(await checkAnkiAvailable())
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          LocaleKeys.ManualScreen_anki_test_connection_success.tr(),
                        ),
                      ),
                    );
                  else
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          LocaleKeys.ManualScreen_anki_test_connection_fail.tr(),
                        ),
                      ),
                    );
                },
                child: Text(
                  LocaleKeys.ManualScreen_anki_test_connection.tr(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}