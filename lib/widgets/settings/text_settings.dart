// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/da_kanji_icons.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';
import 'package:da_kanji_mobile/widgets/settings/dictionary_search_priority_setting.dart';

class TextSettings extends StatefulWidget {
    
  const TextSettings({super.key});

  @override
  State<TextSettings> createState() => _TextSettingsState();
}

class _TextSettingsState extends State<TextSettings> {

  @override
  Widget build(BuildContext context) {
  
    Settings settings = context.watch<Settings>();
  
    return ResponsiveHeaderTile(
      LocaleKeys.TextScreen_title.tr(),
      DaKanjiIcons.text,
      children: [
        // disable text selection buttons
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_text_show_selection_buttons.tr(),
          value: settings.text.selectionButtonsEnabled,
          onTileTapped: (value) async {
            settings.text.selectionButtonsEnabled = value;
            await settings.save();
          },
        ),
        // Search result sort order daggable list
        DictionarySearchPrioritySetting(
          settings.text,
          settings.save
        ),
        // save text across sessions
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_text_save_text.tr(),
          value: settings.text.saveTextAcrossSessions,
          onTileTapped: (value) async {
            settings.text.saveTextAcrossSessions = value;
            await settings.save();
          },
        ),
        // reshow tutorial
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
          icon: Icons.replay_outlined,
          onButtonPressed: () {
            GetIt.I<UserData>().showTutorialText = true;
            settings.save();
            Phoenix.rebirth(context);
          },
        ),
      ],
    );
  }
}
