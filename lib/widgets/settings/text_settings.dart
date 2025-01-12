// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/da_kanji_icons.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';
import 'package:provider/provider.dart';

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
      autoSizeGroup: g_SettingsAutoSizeGroup,
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
        // should the text screen open with the processed text
        // maximized
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_text_open_in_fullscreen.tr(),
          value: settings.text.openInFullscreen,
          onTileTapped: (value) async {
            settings.text.openInFullscreen = value;
            await settings.save();
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
        // try to deconjugate words before searching
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_dict_deconjugate.tr(),
          value: settings.text.searchDeconjugate,
          leadingIcon: Icons.info_outline,
          onTileTapped: (value) {
            setState(() {
              settings.text.searchDeconjugate = value;
              settings.save();
            });
          },
          onLeadingIconPressed: () async {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.noHeader,
              btnOkColor: g_Dakanji_green,
              btnOkOnPress: (){},
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MarkdownBody(
                    data: LocaleKeys.SettingsScreen_dict_deconjugate_body.tr(),
                  ),
                )
              )
            ).show();
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
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
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
      ],
    );
  }
}
