// Flutter imports:
import 'package:da_kanji_mobile/features/manual/widgets/manual_section.dart';
// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';
// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// A empty manual page for reference
class ManualKanaTablePage extends StatelessWidget {

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
  
  const ManualKanaTablePage({super.key});

  final String manualTextScreenText = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kana animation controls
          ManualSection(
            title: LocaleKeys.ManualScreen_dict_kanji_animation_title.tr(),
            sectionHeaders: [
              (null, null) 
            ],
            sectionTexts: [
              (LocaleKeys.ManualScreen_dict_kanji_animation_text.tr(), false)
            ]
          ),
        ],
      ),
    );
  }
}
