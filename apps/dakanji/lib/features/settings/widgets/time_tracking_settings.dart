// Flutter imports:
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_drop_down_tile.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_input_field_tile.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/core/icons/da_kanji_icons.dart';
import 'package:da_kanji_mobile/features/settings/model/settings.dart';
import 'package:da_kanji_mobile/core/user/user_data.dart';
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

    int currentStudyToBreakRatio = 0;

    return ResponsiveHeaderTile(
      LocaleKeys.OcrScreen_title.tr(),
      DaKanjiIcons.timeTracking,
      children: [
        // break / study ratio
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Text("Minutes of break per session"),
              SizedBox(width: 8),
              Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: SpinBox(
                  
                  min: 1,
                  decoration: InputDecoration(
                    suffix: Text("%")
                  ),
                  onChanged: (value) {
                    currentStudyToBreakRatio = value.toInt();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
        // TODO categories
        // tags
        FutureBuilder(
          future: GetIt.I<UserDataDB>().timeTrackingDao.getAllTags(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return SizedBox();

            return ResponsiveDropDownTile(
              text: "Tags",
              value: "default",
              items: snapshot.data! + ["default"]
            );
          },
        ),
        ResponsiveInputFieldTile(
          hintText: "Add tag",
          enabled: true,
          trailingIcon: Icons.add,
          onTrailingIconPressed: (TextEditingController controller) async {
            await GetIt.I<UserDataDB>().timeTrackingDao.addTag(controller.text);
            controller.clear();
            setState(() {});
          },
        ),

        // reshow tutorial
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
          icon: Icons.replay_outlined,
          onButtonPressed: () {
            GetIt.I<UserData>().showTutorialOcr = true;
            settings.save();
            Phoenix.rebirth(context);
          },
        ),
      ],
    );
  }
}
