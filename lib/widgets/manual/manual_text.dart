// Flutter imports:
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
            ExpansionTile(
              expandedAlignment: Alignment.centerLeft,
              title: Text(LocaleKeys.ManualScreen_text_selection_title.tr(), style: heading_1,),
              children: [
                // shrink selection
                const SizedBox(height: 15),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.paste, size: 18,),
                    const Text(" / "),
                    const Icon(Icons.sync, size: 18,),
                    const SizedBox(width: 8,),
                    Text(LocaleKeys.ManualScreen_text_paste_button_title.tr(), style: heading_2,),
                  ]
                ),
                const SizedBox(height: 5),
                Text(
                  LocaleKeys.ManualScreen_text_paste_button_text.tr(),
                ),

                const SizedBox(height: 15),

                // shrink selection
                const SizedBox(height: 15),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_back, size: 18,),
                    const SizedBox(width: 8,),
                    Text(LocaleKeys.ManualScreen_text_selection_shrink_title.tr(), style: heading_2,),
                  ]
                ),
                const SizedBox(height: 5),
                Text(
                  LocaleKeys.ManualScreen_text_selection_shrink_text.tr(),
                ),

                const SizedBox(height: 15),

                // extend selection
                const SizedBox(height: 15),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_forward, size: 18,),
                    const SizedBox(width: 8,),
                    Text(LocaleKeys.ManualScreen_text_selection_grow_title.tr(), style: heading_2,),
                  ]
                ),
                const SizedBox(height: 5),
                Text(LocaleKeys.ManualScreen_text_selection_grow_text.tr()),

                const SizedBox(height: 15),

                // select previous
                const SizedBox(height: 15),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_left, size: 18,),
                    const SizedBox(width: 8,),
                    Text(LocaleKeys.ManualScreen_text_selection_left_title.tr(), style: heading_2,),
                  ]
                ),
                const SizedBox(height: 5),
                Text(LocaleKeys.ManualScreen_text_selection_left_text.tr()),

                const SizedBox(height: 15),

                // select next
                const SizedBox(height: 15),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_right, size: 18,),
                    const SizedBox(width: 8,),
                    Text(LocaleKeys.ManualScreen_text_selection_right_title.tr(), style: heading_2,),
                  ]
                ),
                const SizedBox(height: 5),
                Text(LocaleKeys.ManualScreen_text_selection_right_text.tr()),

                const SizedBox(height: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
