// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';

class ClipboardSettings extends StatefulWidget {
    
  /// DaKanji settings object
  final Settings settings;

  const ClipboardSettings(
    this.settings,
    {
      super.key
    }
  );

  @override
  State<ClipboardSettings> createState() => _ClipboardSettingsState();
}

class _ClipboardSettingsState extends State<ClipboardSettings> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveHeaderTile(
      LocaleKeys.ClipboardScreen_title.tr(),
      Icons.paste,
      autoSizeGroup: g_SettingsAutoSizeGroup,
      children: [
        // try to deconjugate words before searching
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_dict_deconjugate.tr(),
          value: widget.settings.clipboard.searchDeconjugate,
          leadingIcon: Icons.info_outline,
          onTileTapped: (value) {
            setState(() {
              widget.settings.clipboard.searchDeconjugate = value;
              widget.settings.save();
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
            GetIt.I<UserData>().showTutorialClipboard = true;
            widget.settings.save();
            Phoenix.rebirth(context);
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
      ],
    );
  }
}
