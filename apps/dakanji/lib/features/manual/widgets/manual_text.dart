// Flutter imports:
import 'package:da_kanji_mobile/features/manual/widgets/manual_section.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';

/// The manual for the TextScreen
class ManualTextScreen extends StatelessWidget {
  const ManualTextScreen({super.key});

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

            ManualSection(
              title: LocaleKeys.ManualScreen_text_selection_title.tr(),
              sectionHeaders: [
                (
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.paste, size: 18),
                      Text(" / "),
                      Icon(Icons.sync, size: 18),
                    ],
                  ),
                  LocaleKeys.ManualScreen_text_paste_button_title.tr(),
                ),
                (
                  const Icon(Icons.arrow_back, size: 18),
                  LocaleKeys.ManualScreen_text_selection_shrink_title.tr(),
                ),
                (
                  const Icon(Icons.arrow_forward, size: 18),
                  LocaleKeys.ManualScreen_text_selection_grow_title.tr(),
                ),
                (
                  const Icon(Icons.arrow_left, size: 18),
                  LocaleKeys.ManualScreen_text_selection_left_title.tr(),
                ),
                (
                  const Icon(Icons.arrow_right, size: 18),
                  LocaleKeys.ManualScreen_text_selection_right_title.tr(),
                ),
              ],
              sectionTexts: [
                (LocaleKeys.ManualScreen_text_paste_button_text.tr(), false),
                (LocaleKeys.ManualScreen_text_selection_shrink_text.tr(), false),
                (LocaleKeys.ManualScreen_text_selection_grow_text.tr(), false),
                (LocaleKeys.ManualScreen_text_selection_left_text.tr(), false),
                (LocaleKeys.ManualScreen_text_selection_right_text.tr(), false),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
