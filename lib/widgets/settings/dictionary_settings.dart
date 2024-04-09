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

class DictionarySettings extends StatefulWidget {

  /// DaKanji settings object
  final Settings settings;
  
  const DictionarySettings(
      this.settings,
      {
        super.key
      }
    );

  @override
  State<DictionarySettings> createState() => _DictionarySettingsState();
}

class _DictionarySettingsState extends State<DictionarySettings> {
  
  /// Are dict search isolates restarting
  bool restartingDictSearch = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveHeaderTile(
      LocaleKeys.DictionaryScreen_title.tr(),
      Icons.book,
      autoSizeGroup: g_SettingsAutoSizeGroup,
      children: [
        // Language selection
        ResponsiveFilterChips(
          chipWidget: (int index) {
            String lang = widget.settings.dictionary.translationLanguageCodes[index];
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                  height: 10,
                  child: SvgPicture.asset(
                    widget.settings.dictionary.translationLanguagesToSvgPath[lang]!
                  )
                ),
                const SizedBox(width: 8,),
                Text(lang,),
              ],
            );
          },
          selected: (int index) {
            String lang = widget.settings.dictionary.translationLanguageCodes[index];
            return widget.settings.dictionary.selectedTranslationLanguages.contains(lang);
          },
          numChips: widget.settings.dictionary.translationLanguageCodes.length,
          description: LocaleKeys.SettingsScreen_dict_languages.tr(),
          onFilterChipTap: (selected, index) async {

            String lang = widget.settings.dictionary.translationLanguageCodes[index];

            // do not allow removing the last dictionary
            if(widget.settings.dictionary.selectedTranslationLanguages.length == 1 &&
              widget.settings.dictionary.selectedTranslationLanguages.contains(lang)) {
              return;
            }
                                      
            // when disabling english dictionary tell user
            // that significant part of the dict is only in english
            if(lang == iso639_1.en.name &&
              widget.settings.dictionary.selectedTranslationLanguages.contains(lang)) {
              await disableEnglishDictPopup(context).show();
            }
                                      
            // ignore: use_build_context_synchronously
            loadingPopup(context).show();
                                      
            await GetIt.I<DictionarySearch>().kill();
            if(!widget.settings.dictionary.selectedTranslationLanguages.contains(lang)) {
              widget.settings.dictionary.selectedTranslationLanguages = 
                widget.settings.dictionary.translationLanguageCodes.where((element) => 
                  [lang, ...widget.settings.dictionary.selectedTranslationLanguages].contains(element)
                ).toList();
            }
            else {
              widget.settings.dictionary.selectedTranslationLanguages.remove(lang);
            }
            // reset export languages
            widget.settings.anki.includedLanguages =
              List.filled(widget.settings.dictionary.selectedTranslationLanguages.length, true);
            widget.settings.wordLists.includedLanguages =
              List.filled(widget.settings.dictionary.selectedTranslationLanguages.length, true);

            // save and reload
            await widget.settings.save();
            await GetIt.I<DictionarySearch>().init();
                                      
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
                                      
            setState(() {});
          },
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              // update order of list with languages
              String lang = widget.settings.dictionary.translationLanguageCodes.removeAt(oldIndex);
              widget.settings.dictionary.translationLanguageCodes.insert(newIndex, lang);
      
              // update list of selected languages
              widget.settings.dictionary.selectedTranslationLanguages =
                widget.settings.dictionary.translationLanguageCodes.where((e) => 
                  widget.settings.dictionary.selectedTranslationLanguages.contains(e)
                ).toList();

              // reset anki languages
              widget.settings.anki.includedLanguages =
                List.filled(widget.settings.dictionary.selectedTranslationLanguages.length, true);
                
              widget.settings.save();
            });
          }
        ),
        // show word frequency in search results / dictionary
        ShowWordFrequencySetting(
          widget.settings.dictionary.showWordFruequency,
          onTileTapped: (value) {
            setState(() {
              widget.settings.dictionary.showWordFruequency = value;
              widget.settings.save();
            });
          },
        ),
        // try to deconjugate words before searching
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_dict_deconjugate.tr(),
          value: widget.settings.dictionary.searchDeconjugate,
          leadingIcon: Icons.info_outline,
          onTileTapped: (value) {
            setState(() {
              widget.settings.dictionary.searchDeconjugate = value;
              widget.settings.save();
            });
          },
          onLeadingIconPressed: () async {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.noHeader,
              btnOkColor: g_Dakanji_green,
              btnOkOnPress: (){},
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MarkdownBody(
                    data: LocaleKeys.SettingsScreen_dict_deconjugate_body.tr(),
                  ),
                )
              )
            ).show();
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
        // Convert to kana before searching
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_dict_kanaize.tr(),
          value: widget.settings.dictionary.convertToHiragana,
          leadingIcon: Icons.info_outline,
          onTileTapped: (value) async {
            if(restartingDictSearch) return;
            restartingDictSearch = true;

            setState(() {
              widget.settings.dictionary.convertToHiragana = value;
              widget.settings.save();
            });
            GetIt.I<DictionarySearch>().convertToHiragana = value;
            await GetIt.I<DictionarySearch>().kill();
            await GetIt.I<DictionarySearch>().init();

            restartingDictSearch = false;
          },
          onLeadingIconPressed: () async {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.noHeader,
              btnOkColor: g_Dakanji_green,
              btnOkOnPress: (){},
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MarkdownBody(
                    data: LocaleKeys.SettingsScreen_dict_kanaize_body.tr(),
                  ),
                )
              )
            ).show();
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
        // Floating words selection
        ResponsiveFilterChips(
          chipWidget: (index) {
            String level = SettingsDictionary.d_fallingWordsLevels[index];
            return Text(level);
          },
          selected: (int index) {
            String level = SettingsDictionary.d_fallingWordsLevels[index];
            return widget.settings.dictionary.selectedFallingWordsLevels.contains(level);
          },
          numChips: SettingsDictionary.d_fallingWordsLevels.length,
          description: LocaleKeys.SettingsScreen_dict_matrix_word_levels.tr(),
          onFilterChipTap: (selected, index) async {
            String level = SettingsDictionary.d_fallingWordsLevels[index];
            if(widget.settings.dictionary.selectedFallingWordsLevels.contains(level)) {
              widget.settings.dictionary.selectedFallingWordsLevels.remove(level);
            } else {
              widget.settings.dictionary.selectedFallingWordsLevels.add(level);
            }
            await widget.settings.save();
            setState(() {});
          },
        ),

        // play animation when opening kanji tab
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_dict_play_kanji_animation_when_opened.tr(),
          value: widget.settings.dictionary.playKanjiAnimationWhenOpened,
          onTileTapped: (value) {
            setState(() {
              widget.settings.dictionary.playKanjiAnimationWhenOpened = value;
              widget.settings.save();
            });
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),

        // animation speed
        ResponsiveSliderTile(
          text: LocaleKeys.SettingsScreen_dict_kanji_animation_strokes_per_second.tr(),
          value: widget.settings.dictionary.kanjiAnimationStrokesPerSecond,
          min: 0.1,
          max: 10.0,
          autoSizeGroup: g_SettingsAutoSizeGroup,
          onChanged: (value) {
            setState(() {
              widget.settings.dictionary.kanjiAnimationStrokesPerSecond = value;
              widget.settings.save();
            });
          },
        ),

        // animation continues playing after double tap
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_dict_resume_animation_after_stop_swipe.tr(),
          value: widget.settings.dictionary.resumeAnimationAfterStopSwipe,
          onTileTapped: (value) {
            setState(() {
              widget.settings.dictionary.resumeAnimationAfterStopSwipe = value;
              widget.settings.save();
            });
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),

        // custom google image search
        ResponsiveInputFieldTile(
          enabled: true,
          leadingIcon: Icons.info_outline,
          text: widget.settings.dictionary.googleImageSearchQuery,
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
              widget.settings.dictionary.googleImageSearchQuery = value;
              widget.settings.save();
            });
          },
        ),

        // reshow tutorial
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
          icon: Icons.replay_outlined,
          onButtonPressed: () {
            GetIt.I<UserData>().showTutorialDictionary = true;
            widget.settings.save();
            Phoenix.rebirth(context);
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
      ],
    );
  }
}
