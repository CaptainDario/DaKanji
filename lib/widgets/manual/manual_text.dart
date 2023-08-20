import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:da_kanji_mobile/locales_keys.dart';



/// The manual for the TextScreen
class ManualTextScreen extends StatelessWidget {
  const ManualTextScreen({super.key});

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