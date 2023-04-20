
import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/helper/anki/anki.dart';


/// The manual for the TextScreen
class ManualAnki extends StatelessWidget {
  ManualAnki({super.key});

  final String manualAnkiText = 
    LocaleKeys.ManualScreen_anki_text.tr();


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            MarkdownBody(
              data: manualAnkiText,
              onTapLink: (text, href, title) {
                if(href != null)
                  launchUrlString(href);
              },
            ),
            SizedBox(height: 20),
            // test connection button
            OutlinedButton(
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
            )
          ],
        ),
      ),
    );
  }
}