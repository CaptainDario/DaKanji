// Flutter imports:
import 'package:da_kanji_mobile/widgets/settings/dictionary_search_priority_setting.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';

class ClipboardSettings extends StatefulWidget {

  const ClipboardSettings({super.key});

  @override
  State<ClipboardSettings> createState() => _ClipboardSettingsState();
}

class _ClipboardSettingsState extends State<ClipboardSettings> {
  @override
  Widget build(BuildContext context) {

    Settings settings = context.watch<Settings>();

    return ResponsiveHeaderTile(
      LocaleKeys.ClipboardScreen_title.tr(),
      Icons.paste,
      children: [
        // Search result sort order daggable list
        DictionarySearchPrioritySetting(
          settings.clipboard,
          settings.save
        ),
        // reshow tutorial
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
          icon: Icons.replay_outlined,
          onButtonPressed: () {
            GetIt.I<UserData>().showTutorialClipboard = true;
            settings.save();
            Phoenix.rebirth(context);
          },
        ),
      ],
    );
  }
}
