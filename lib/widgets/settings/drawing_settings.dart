// Flutter imports:
import 'package:da_kanji_mobile/entities/da_kanji_icons.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';

// Project imports:
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
  
  /// DaKanji settings object
  final Settings settings;
  
  const DrawingSettings(
    this.settings,
    {
      super.key
    }
  );

  @override
  State<DrawingSettings> createState() => _DrawingSettingsState();
}

class _DrawingSettingsState extends State<DrawingSettings> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveHeaderTile(
      LocaleKeys.SettingsScreen_draw_title.tr(),
      DaKanjiIcons.drawing,
      autoSizeGroup: g_SettingsAutoSizeGroup,
      children: [
        // Dictionary Options
        ResponsiveDropDownTile(
          text: LocaleKeys.SettingsScreen_draw_long_press_opens.tr(),
          value: widget.settings.drawing.selectedDictionary,
          items: widget.settings.drawing.dictionaries,
          onChanged: (newValue) {
            widget.settings.drawing.selectedDictionary = newValue
              ?? widget.settings.drawing.dictionaries[0];
            widget.settings.save();
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
        // custom URL input
        if(widget.settings.drawing.selectedDictionary == widget.settings.drawing.webDictionaries[3])
          ResponsiveInputFieldTile(
            text: widget.settings.drawing.customURL,
            enabled: true,
            hintText: LocaleKeys.SettingsScreen_draw_custom_url_hint.tr(),
            leadingIcon: Icons.info_outline,
            onChanged: (value) {
              widget.settings.drawing.customURL = value;
              widget.settings.save();
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
          value: widget.settings.drawing.invertShortLongPress,
          onTileTapped: (bool? newValue){
            widget.settings.drawing.invertShortLongPress = newValue ?? false;
            widget.settings.save();
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
        // double tap empties canvas
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_draw_double_tap_empty_canvas.tr(),
          value: widget.settings.drawing.emptyCanvasAfterDoubleTap,
          onTileTapped: (bool? newValue){
            widget.settings.drawing.emptyCanvasAfterDoubleTap = newValue ?? false;
            widget.settings.save();
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
        if(g_webViewSupported)
          ResponsiveCheckBoxTile(
            text: LocaleKeys.SettingsScreen_draw_browser_for_online_dict.tr(),
            value: widget.settings.drawing.useWebview,
            onTileTapped: (value) {
              widget.settings.drawing.useWebview = value;
              widget.settings.save();
            },
            autoSizeGroup: g_SettingsAutoSizeGroup,
          ),
        
        // reshow tutorial
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
          icon: Icons.replay_outlined,
          onButtonPressed: () {
            GetIt.I<UserData>().showTutorialDrawing = true;
            widget.settings.save();
            Phoenix.rebirth(context);
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
      ],
    );
  }
}
