// Flutter imports:
// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';
// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// A empty manual page for reference
class ManualDeepLinks extends StatelessWidget {
  
  const ManualDeepLinks({super.key});

  final String manualTextScreenText = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MarkdownBody(
        selectable: true,
        data: LocaleKeys.ManualScreen_deep_links_text.tr(),
        onTapLink: (text, href, title) {
          if(href != null) {
            launchUrlString(href);
          }
        },
      ),
    );
  }
}
