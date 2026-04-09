// Dart imports:
// Project imports:
import 'package:da_kanji_mobile/core/app/restart.dart';
import 'package:da_kanji_mobile/core/user/user_data.dart';
// Flutter imports:
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/features/settings/model/settings.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_icon_button_tile.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
        // TODO v4: reenable optimize backends
        //ResponsiveIconButtonTile(
        //  text: LocaleKeys.SettingsScreen_advanced_settings_optimize_nn.tr(),
        //  icon: Icons.saved_search_sharp,
        //  onButtonPressed: () {
        //    optimizeBackendsPopup(context).show();
        //  },
        //),

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
            await GetIt.I<UserDataDB>().searchHistoryDao.deleteSearchHistory();
            // ignore: use_build_context_synchronously
            await restartApp(context);
          },
        ),
        // delete word lists
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_advanced_settings_delete_word_lists.tr(),
          icon: Icons.delete_forever,
          onButtonPressed: () async {
            await GetIt.I<UserDataDB>().wordListsDao.deleteAllWordLists();
            // ignore: use_build_context_synchronously
            await restartApp(context);
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
