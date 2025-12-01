// Flutter imports:
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_spinbox_tile.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/management_dialogs.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/core/icons/da_kanji_icons.dart';
import 'package:da_kanji_mobile/features/settings/model/settings.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_icon_button_tile.dart';

class TimeTrackingSettings extends StatefulWidget {
    

  const TimeTrackingSettings({super.key});

  @override
  State<TimeTrackingSettings> createState() => _TimeTrackingSettingsState();
}

class _TimeTrackingSettingsState extends State<TimeTrackingSettings> {

  @override
  Widget build(BuildContext context) {

    Settings settings = context.watch<Settings>();

    return ResponsiveHeaderTile(
      LocaleKeys.TimeTrackingScreen_title.tr(),
      DaKanjiIcons.timeTracking,
      children: [
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_time_tracking_enabled.tr(),
          value: settings.timeTracking.enabled,
          onTileTapped: (bool value) async {
            settings.timeTracking.enabled = value;
            await settings.save();
            setState(() {});
          },
        ),
        // session length
        ResponsiveSpinboxTile(
          text: LocaleKeys.SettingsScreen_time_tracking_session_length_description.tr(),
          min: 1,
          value: settings.timeTracking.sessionLength.toDouble(),
          suffix: LocaleKeys.SettingsScreen_time_tracking_session_length_unit.tr(),
          onChanged: (value) async {
            settings.timeTracking.sessionLength = value.toInt();
            await settings.save();
            setState(() {});
          },
        ),
        // break per session
        ResponsiveSpinboxTile(
          text: LocaleKeys.SettingsScreen_time_tracking_break_length_description.tr(),
          min: 1,
          value: settings.timeTracking.breakLength.toDouble(),
          suffix: LocaleKeys.SettingsScreen_time_tracking_break_length_unit.tr(),
          onChanged: (value) async {
            settings.timeTracking.breakLength = value.toInt();
            await settings.save();
            setState(() {});
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            LocaleKeys.SettingsScreen_time_tracking_current_ratio_text.tr(
              namedArgs: {
                "CURRENT_RATIO": ((settings.timeTracking.breakLength / settings.timeTracking.sessionLength)*60).toStringAsFixed(0)
              }
            ),
            style: TextStyle(
              color: Colors.grey
            ),
          )
        ),
        SizedBox(height: 8),
        // categories
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_time_tracking_categories.tr(),
          icon: Icons.remove_red_eye_outlined,
          onButtonPressed: () async {
            await showCategorySelectionBottomSheet(
              context,
              onCategorySelected: (category) async {
                await GetIt.I<UserDataDB>().timeTrackingDao.setSelectedCategory(category);
              },
            );
          },
        ),
        
        // tags
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_time_tracking_tags.tr(),
          icon: Icons.remove_red_eye_outlined,
          onButtonPressed: () async {
            showTagSelectionBottomSheet(context);
          },
        ),
      ],
    );
  }
}

