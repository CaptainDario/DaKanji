// Flutter imports:
import 'package:da_kanji_mobile/features/manual/widgets/manual_section.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';

/// A empty manual page for reference
class ManualMisc extends StatelessWidget {
  
  const ManualMisc({super.key});

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

  @override
  Widget build(BuildContext context) {
        return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Navigation drawer
            ManualSection(
              title: LocaleKeys.ManualScreen_misc_drawer_heading.tr(),
              sectionHeaders: [
                (null, LocaleKeys.ManualScreen_misc_drawer_reorder_heading.tr())
              ],
              sectionTexts: [
                (LocaleKeys.ManualScreen_misc_drawer_reorder_text.tr(), false)
              ]
            )
          ]
        ),
      ),
    );
  }
}
