// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';

/// A empty manual page for reference
class ManualDojgPage extends StatelessWidget {

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
  
  const ManualDojgPage({super.key});

  final String manualTextScreenText = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // import dojg
          ExpansionTile(
            title: Text(LocaleKeys.ManualScreen_dojg_import_title.tr(), style: heading_1,),
            children: [
              MarkdownBody(
                data: LocaleKeys.ManualScreen_dojg_import_text.tr(),
                onTapLink: (text, href, title) {
                  if(href != null){
                    launchUrlString(href);
                  }
                },
              ),
              const SizedBox(height: 15),
            ],
          ),

          //
          ExpansionTile(
            title: Text(LocaleKeys.ManualScreen_dojg_entry_title.tr(), style: heading_1,),
            children: [
              const SizedBox(height: 15),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(LocaleKeys.ManualScreen_dojg_image_full_screen_title.tr(), style: heading_2,),
              ),
              const SizedBox(height: 5),
              Text(LocaleKeys.ManualScreen_dojg_image_full_screen_text.tr()),

              const SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );
  }
}
