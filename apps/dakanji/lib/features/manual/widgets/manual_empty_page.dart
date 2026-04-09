// Flutter imports:
// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';
// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

/// A empty manual page for reference
class ManualEmptyPage extends StatelessWidget {
  
  const ManualEmptyPage({super.key});

  final String manualTextScreenText = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MarkdownBody(
        data: LocaleKeys.ManualScreen_title.tr(),
      ),
    );
  }
}
