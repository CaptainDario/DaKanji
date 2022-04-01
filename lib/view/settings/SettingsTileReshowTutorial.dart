import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:da_kanji_mobile/model/UserData.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



class SettingsTileReshowTutorial extends StatelessWidget {
  const SettingsTileReshowTutorial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, child) {
        return ListTile(
          title: Text(LocaleKeys.SettingsScreen_show_tutorial.tr()),
          trailing: IconButton(
            icon: Icon(Icons.replay_outlined),
            onPressed: () { 
              GetIt.I<UserData>().showShowcaseDrawing = true;
              settings.save();
              Phoenix.rebirth(context);
            }
          )
        );
      }
    );
  }
}