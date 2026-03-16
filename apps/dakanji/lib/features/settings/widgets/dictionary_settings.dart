// Dart imports:

// Flutter imports:
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles_button.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/core/icons/da_kanji_icons.dart';
import 'package:da_kanji_mobile/features/settings/model/settings.dart';
import 'package:da_kanji_mobile/features/settings/model/settings_dictionary.dart';
import 'package:da_kanji_mobile/core/user/user_data.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_filter_chips.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_icon_button_tile.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_input_field_tile.dart';
import 'package:da_kanji_mobile/features/settings/widgets/responsive_widgets/responsive_slider_tile.dart';
import 'package:da_kanji_mobile/features/settings/widgets/info_popup.dart';

class DictionarySettings extends StatefulWidget {
  
  const DictionarySettings({super.key});

  @override
  State<DictionarySettings> createState() => _DictionarySettingsState();
}

class _DictionarySettingsState extends State<DictionarySettings> {
  
  /// Are dict search isolates restarting
  bool restartingDictSearch = false;

  @override
  Widget build(BuildContext context) {

    Settings settings = context.watch<Settings>();

    return ResponsiveHeaderTile(
      LocaleKeys.DictionaryScreen_title.tr(),
      DaKanjiIcons.dictionary,
      children: [

        // Search profiles
        SearchProfilesButton(),

        // Add to anki from search results
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_dict_add_to_anki_from_search_results.tr(),
          value: settings.dictionary.addToAnkiFromSearchResults,
          onTileTapped: (value) {
            setState(() {
              settings.dictionary.addToAnkiFromSearchResults = value;
              settings.save();
            });
          },
        ),
        // Add to list from search results
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_dict_add_to_list_from_search_results.tr(),
          value: settings.dictionary.addToListFromSearchResults,
          onTileTapped: (value) {
            setState(() {
              settings.dictionary.addToListFromSearchResults = value;
              settings.save();
            });
          },
        ),
        const SizedBox(height: 8),
        // Floating words selection
        ResponsiveFilterChips(
          chipWidget: (index) {
            String level = SettingsDictionary.d_fallingWordsLevels[index];
            return Text(level);
          },
          selected: (int index) {
            String level = SettingsDictionary.d_fallingWordsLevels[index];
            return settings.dictionary.selectedFallingWordsLevels.contains(level);
          },
          numChips: SettingsDictionary.d_fallingWordsLevels.length,
          description: LocaleKeys.SettingsScreen_dict_matrix_word_levels.tr(),
          onFilterChipTap: (selected, index) async {
            String level = SettingsDictionary.d_fallingWordsLevels[index];
            if(settings.dictionary.selectedFallingWordsLevels.contains(level)) {
              settings.dictionary.selectedFallingWordsLevels.remove(level);
            } else {
              settings.dictionary.selectedFallingWordsLevels.add(level);
            }
            await settings.save();
            setState(() {});
          },
        ),
        
        ResponsiveSliderTile(
          text: LocaleKeys.SettingsScreen_dict_matrix_word_speed.tr(),
          min: 0.1,
          max: 2.0,
          value: settings.dictionary.fallingWordsSpeed,
          onChanged: (value) {
            setState(() {
              settings.dictionary.fallingWordsSpeed = value;
              settings.save();
            });
          },
        ),
        // play animation when opening kanji tab
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_dict_play_kanji_animation_when_opened.tr(),
          value: settings.dictionary.playKanjiAnimationWhenOpened,
          onTileTapped: (value) {
            setState(() {
              settings.dictionary.playKanjiAnimationWhenOpened = value;
              settings.save();
            });
          },
        ),
        // animation speed
        ResponsiveSliderTile(
          text: LocaleKeys.SettingsScreen_dict_kanji_animation_strokes_per_second.tr(),
          value: settings.dictionary.kanjiAnimationStrokesPerSecond,
          min: 0.1,
          max: 10.0,
          onChanged: (value) {
            setState(() {
              settings.dictionary.kanjiAnimationStrokesPerSecond = value;
              settings.save();
            });
          },
        ),

        // animation continues playing after double tap
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_dict_resume_animation_after_stop_swipe.tr(),
          value: settings.dictionary.resumeAnimationAfterStopSwipe,
          onTileTapped: (value) {
            setState(() {
              settings.dictionary.resumeAnimationAfterStopSwipe = value;
              settings.save();
            });
          },
        ),

        // custom google image search
        ResponsiveInputFieldTile(
          enabled: true,
          leadingIcon: Icons.info_outline,
          text: settings.dictionary.googleImageSearchQuery,
          hintText: LocaleKeys.SettingsScreen_dict_custom_query_format_title.tr(),
          onLeadingIconPressed: (String value) => infoPopup(
              context,
              LocaleKeys.SettingsScreen_dict_custom_query_format_title.tr(),
              LocaleKeys.SettingsScreen_dict_custom_query_format_body.tr(
                namedArgs: {'kanjiPlaceholder' : SettingsDictionary.d_googleImageSearchQuery}
              )  
            ),
          onChanged: (value) {
            setState(() {
              settings.dictionary.googleImageSearchQuery = value;
              settings.save();
            });
          },
        ),

        // reshow tutorial
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
          icon: Icons.replay_outlined,
          onButtonPressed: () {
            GetIt.I<UserData>().showTutorialDictionary = true;
            settings.save();
            Phoenix.rebirth(context);
          },
        ),
      ],
    );
  }
}
