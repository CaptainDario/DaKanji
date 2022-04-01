import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:provider/provider.dart';



class SettingsTileLanguage extends StatelessWidget {
  const SettingsTileLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, child) {
        return ListTile(
          title: Text(LocaleKeys.General_language.tr()),
          trailing: DropdownButton<String>(
            value: settings.selectedLocale.toString(),
            items: context.supportedLocales
              .map<DropdownMenuItem<String>>((Locale value) {
                return DropdownMenuItem<String>(
                  value: value.toString(),
                  child: () {
                    return Text(value.languageCode);
                  } ()
                );
              }
            ).toList(),
            onChanged: (String? newValue) {
              context.setLocale(Locale(newValue ?? "en"));
              settings.selectedLocale = Locale(newValue ?? "en");
              settings.save();
            },
          ),
          onTap: () {}
        );
      }
    );
  }
}