import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:provider/provider.dart';
import 'SettingsAutoSizeText.dart';



class SettingsTileDictionaryOptions extends StatelessWidget {
  const SettingsTileDictionaryOptions({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    
    return Consumer<Settings>(
      builder: (context, settings, child) {
        return ListTile(
          title: SettingsAutoSizeText(
            text: LocaleKeys.SettingsScreen_long_press_opens.tr(),
            maxLines: 2,
          ),
          trailing: DropdownButton<String>(
              value: settings.selectedDictionary,
              items: settings.dictionaries 
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: () {
                    String text = value.replaceAll("url", LocaleKeys.General_custom_url.tr());
                    text = text.replaceAll("app", LocaleKeys.General_app.tr());
                    text = text.replaceAll("web", LocaleKeys.General_web.tr());
                    
                    return Container(
                      width: MediaQuery.of(context).size.width*0.35,
                      child: SettingsAutoSizeText(
                        text: text, 
                        maxLines: 1,
                      ),
                    );
                  } ()
                );
              }).toList(),
              onChanged: (String? newValue) {
                settings.selectedDictionary = newValue ?? settings.dictionaries[0];
                settings.save();
              },
            ),
          onTap: (){},
        );
      }
    );
  }
}
