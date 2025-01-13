// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/da_kanji_icons.dart';
import 'package:da_kanji_mobile/entities/dictionary/dictionary_search.dart';
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/settings/settings_dictionary.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_filter_chips.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_input_field_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_slider_tile.dart';
import 'package:da_kanji_mobile/widgets/settings/disable_english_dict_popup.dart';
import 'package:da_kanji_mobile/widgets/settings/info_popup.dart';
import 'package:da_kanji_mobile/widgets/settings/show_word_frequency_setting.dart';
import 'package:da_kanji_mobile/widgets/widgets/loading_popup.dart';
import 'package:provider/provider.dart';

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
      autoSizeGroup: g_SettingsAutoSizeGroup,
      children: [
        // Language selection
        ResponsiveFilterChips(
          chipWidget: (int index) {
            String lang = settings.dictionary.translationLanguageCodes[index];
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                  height: 10,
                  child: SvgPicture.asset(
                    settings.dictionary.translationLanguagesToSvgPath[lang]!
                  )
                ),
                const SizedBox(width: 8,),
                Text(lang,),
              ],
            );
          },
          selected: (int index) {
            String lang = settings.dictionary.translationLanguageCodes[index];
            return settings.dictionary.selectedTranslationLanguages.contains(lang);
          },
          numChips: settings.dictionary.translationLanguageCodes.length,
          description: LocaleKeys.SettingsScreen_dict_languages.tr(),
          onFilterChipTap: (selected, index) async {

            String lang = settings.dictionary.translationLanguageCodes[index];

            // do not allow removing the last dictionary
            if(settings.dictionary.selectedTranslationLanguages.length == 1 &&
              settings.dictionary.selectedTranslationLanguages.contains(lang)) {
              return;
            }
                                      
            // when disabling english dictionary tell user
            // that significant part of the dict is only in english
            if(lang == iso639_1.en.name &&
              settings.dictionary.selectedTranslationLanguages.contains(lang)) {
              await disableEnglishDictPopup(context).show();
            }
                                      
            // ignore: use_build_context_synchronously
            loadingPopup(context).show();
                                      
            await GetIt.I<DictionarySearch>().kill();
            if(!settings.dictionary.selectedTranslationLanguages.contains(lang)) {
              settings.dictionary.selectedTranslationLanguages = 
                settings.dictionary.translationLanguageCodes.where((element) => 
                  [lang, ...settings.dictionary.selectedTranslationLanguages].contains(element)
                ).toList();
            }
            else {
              settings.dictionary.selectedTranslationLanguages.remove(lang);
            }
            // reset export languages
            settings.anki.includedLanguages =
              List.filled(settings.dictionary.selectedTranslationLanguages.length, true);
            settings.wordLists.includedLanguages =
              List.filled(settings.dictionary.selectedTranslationLanguages.length, true);

            // save and reload
            await settings.save();
            await GetIt.I<DictionarySearch>().init();
                                      
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
                                      
            setState(() {});
          },
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              // update order of list with languages
              String lang = settings.dictionary.translationLanguageCodes.removeAt(oldIndex);
              settings.dictionary.translationLanguageCodes.insert(newIndex, lang);
      
              // update list of selected languages
              settings.dictionary.selectedTranslationLanguages =
                settings.dictionary.translationLanguageCodes.where((e) => 
                  settings.dictionary.selectedTranslationLanguages.contains(e)
                ).toList();

              // reset anki languages
              settings.anki.includedLanguages =
                List.filled(settings.dictionary.selectedTranslationLanguages.length, true);
                
              settings.save();
            });
          }
        ),
        // Search result sort order daggable list
        ResponsiveFilterChips(
          description: LocaleKeys.SettingsScreen_dict_separate_search_results.tr(),
          detailedDescription: SizedBox(
            height: MediaQuery.sizeOf(context).height*0.8,
            child: SingleChildScrollView(
              
              child: MarkdownBody(
                data:
"""
# ${LocaleKeys.SettingsScreen_dict_search_sorting_information.tr()}
${LocaleKeys.SettingsScreen_dict_search_sorting_information_description.tr()}

## ${LocaleKeys.SettingsScreen_dict_term.tr()}
${LocaleKeys.SettingsScreen_dict_term_description.tr()}

## ${LocaleKeys.SettingsScreen_dict_convert_to_kana.tr()}
${LocaleKeys.SettingsScreen_dict_convert_to_kana_description.tr()}

## ${LocaleKeys.SettingsScreen_dict_base_form.tr()}
${LocaleKeys.SettingsScreen_dict_base_form_description.tr()}
"""
              ),
            ),
          ),
          chipWidget: (int index) {

            bool isSelected = settings.dictionary.selectedSearchResultSortPriorities
              .contains(settings.dictionary.searchResultSortPriorities[index]);

            int iWithoutUnselected = settings.dictionary.searchResultSortPriorities
              .sublist(0, index+1)
              .where((e) => settings.dictionary.selectedSearchResultSortPriorities
                .contains(e)
              ).length;

            return Text(
              (isSelected ? "$iWithoutUnselected. " : "") + 
              settings.dictionary.searchResultSortPriorities[index].tr()
            );
          },
          selected: (index) {
            return settings.dictionary.selectedSearchResultSortPriorities
              .contains(settings.dictionary.searchResultSortPriorities[index]);
          },
          numChips: settings.dictionary.searchResultSortPriorities.length,
          onReorder: (oldIndex, newIndex) {
            // update order of list with languages
            String priority = settings.dictionary.searchResultSortPriorities.removeAt(oldIndex);
            settings.dictionary.searchResultSortPriorities.insert(newIndex, priority);
    
            // update list of selected languages
            settings.dictionary.selectedSearchResultSortPriorities =
              settings.dictionary.searchResultSortPriorities.where((e) => 
                settings.dictionary.selectedSearchResultSortPriorities.contains(e)
              ).toList();
              
            settings.save();
          },
          onFilterChipTap: (selected, index) async {
            String priority = settings.dictionary.searchResultSortPriorities[index];

            // do not allow removing the last priority
            if(settings.dictionary.selectedSearchResultSortPriorities.length == 1 &&
              settings.dictionary.selectedSearchResultSortPriorities.contains(priority)) {
              return;
            }

            if(!settings.dictionary.selectedSearchResultSortPriorities.contains(priority)) {
              settings.dictionary.selectedSearchResultSortPriorities = 
                settings.dictionary.searchResultSortPriorities.where((element) => 
                  [priority, ...settings.dictionary.selectedSearchResultSortPriorities].contains(element)
                ).toList();
            }
            else {
              settings.dictionary.selectedSearchResultSortPriorities.remove(priority);
            }

            await settings.save();
            setState(() {});
            
          },
        ),
        // Separate search results by matching term
        ResponsiveCheckBoxTile(
          text: "Separate search results by matching term",
          value: settings.dictionary.showSearchMatchSeparation,
          onTileTapped: (value) {
            setState(() {
              settings.dictionary.showSearchMatchSeparation = value;
              settings.save();
            });
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
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
          autoSizeGroup: g_SettingsAutoSizeGroup,
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
          autoSizeGroup: g_SettingsAutoSizeGroup,
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
        // show word frequency in search results / dictionary
        ShowWordFrequencySetting(
          settings.dictionary.showWordFruequency,
          onTileTapped: (value) {
            setState(() {
              settings.dictionary.showWordFruequency = value;
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
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),

        // animation speed
        ResponsiveSliderTile(
          text: LocaleKeys.SettingsScreen_dict_kanji_animation_strokes_per_second.tr(),
          value: settings.dictionary.kanjiAnimationStrokesPerSecond,
          min: 0.1,
          max: 10.0,
          autoSizeGroup: g_SettingsAutoSizeGroup,
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
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),

        // custom google image search
        ResponsiveInputFieldTile(
          enabled: true,
          leadingIcon: Icons.info_outline,
          text: settings.dictionary.googleImageSearchQuery,
          hintText: LocaleKeys.SettingsScreen_dict_custom_query_format_title.tr(),
          onLeadingIconPressed: () => infoPopup(
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
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
      ],
    );
  }
}
