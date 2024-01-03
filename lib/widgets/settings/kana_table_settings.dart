// Flutter imports:
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_slider_tile.dart';
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
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';



class KanaTableSettings extends StatefulWidget {
    
  /// DaKanji settings object
  final Settings settings;

  const KanaTableSettings(
    this.settings,
    {
      super.key
    }
  );

  @override
  State<KanaTableSettings> createState() => _KanaTableSettingsState();
}

class _KanaTableSettingsState extends State<KanaTableSettings> {
  @override
  Widget build(BuildContext context) {
    
    return ResponsiveHeaderTile(
      LocaleKeys.KanaTableScreen_title.tr(),
      DaKanjiIcons.kana_table,
      autoSizeGroup: g_SettingsAutoSizeGroup,
      children: [
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_kana_table_play_audio.tr(),
          value: widget.settings.kanaTable.playAudio,
          autoSizeGroup: g_SettingsAutoSizeGroup,
          onTileTapped: (value) async {
            setState(() {
              widget.settings.kanaTable.playAudio = value;
              widget.settings.save();
            });
          },
        ),
        // play animation when opening kana popup
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_kana_table_play_kana_animation_when_opened.tr(),
          value: widget.settings.kanaTable.playKanaAnimationWhenOpened,
          onTileTapped: (value) {
            setState(() {
              widget.settings.kanaTable.playKanaAnimationWhenOpened = value;
              widget.settings.save();
            });
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),

        // animation speed
        ResponsiveSliderTile(
          text: LocaleKeys.SettingsScreen_dict_kanji_animation_strokes_per_second.tr(),
          value: widget.settings.kanaTable.kanaAnimationStrokesPerSecond,
          min: 0.1,
          max: 10.0,
          autoSizeGroup: g_SettingsAutoSizeGroup,
          onChanged: (value) {
            setState(() {
              widget.settings.kanaTable.kanaAnimationStrokesPerSecond = value;
              widget.settings.save();
            });
          },
        ),

        // animation continues playing after double tap
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_dict_resume_animation_after_stop_swipe.tr(),
          value: widget.settings.kanaTable.resumeAnimationAfterStopSwipe,
          onTileTapped: (value) {
            setState(() {
              widget.settings.kanaTable.resumeAnimationAfterStopSwipe = value;
              widget.settings.save();
            });
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
        // reshow tutorial
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
          icon: Icons.replay_outlined,
          onButtonPressed: () {
            GetIt.I<UserData>().showTutorialKanaTable = true;
            widget.settings.save();
            Phoenix.rebirth(context);
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
      ],
    );
  }
}