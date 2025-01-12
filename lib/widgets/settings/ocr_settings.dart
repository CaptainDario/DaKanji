// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/da_kanji_icons.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';
import 'package:provider/provider.dart';

class OcrSettings extends StatefulWidget {
    

  const OcrSettings({super.key});

  @override
  State<OcrSettings> createState() => _OcrSettingsState();
}

class _OcrSettingsState extends State<OcrSettings> {

  @override
  Widget build(BuildContext context) {

    Settings settings = context.watch<Settings>();

    return ResponsiveHeaderTile(
      LocaleKeys.OcrScreen_title.tr(),
      DaKanjiIcons.ocr,
      autoSizeGroup: g_SettingsAutoSizeGroup,
      children: [
        // reshow tutorial
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
          icon: Icons.replay_outlined,
          onButtonPressed: () {
            GetIt.I<UserData>().showTutorialOcr = true;
            settings.save();
            Phoenix.rebirth(context);
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
      ],
    );
  }
}
