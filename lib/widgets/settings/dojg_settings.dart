// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/da_kanji_icons_icons.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';



class DoJGSettings extends StatefulWidget {
    
  /// DaKanji settings object
  final Settings settings;

  const DoJGSettings(
    this.settings,
    {
      super.key
    }
  );

  @override
  State<DoJGSettings> createState() => _DoJGSettingsState();
}

class _DoJGSettingsState extends State<DoJGSettings> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveHeaderTile(
      LocaleKeys.DojgScreen_title.tr(),
      DaKanjiIcons.dojg,
      autoSizeGroup: g_SettingsAutoSizeGroup,
      children: [
        // has dojg w/o media been imported
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_dojg_imported.tr(),
          value: GetIt.I<UserData>().dojgImported
        ),
        // has dojg w/o media been imported
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_dojg_media_imported.tr(),
          value: GetIt.I<UserData>().dojgWithMediaImported
        ),
        // reshow tutorial
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
          icon: Icons.replay_outlined,
          onButtonPressed: () {
            GetIt.I<UserData>().showTutorialDojg = true;
            widget.settings.save();
            Phoenix.rebirth(context);
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
      ],
    );
  }
}