// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/da_kanji_icons_icons.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_slider_tile.dart';
import 'package:provider/provider.dart';

class KanaTableSettings extends StatefulWidget {

  const KanaTableSettings({super.key});

  @override
  State<KanaTableSettings> createState() => _KanaTableSettingsState();
}

class _KanaTableSettingsState extends State<KanaTableSettings> {
  @override
  Widget build(BuildContext context) {

    Settings settings = context.watch<Settings>();
    
    return ResponsiveHeaderTile(
      LocaleKeys.KanaTableScreen_title.tr(),
      DaKanjiCustomIcons.kana_table,
      children: [
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_kana_table_play_audio.tr(),
          value: settings.kanaTable.playAudio,
          onTileTapped: (value) async {
            setState(() {
              settings.kanaTable.playAudio = value;
              settings.save();
            });
          },
        ),
        // play animation when opening kana popup
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_kana_table_play_kana_animation_when_opened.tr(),
          value: settings.kanaTable.playKanaAnimationWhenOpened,
          onTileTapped: (value) {
            setState(() {
              settings.kanaTable.playKanaAnimationWhenOpened = value;
              settings.save();
            });
          },
        ),

        // animation speed
        ResponsiveSliderTile(
          text: LocaleKeys.SettingsScreen_dict_kanji_animation_strokes_per_second.tr(),
          value: settings.kanaTable.kanaAnimationStrokesPerSecond,
          min: 0.1,
          max: 10.0,
          onChanged: (value) {
            setState(() {
              settings.kanaTable.kanaAnimationStrokesPerSecond = value;
              settings.save();
            });
          },
        ),

        // animation continues playing after double tap
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_dict_resume_animation_after_stop_swipe.tr(),
          value: settings.kanaTable.resumeAnimationAfterStopSwipe,
          onTileTapped: (value) {
            setState(() {
              settings.kanaTable.resumeAnimationAfterStopSwipe = value;
              settings.save();
            });
          },
        ),
        // reshow tutorial
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
          icon: Icons.replay_outlined,
          onButtonPressed: () {
            GetIt.I<UserData>().showTutorialKanaTable = true;
            settings.save();
            Phoenix.rebirth(context);
          },
        ),
      ],
    );
  }
}
