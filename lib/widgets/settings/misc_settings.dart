// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/da_kanji_icons.dart';
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

  const MiscSettings({super.key});

  @override
  State<MiscSettings> createState() => _MiscSettingsState();
}

class _MiscSettingsState extends State<MiscSettings> {

  @override
  Widget build(BuildContext context) {

    Settings settings = context.watch<Settings>();

    return ResponsiveHeaderTile(
      LocaleKeys.SettingsScreen_misc_title.tr(),
      DaKanjiIcons.misc,
      children: [
        // theme
        ResponsiveDropDownTile(
          text: LocaleKeys.SettingsScreen_misc_theme.tr(), 
          value: settings.misc.selectedTheme,
          items: settings.misc.themesLocaleKeys,
          translateItemTexts: true,
          onChanged: (value) {
            settings.misc.selectedTheme = value ?? settings.misc.themesLocaleKeys[0];
            debugPrint(settings.misc.selectedTheme);
            settings.save();
            Phoenix.rebirth(context);
          },
        ),
        // screen to show when app starts
        ResponsiveDropDownTile(
          text: LocaleKeys.SettingsScreen_misc_default_screen.tr(),
          value: settings.misc.startupScreensLocales[settings.misc.selectedStartupScreen].tr(),
          items: settings.misc.startupScreensLocales.map((e) => e.tr()).toList(),
          onChanged: (newValue) {
            if (newValue != null){
              int i = settings.misc.startupScreensLocales.map(
                (e) => e.tr()
              ).toList().indexOf(newValue);
              settings.misc.selectedStartupScreen = i;
              settings.save();
            }
          },
        ),
        // app languages
        ResponsiveDropDownTile(
          text: LocaleKeys.SettingsScreen_misc_language.tr(), 
          value: context.locale.toString(),
          items: context.supportedLocales.map((e) => e.toString()).toList(),
          onChanged: (newValue) {
            if(newValue != null){
              context.setLocale(Locale(newValue));
              settings.misc.selectedLocale = newValue;
              settings.save();
            }
          },
        ),
        // font size
        ResponsiveSliderTile(
          text: LocaleKeys.SettingsScreen_misc_font_size_scale.tr(),
          value: settings.misc.fontSizeScale,
          min: 0.4,
          max: 2.0,
          
          onChanged: (value) {
            setState(() {
              settings.misc.fontSizeScale = value;
              settings.save();
            });
          },
        ),
        // window size
        if(g_desktopPlatform)
          ResponsiveIconButtonTile(
            text: LocaleKeys.SettingsScreen_misc_settings_window_size.tr(),
            icon: Icons.screenshot_monitor,
            onButtonPressed: () async {
              var info = await windowManager.getSize();

              settings.misc.windowHeight = info.height.toInt();
              settings.misc.windowWidth = info.width.toInt();

              settings.save();
            },
          ),
        // always save window size
        if(g_desktopPlatform)
          ResponsiveCheckBoxTile(
            value: settings.misc.alwaysSaveWindowSize,
            text: LocaleKeys.SettingsScreen_misc_settings_always_save_window_size.tr(),
            onTileTapped: (bool value) async {
              settings.misc.alwaysSaveWindowSize = value;
              settings.save();
            },
          ),
        // always save window position
        if(g_desktopPlatform)
          ResponsiveCheckBoxTile(
            value: settings.misc.alwaysSaveWindowPosition,
            text: LocaleKeys.SettingsScreen_misc_settings_always_save_window_position.tr(),
            onTileTapped: (bool value) async {
              settings.misc.alwaysSaveWindowPosition = value;
              settings.save();
            },
          ),
        // window always on top
        if(g_desktopPlatform)
          ResponsiveCheckBoxTile(
            value: settings.misc.alwaysOnTop,
            text: LocaleKeys.SettingsScreen_misc_window_on_top.tr(),
            onTileTapped: (checked) async {
              windowManager.setAlwaysOnTop(checked);
              settings.misc.alwaysOnTop = checked;
              settings.save();
            },
          ),
        // window opacity
        if(g_desktopPlatform)
          ResponsiveSliderTile(
            text: LocaleKeys.SettingsScreen_misc_window_opacity.tr(),
            value: settings.misc.windowOpacity,
            min: 0.2,
            onChanged: (double value) {
              windowManager.setOpacity(value);
              settings.misc.windowOpacity = value;
              settings.save();
            },
          ),
        // url for sharing dakanji
        ResponsiveDropDownTile(
          text: LocaleKeys.SettingsScreen_misc_sharing_pattern.tr(),
          value: settings.misc.sharingScheme,
          items: settings.misc.sharingSchemes,
          onChanged: (value) async {
            if(value == null){
              return;
            }
            settings.misc.sharingScheme = value;
            await settings.save();
          },
        ),
        AdvancedSettings(settings)
      ],
    );
  }
}
