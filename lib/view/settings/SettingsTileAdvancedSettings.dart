import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:provider/provider.dart';



class SettingsTileAdvancedSettings extends StatelessWidget {
  const SettingsTileAdvancedSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, child) {
        return ExpansionTile(
          title: Text(LocaleKeys.SettingsScreen_advanced_settings_title.tr()),
          children: [
            ListTile(
              title: Text(LocaleKeys.SettingsScreen_advanced_settings_drawing_inference_backend.tr()),
              trailing: DropdownButton<String>(
                  value: settings.backendCNNSingleChar,
                  items: settings.inferenceBackends 
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: () { 
                        return Text(value); 
                      } ()
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    print(newValue);
                    settings.backendCNNSingleChar = newValue ?? settings.inferenceBackends[0];
                    settings.save();
                    print(newValue);
                  },
                ),
              onTap: (){},
            ),
          ],
        );
      }
    );
  }
}