import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



class SettingsTileTheme extends StatelessWidget {
  const SettingsTileTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, child) {
        return ListTile(
          title: Text(LocaleKeys.SettingsScreen_theme.tr()),
          trailing: DropdownButton<String>(
            value: settings.selectedTheme,
            items: settings.themes
              .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: () {
                  String text = value.replaceAll("light", LocaleKeys.General_light.tr());
                  text = text.replaceAll("dark", LocaleKeys.General_dark.tr());
                  text = text.replaceAll("system", LocaleKeys.General_system.tr());
                  
                  return Text(text);
                } ()
                );
              }
            ).toList(),
            onChanged: (String? newValue) {
              settings.selectedTheme = newValue ?? settings.themes[0];
              settings.save();
              Phoenix.rebirth(context);
            },
          ),
          onTap: () {}
        );
      }
    );
  }
}