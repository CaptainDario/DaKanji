import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:provider/provider.dart';



class SettingsTileDictionaryOptions extends StatelessWidget {
  const SettingsTileDictionaryOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, child) {
        return ListTile(
          title: AutoSizeText(
            LocaleKeys.SettingsScreen_long_press_opens.tr(),
            maxLines: 2,
            minFontSize: 1,
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
                    
                    return Text(
                      text, 
                      style: TextStyle(
                        fontSize: 12.sp,
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
