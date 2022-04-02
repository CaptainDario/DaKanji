import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';



class SettingsTileCustomURL extends StatelessWidget {
  const SettingsTileCustomURL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, child) {
        return ListTile(
          title: Row(
            children: [
              Container(
                child: Expanded(
                  child: TextField(
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                    enabled:
                      settings.selectedDictionary == settings.dictionaries[3],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: settings.customURL,
                      hintText: LocaleKeys.SettingsScreen_custom_url_hint.tr()), 
                    onChanged: (value) {
                      settings.customURL = value;
                      settings.save();
                    },
                  )
                )
              ),
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.NO_HEADER,
                    headerAnimationLoop: false,
                    body: Column(
                      children: [
                        AutoSizeText(
                          LocaleKeys.SettingsScreen_custom_url_format.tr(),
                          //textScaleFactor: 2,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              AutoSizeText(
                                LocaleKeys.SettingsScreen_custom_url_explanation.tr(
                                  namedArgs: {'kanjiPlaceholder' : 
                                    settings.kanjiPlaceholder}
                                )
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  )..show();
                }
              )
            ]
          ),
          onTap: () {}
        );
      }
    );
  }
}