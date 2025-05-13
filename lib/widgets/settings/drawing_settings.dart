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
import 'package:da_kanji_mobile/entities/settings/settings_drawing.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_drop_down_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_input_field_tile.dart';
import 'package:da_kanji_mobile/widgets/settings/info_popup.dart';

class DrawingSettings extends StatefulWidget {
  
  const DrawingSettings({super.key});

  @override
  State<DrawingSettings> createState() => _DrawingSettingsState();
}

class _DrawingSettingsState extends State<DrawingSettings> {
  @override
  Widget build(BuildContext context) {

    Settings settings = context.watch<Settings>();

    return ResponsiveHeaderTile(
      LocaleKeys.SettingsScreen_draw_title.tr(),
      DaKanjiIcons.drawing,
      children: [
        // Dictionary Options
        ResponsiveDropDownTile(
          text: LocaleKeys.SettingsScreen_draw_long_press_opens.tr(),
          value: settings.drawing.selectedDictionary,
          items: settings.drawing.dictionaries,
          onChanged: (newValue) {
            settings.drawing.selectedDictionary = newValue
              ?? settings.drawing.dictionaries[0];
            settings.save();
          },
        ),
        // custom URL input
        if(settings.drawing.selectedDictionary == settings.drawing.webDictionaries[3])
          ResponsiveInputFieldTile(
            text: settings.drawing.customURL,
            enabled: true,
            hintText: LocaleKeys.SettingsScreen_draw_custom_url_hint.tr(),
            leadingIcon: Icons.info_outline,
            onChanged: (value) {
              settings.drawing.customURL = value;
              settings.save();
            },
            onLeadingIconPressed: () => infoPopup(
              context,
              LocaleKeys.SettingsScreen_draw_custom_url_format.tr(),
              LocaleKeys.SettingsScreen_custom_url_explanation.tr(
                namedArgs: {'kanjiPlaceholder' : SettingsDrawing.kanjiPlaceholder}
              )  
            ),
          ),
        // invert long/short press
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_draw_invert_short_long_press.tr(),
          value: settings.drawing.invertShortLongPress,
          onTileTapped: (bool? newValue){
            settings.drawing.invertShortLongPress = newValue ?? false;
            settings.save();
          },
        ),
        // double tap empties canvas
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_draw_double_tap_empty_canvas.tr(),
          value: settings.drawing.emptyCanvasAfterDoubleTap,
          onTileTapped: (bool? newValue){
            settings.drawing.emptyCanvasAfterDoubleTap = newValue ?? false;
            settings.save();
          },
        ),
        if(g_webViewSupported)
          ResponsiveCheckBoxTile(
            text: LocaleKeys.SettingsScreen_draw_browser_for_online_dict.tr(),
            value: settings.drawing.useWebview,
            onTileTapped: (value) {
              settings.drawing.useWebview = value;
              settings.save();
            },
          ),
        
        // reshow tutorial
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
          icon: Icons.replay_outlined,
          onButtonPressed: () {
            GetIt.I<UserData>().showTutorialDrawing = true;
            settings.save();
            Phoenix.rebirth(context);
          },
        ),
      ],
    );
  }
}
