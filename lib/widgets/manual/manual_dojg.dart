// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// A empty manual page for reference
class ManualDojgPage extends StatelessWidget {
  
  const ManualDojgPage({super.key});

  final String manualTextScreenText = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MarkdownBody(
        data: LocaleKeys.ManualScreen_dojg_text.tr(),
        onTapLink: (text, href, title) {
          if(href != null){
            launchUrlString(href);
          }
        },
      ),
    );
  }
}