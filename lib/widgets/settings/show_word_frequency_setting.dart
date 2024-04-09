// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';

/// Setting to set weather to show the word frequency or not
class ShowWordFrequencySetting extends StatefulWidget {


  /// Current state of the toggle
  final bool showWordFrequency;
  /// Callback that is triggered when this tile is tapped, provides the next
  /// toggle state as parameter
  final Function(bool value) onTileTapped;


  const ShowWordFrequencySetting(
    this.showWordFrequency,
    {
      required this.onTileTapped,
      super.key
    }
  );

  @override
  State<ShowWordFrequencySetting> createState() => _ShowWordFrequencySettingState();
}

class _ShowWordFrequencySettingState extends State<ShowWordFrequencySetting> {
  @override
  Widget build(BuildContext context) {

    return ResponsiveCheckBoxTile(
      text: LocaleKeys.SettingsScreen_dict_show_word_freq.tr(),
      value: widget.showWordFrequency,
      leadingIcon: Icons.info_outline,
      onTileTapped: (value) {
        widget.onTileTapped.call(value);
        setState(() {});
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
                data: LocaleKeys.SettingsScreen_dict_show_word_freq_body.tr(),
                onTapLink: (text, href, title) {
                  if(href != null) {
                    launchUrlString(href);
                  }
                },
              ),
            )
          )
        ).show();
      },
      autoSizeGroup: g_SettingsAutoSizeGroup,
    );
  }
}
