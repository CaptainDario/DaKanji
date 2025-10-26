// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';

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
          ExpansionTile(
            title: Text(LocaleKeys.ManualScreen_dict_kanji_animation_title.tr(), style: heading_1,),
            children: [
              const SizedBox(height: 5),
              Text(LocaleKeys.ManualScreen_dict_kanji_animation_text.tr()),

              const SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );
  }
}
