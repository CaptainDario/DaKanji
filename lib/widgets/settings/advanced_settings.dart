// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/application/app/restart.dart';
import 'package:da_kanji_mobile/entities/dictionary/dictionary_search.dart';
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/search_history/search_history_sql.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_slider_tile.dart';
import 'package:da_kanji_mobile/widgets/settings/optimize_backends_popup.dart';

class AdvancedSettings extends StatefulWidget {
    
  /// DaKanji settings object
  final Settings settings;

  const AdvancedSettings(
    this.settings,
    {
      super.key
    }
  );

  @override
  State<AdvancedSettings> createState() => _AdvancedSettingsState();
}

class _AdvancedSettingsState extends State<AdvancedSettings> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveHeaderTile(
      LocaleKeys.SettingsScreen_advanced_settings_title.tr(),
      Icons.warning,
      children: [
        // optimize backends
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_advanced_settings_optimize_nn.tr(),
          icon: Icons.saved_search_sharp,
          onButtonPressed: () {
            optimizeBackendsPopup(context).show();
          },
        ),
        // number of search isolates
        ResponsiveSliderTile(
          text: LocaleKeys.SettingsScreen_advanced_settings_number_search_procs.tr(),
          min: 1,
          max: max(Platform.numberOfProcessors.toDouble(), 2),
          divisions: max(Platform.numberOfProcessors - 1, 1),
          value: widget.settings.advanced.noOfSearchIsolates.toDouble(),
          leadingIcon: Icons.info_outline,
          onLeadingIconPressed: () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.noHeader,
              btnOkColor: g_Dakanji_green,
              btnOkOnPress: (){},
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    LocaleKeys.SettingsScreen_advanced_settings_number_search_procs_body.tr()
                  )
                ),
              )
            ).show();
          },
          onChanged: (double value) {
            setState(() {
              widget.settings.advanced.noOfSearchIsolates = value.toInt();
              widget.settings.save();
            });
          },
          onChangeEnd: (double value) async {
            await GetIt.I<DictionarySearch>().kill();
            GetIt.I<DictionarySearch>().noIsolates = value.toInt();
            await GetIt.I<DictionarySearch>().init();
          },
        ),
        // Reset settings
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_advanced_settings_reset_settings.tr(),
          icon: Icons.delete_forever,
          onButtonPressed: () async {
            Settings settings = Settings();
            await settings.save();
            // ignore: use_build_context_synchronously
            await restartApp(context);
          },
        ),
        // Delete user data
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_advanced_settings_delete_user_data.tr(),
          icon: Icons.delete_forever,
          onButtonPressed: () async {
            UserData uD = UserData()
              ..appOpenedTimes = 2
              ..dailyActiveUserTracked = GetIt.I<UserData>().dailyActiveUserTracked
              ..monthlyActiveUserTracked = GetIt.I<UserData>().monthlyActiveUserTracked;
            await uD.save();
            // ignore: use_build_context_synchronously
            await restartApp(context);
          },
        ),
        // delete search history
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_advanced_settings_delete_history.tr(),
          icon: Icons.delete_forever,
          onButtonPressed: () async {
            await GetIt.I<SearchHistorySQLDatabase>().deleteEverything();
            // ignore: use_build_context_synchronously
            await restartApp(context);
          },
        ),
        // delete search history
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_advanced_settings_delete_word_lists.tr(),
          icon: Icons.delete_forever,
          onButtonPressed: () async {
            await GetIt.I<WordListsSQLDatabase>().deleteEverything();
            // ignore: use_build_context_synchronously
            await restartApp(context);
          },
        ),
        // Delete dict
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_advanced_settings_delete_dict.tr(),
          icon: Icons.delete_forever,
          onButtonPressed: () async {
            await GetIt.I<DictionarySearch>().kill();
            await GetIt.I<Isars>().dictionary.close(deleteFromDisk: true);
            await GetIt.I<Isars>().krad.close(deleteFromDisk: true);
            await GetIt.I<Isars>().radk.close(deleteFromDisk: true);
            // ignore: use_build_context_synchronously
            await restartApp(context);
          },
        ),
        // Delete dojg
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_advanced_settings_delete_dojg.tr(),
          icon: Icons.delete_forever,
          onButtonPressed: () async {

            GetIt.I<UserData>().dojgImported = false;
            GetIt.I<UserData>().dojgWithMediaImported = false;
            GetIt.I<UserData>().save();

            Directory dojgDir = Directory(g_DakanjiPathManager.dojgDirectory.path);
            if(dojgDir.existsSync()){
              if(GetIt.I<Isars>().dojg != null){
                await GetIt.I<Isars>().dojg!.close(deleteFromDisk: true);
              }
              await dojgDir.delete(recursive: true);
              // ignore: use_build_context_synchronously
              await restartApp(context);
            }
          },
        ),
        // thanos dissolve effect for drawing screen
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_advanced_settings_snap.tr(),
          value: widget.settings.advanced.useThanosSnap,
          onTileTapped: (newValue) {
            widget.settings.advanced.useThanosSnap = newValue;
            widget.settings.save();
          },
        ),
        // matrix color setting
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_advanced_settings_matrix.tr(),
          value: widget.settings.advanced.iAmInTheMatrix,
          onTileTapped: (newValue) {
            widget.settings.advanced.iAmInTheMatrix = newValue;
            widget.settings.save();
          },
        ),
      ],
    );
  }
}
