// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:window_manager/window_manager.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_drop_down_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_slider_tile.dart';
import 'package:da_kanji_mobile/widgets/settings/advanced_settings.dart';

class MiscSettings extends StatefulWidget {
    
  /// DaKanji settings object
  final Settings settings;

  const MiscSettings(
    this.settings,
    {
      super.key
    }
  );

  @override
  State<MiscSettings> createState() => _MiscSettingsState();
}

class _MiscSettingsState extends State<MiscSettings> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveHeaderTile(
      LocaleKeys.SettingsScreen_misc_title.tr(),
      Icons.settings,
      autoSizeGroup: g_SettingsAutoSizeGroup,
      children: [
        // theme
        ResponsiveDropDownTile(
          text: LocaleKeys.SettingsScreen_misc_theme.tr(), 
          value: widget.settings.misc.selectedTheme,
          items: widget.settings.misc.themesLocaleKeys,
          translateItemTexts: true,
          onChanged: (value) {
            widget.settings.misc.selectedTheme = value ?? widget.settings.misc.themesLocaleKeys[0];
            debugPrint(widget.settings.misc.selectedTheme);
            widget.settings.save();
            Phoenix.rebirth(context);
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
        // screen to show when app starts
        ResponsiveDropDownTile(
          text: LocaleKeys.SettingsScreen_misc_default_screen.tr(),
          value: widget.settings.misc.startupScreensLocales[widget.settings.misc.selectedStartupScreen].tr(),
          items: widget.settings.misc.startupScreensLocales.map((e) => e.tr()).toList(),
          onChanged: (newValue) {
            if (newValue != null){
              int i = widget.settings.misc.startupScreensLocales.map(
                (e) => e.tr()
              ).toList().indexOf(newValue);
              widget.settings.misc.selectedStartupScreen = i;
              widget.settings.save();
            }
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
        // app languages
        ResponsiveDropDownTile(
          text: LocaleKeys.SettingsScreen_misc_language.tr(), 
          value: context.locale.toString(),
          items: context.supportedLocales.map((e) => e.toString()).toList(),
          onChanged: (newValue) {
            if(newValue != null){
              context.setLocale(Locale(newValue));
              widget.settings.misc.selectedLocale = newValue;
              widget.settings.save();
            }
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
        // window size
        if(g_desktopPlatform)
          ResponsiveIconButtonTile(
            text: LocaleKeys.SettingsScreen_misc_settings_window_size.tr(),
            icon: Icons.screenshot_monitor,
            onButtonPressed: () async {
              var info = await windowManager.getSize();

              widget.settings.misc.windowHeight = info.height.toInt();
              widget.settings.misc.windowWidth = info.width.toInt();

              widget.settings.save();
            },
            autoSizeGroup: g_SettingsAutoSizeGroup,
          ),
        // window always on top
        if(g_desktopPlatform)
          ResponsiveCheckBoxTile(
            value: widget.settings.misc.alwaysOnTop,
            text: LocaleKeys.SettingsScreen_misc_window_on_top.tr(),
            onTileTapped: (checked) async {
              windowManager.setAlwaysOnTop(checked);
              widget.settings.misc.alwaysOnTop = checked;
              widget.settings.save();
            },
            autoSizeGroup: g_SettingsAutoSizeGroup,
          ),
        // window opacity
        if(g_desktopPlatform)
          ResponsiveSliderTile(
            text: LocaleKeys.SettingsScreen_misc_window_opacity.tr(),
            value: widget.settings.misc.windowOpacity,
            min: 0.2,
            onChanged: (double value) {
              windowManager.setOpacity(value);
              widget.settings.misc.windowOpacity = value;
              widget.settings.save();
            },
            autoSizeGroup: g_SettingsAutoSizeGroup,
          ),
        // url for sharing dakanji
        ResponsiveDropDownTile(
          text: "Sharing pattern",
          value: widget.settings.misc.sharingScheme,
          items: widget.settings.misc.sharingSchemes,
          onChanged: (value) async {
            if(value == null){
              return;
            }
            widget.settings.misc.sharingScheme = value;
            await widget.settings.save();
          },
        ),
        AdvancedSettings(widget.settings)
      ],
    );
  }
}
