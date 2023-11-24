// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:universal_io/io.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:window_manager/window_manager.dart';

// Project imports:
import 'package:da_kanji_mobile/application/app/restart.dart';
import 'package:da_kanji_mobile/entities/da_kanji_icons_icons.dart';
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/domain/dictionary/dictionary_search.dart';
import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/domain/settings/settings_dictionary.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_drop_down_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_input_field_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_slider_tile.dart';
import 'package:da_kanji_mobile/widgets/settings/custom_url_popup.dart';
import 'package:da_kanji_mobile/widgets/settings/disable_english_dict_popup.dart';
import 'package:da_kanji_mobile/widgets/settings/optimize_backends_popup.dart';
import 'package:da_kanji_mobile/widgets/widgets/loading_popup.dart';

/// The "settings"-screen.
/// 
/// Here all settings of the app can be managed.
class SettingsScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;

  const SettingsScreen(
    this.openedByDrawer,
    {
      super.key
    }
  );

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}


class _SettingsScreenState extends State<SettingsScreen> {

  /// The scroll controller for the list of settings
  late ScrollController scrollController;
  /// Are dict search isolates restarting
  bool restartingDictSearch = false;


  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      body: DaKanjiDrawer(
        currentScreen: Screens.settings,
        drawerClosed: !widget.openedByDrawer,
        // ListView of all available settings
        child: ChangeNotifierProvider.value(
          value: GetIt.I<Settings>(),
          child: Consumer<Settings>(
            builder: (context, settings, child) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      
                      // #region - Drawing

                      // Drawing header
                      ResponsiveHeaderTile(
                        LocaleKeys.SettingsScreen_draw_title.tr(),
                        Icons.brush,
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      // Dictionary Options
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_draw_long_press_opens.tr(),
                        value: settings.drawing.selectedDictionary,
                        items: settings.drawing.dictionaries,
                        onChanged: (newValue) {
                          settings.drawing.selectedDictionary = newValue
                            ?? settings.drawing.dictionaries[0];
                          settings.save();
                        },
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),
                      // custom URL input
                      if(settings.drawing.selectedDictionary == settings.drawing.webDictionaries[3])
                        ResponsiveInputFieldTile(
                          text: settings.drawing.customURL,
                          enabled: true,
                          hintText: LocaleKeys.SettingsScreen_draw_custom_url_hint.tr(),
                          leadingIcon: Icons.info_outline,
                          onChanged: (value) {
                            settings.drawing.customURL = value;
                            settings.save();
                          },
                          onLeadingIconPressed: () => showCustomURLPopup(context),
                        ),
                      // invert long/short press
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_draw_invert_short_long_press.tr(),
                        value: settings.drawing.invertShortLongPress,
                        onTileTapped: (bool? newValue){
                          settings.drawing.invertShortLongPress = newValue ?? false;
                          settings.save();
                        },
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),
                      // double tap empties canvas
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_draw_double_tap_empty_canvas.tr(),
                        value: settings.drawing.emptyCanvasAfterDoubleTap,
                        onTileTapped: (bool? newValue){
                          settings.drawing.emptyCanvasAfterDoubleTap = newValue ?? false;
                          settings.save();
                        },
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),
                      if(g_webViewSupported)
                        ResponsiveCheckBoxTile(
                          text: LocaleKeys.SettingsScreen_draw_browser_for_online_dict.tr(),
                          value: settings.drawing.useWebview,
                          onTileTapped: (value) {
                            settings.drawing.useWebview = value;
                            settings.save();
                          },
                          autoSizeGroup: g_SettingsAutoSizeGroup,
                        ),
                      
                      // reshow tutorial
                      ResponsiveIconButtonTile(
                        text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
                        icon: Icons.replay_outlined,
                        onButtonPressed: () {
                          GetIt.I<UserData>().showTutorialDrawing = true;
                          settings.save();
                          Phoenix.rebirth(context);
                        },
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),
                      // #endregion

                      const Divider(),

                      // #region - Dict header

                      ResponsiveHeaderTile(
                        LocaleKeys.DictionaryScreen_title.tr(),
                        Icons.book,
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: Align(
                          alignment: Alignment.centerLeft, 
                          child: AutoSizeText(
                            LocaleKeys.SettingsScreen_dict_languages.tr(),
                            group: g_SettingsAutoSizeGroup,
                          )
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReorderableWrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          needsLongPressDraggable: false,
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          
                          runAlignment: WrapAlignment.start,
                          children: List.generate(
                            settings.dictionary.translationLanguageCodes.length,
                            (index) {
                              String lang = settings.dictionary.translationLanguageCodes[index];
                              return GestureDetector(
                                onTap: () async {
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
                                  await settings.save();
                                  await GetIt.I<DictionarySearch>().init();

                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();

                                  setState(() {});
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.grab,
                                  child: Chip(
                                    backgroundColor: settings.dictionary.selectedTranslationLanguages.contains(lang)
                                      ? Theme.of(context).highlightColor
                                      : null,
                                    label: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                          height: 10,
                                          child: SvgPicture.asset(
                                            settings.dictionary.translationLanguagesToSvgPath[lang]!
                                          )
                                        ),
                                        Text("   $lang"),
                                      ],
                                    )
                                  ),
                                ),
                              );
                            }
                          ),
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
                                
                              settings.save();
                            });
                          }
                        ),
                      ),
                      // show word frequency in search results / dictionary
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_dict_show_word_freq.tr(),
                        value: settings.dictionary.showWordFruequency,
                        leadingIcon: Icons.info_outline,
                        onTileTapped: (value) {
                          setState(() {
                            settings.dictionary.showWordFruequency = value;
                            settings.save();
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
                                  data: LocaleKeys.SettingsScreen_dict_show_word_freq_body.tr(),
                                  onTapLink: (text, href, title) {
                                    if(href != null) {
                                      launchUrlString(href);
                                    }
                                  },
                                ),
                              )
                            )
                          ).show();
                        },
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),
                      // try to deconjugate words before searching
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_dict_deconjugate.tr(),
                        value: settings.dictionary.searchDeconjugate,
                        leadingIcon: Icons.info_outline,
                        onTileTapped: (value) {
                          setState(() {
                            settings.dictionary.searchDeconjugate = value;
                            settings.save();
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
                        value: settings.dictionary.convertToHiragana,
                        leadingIcon: Icons.info_outline,
                        onTileTapped: (value) async {
                          if(restartingDictSearch) return;
                          restartingDictSearch = true;

                          setState(() {
                            settings.dictionary.convertToHiragana = value;
                            settings.save();
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: Align(
                          alignment: Alignment.centerLeft, 
                          child: AutoSizeText(
                            LocaleKeys.SettingsScreen_dict_matrix_word_levels.tr(),
                            group: g_SettingsAutoSizeGroup,
                          )
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.start,
                            
                            runAlignment: WrapAlignment.start,
                            children: List.generate(
                              SettingsDictionary.d_fallingWordsLevels.length,
                              (index) {
                                String level = SettingsDictionary.d_fallingWordsLevels[index];
                                return GestureDetector(
                                  onTap: () async {
                                    if(settings.dictionary.selectedFallingWordsLevels.contains(level)) {
                                      settings.dictionary.selectedFallingWordsLevels.remove(level);
                                    } else {
                                      settings.dictionary.selectedFallingWordsLevels.add(level);
                                    }
                                    await settings.save();
                                    setState(() {});
                                  },
                                  child: Chip(
                                    backgroundColor: settings.dictionary.selectedFallingWordsLevels.contains(level)
                                      ? Theme.of(context).highlightColor
                                      : null,
                                    label: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(level),
                                      ],
                                    )
                                  ),
                                );
                              }
                            ),
                          ),
                        ),
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

                      // #endregion

                      const Divider(),

                      // #region - Text header

                      ResponsiveHeaderTile(
                        LocaleKeys.TextScreen_title.tr(),
                        Icons.text_snippet,
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      // disable text selection buttons
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_text_show_selection_buttons.tr(),
                        value: settings.text.selectionButtonsEnabled,
                        onTileTapped: (value) async {
                          settings.text.selectionButtonsEnabled = value;
                          await settings.save();
                        },
                      ),
                      // should the text screen open with the processed text
                      // maximized
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_text_open_in_fullscreen.tr(),
                        value: settings.text.openInFullscreen,
                        onTileTapped: (value) async {
                          settings.text.openInFullscreen = value;
                          await settings.save();
                        },
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),
                      // try to deconjugate words before searching
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_dict_deconjugate.tr(),
                        value: settings.text.searchDeconjugate,
                        leadingIcon: Icons.info_outline,
                        onTileTapped: (value) {
                          setState(() {
                            settings.text.searchDeconjugate = value;
                            settings.save();
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
                      // reshow tutorial
                      ResponsiveIconButtonTile(
                        text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
                        icon: Icons.replay_outlined,
                        onButtonPressed: () {
                          GetIt.I<UserData>().showTutorialText = true;
                          settings.save();
                          Phoenix.rebirth(context);
                        },
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),

                      // #endregion

                      const Divider(),

                      // #region - DoJG header

                      ResponsiveHeaderTile(
                        LocaleKeys.DojgScreen_title.tr(),
                        DaKanjiIcons.dojg,
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      // has dojg w/o media been imported
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_dojg_imported.tr(),
                        value: GetIt.I<UserData>().dojgImported
                      ),
                      // has dojg w/o media been imported
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_dojg_media_imported.tr(),
                        value: GetIt.I<UserData>().dojgWithMediaImported
                      ),
                      // reshow tutorial
                      ResponsiveIconButtonTile(
                        text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
                        icon: Icons.replay_outlined,
                        onButtonPressed: () {
                          GetIt.I<UserData>().showTutorialDojg = true;
                          settings.save();
                          Phoenix.rebirth(context);
                        },
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),

                      // #endregion

                      const Divider(),

                      // #region - Kanji table header

                      ResponsiveHeaderTile(
                        LocaleKeys.KanjiTableScreen_title.tr(),
                        DaKanjiIcons.kanji_table,
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      // reshow tutorial
                      ResponsiveIconButtonTile(
                        text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
                        icon: Icons.replay_outlined,
                        onButtonPressed: () {
                          GetIt.I<UserData>().showTutorialKanjiTable = true;
                          settings.save();
                          Phoenix.rebirth(context);
                        },
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),

                      // #endregion

                      const Divider(),

                      // #region - Kana table header
                      ResponsiveHeaderTile(
                        LocaleKeys.KanaTableScreen_title.tr(),
                        DaKanjiIcons.kana_table,
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_kana_table_play_audio.tr(),
                        value: settings.kanaTable.playAudio,
                        autoSizeGroup: g_SettingsAutoSizeGroup,
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
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),

                      // animation speed
                      ResponsiveSliderTile(
                        text: LocaleKeys.SettingsScreen_dict_kanji_animation_strokes_per_second.tr(),
                        value: settings.kanaTable.kanaAnimationStrokesPerSecond,
                        min: 0.1,
                        max: 10.0,
                        autoSizeGroup: g_SettingsAutoSizeGroup,
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
                        autoSizeGroup: g_SettingsAutoSizeGroup,
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
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),
                      // move down between enreegon and region anki header
                      const Divider(),

                      // #endregion

                      // #region - word lists header TODO: v word lists - enable
                      if(kDebugMode)
                        ...[
                          ResponsiveHeaderTile(
                            LocaleKeys.WordListsScreen_title.tr(),
                            Icons.list,
                            autoSizeGroup: g_SettingsAutoSizeGroup
                          ),
                          // reshow tutorial
                          ResponsiveIconButtonTile(
                            text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
                            icon: Icons.replay_outlined,
                            onButtonPressed: () {
                              GetIt.I<UserData>().showTutorialWordLists = true;
                              settings.save();
                              Phoenix.rebirth(context);
                            },
                            autoSizeGroup: g_SettingsAutoSizeGroup,
                          ),
                          // move down between enreegon and region anki header
                          const Divider(),
                        ],

                      // #endregion        

                      // #region - Anki header : TODO - v word lists - enable anki settings
                      /*
                      ResponsiveHeaderTile(
                        LocaleKeys.SettingsScreen_anki_title.tr(),
                        DaKanjiIcons.anki,
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      // the default deck to add cards to
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_anki_default_deck.tr(),
                        value: ankiDecks[0],
                        items: ankiDecks,
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),
                      // how many langauges should be included
                      ResponsiveSliderTile(
                        text: LocaleKeys.SettingsScreen_anki_default_no_langs.tr(),
                        value: settings.anki.noLangsToInclude.toDouble(),
                        min: 0,
                        max: settings.dictionary.translationLanguageCodes.length.toDouble()-1.0,
                        divisions: settings.dictionary.translationLanguageCodes.length-1,
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                        onSliderMoved: (value) {
                          setState(() {
                            settings.anki.noLangsToInclude = value.toInt();
                            settings.save();
                          });
                        },
                      ),
                      // how many different lines from entries should be included
                      ResponsiveSliderTile(
                        text: LocaleKeys.SettingsScreen_anki_default_no_translations.tr(),
                        value: settings.anki.noTranslations.toDouble(),
                        min: 0,
                        max: 5,
                        divisions: 5,
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                        onSliderMoved: (value) {
                          setState(() {
                            settings.anki.noTranslations = value.toInt();
                            settings.save();
                          });
                        },
                      ),
                      // include google image (disabled for now)
                      if(false)
                        // ignore: dead_code
                        ResponsiveCheckBoxTile(
                          text: "Include google image",
                          value: settings.anki.includeGoogleImage,
                          onTileTapped: (value) {
                            setState(() {
                              settings.anki.includeGoogleImage = value;
                              settings.save();
                            });
                          },
                          autoSizeGroup: g_SettingsAutoSizeGroup,
                        ),
                      // include audio (disabled for now)
                      if(false)
                        // ignore: dead_code
                        ResponsiveCheckBoxTile(
                          text: "Include audio",
                          value: settings.anki.includeAudio,
                          onTileTapped: (value) {
                            setState(() {
                              settings.anki.includeAudio = value;
                              settings.save();
                            });
                          },
                          autoSizeGroup: g_SettingsAutoSizeGroup,
                        ),
                      // include screenshot (disabled for now)
                      if(false)
                        // ignore: dead_code
                        ResponsiveCheckBoxTile(
                          text: "Include screenshot",
                          value: settings.anki.includeScreenshot,
                          onTileTapped: (value) {
                            setState(() {
                              settings.anki.includeScreenshot = value;
                              settings.save();
                            });
                          },
                          autoSizeGroup: g_SettingsAutoSizeGroup,
                        ),
                      
                      // #endregion

                      const Divider(),
                      */

                      // #region - Clipboard header

                      ResponsiveHeaderTile(
                        LocaleKeys.ClipboardScreen_title.tr(),
                        Icons.paste,
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      // try to deconjugate words before searching
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_dict_deconjugate.tr(),
                        value: settings.clipboard.searchDeconjugate,
                        leadingIcon: Icons.info_outline,
                        onTileTapped: (value) {
                          setState(() {
                            settings.clipboard.searchDeconjugate = value;
                            settings.save();
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
                      // reshow tutorial
                      ResponsiveIconButtonTile(
                        text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
                        icon: Icons.replay_outlined,
                        onButtonPressed: () {
                          GetIt.I<UserData>().showTutorialClipboard = true;
                          settings.save();
                          Phoenix.rebirth(context);
                        },
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),

                      // #endregion

                      const Divider(),

                      // #region - Miscellaneous header
                      ResponsiveHeaderTile(
                        LocaleKeys.SettingsScreen_misc_title.tr(),
                        Icons.settings,
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      // theme
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_misc_theme.tr(), 
                        value: settings.misc.selectedTheme,
                        items: settings.misc.themesLocaleKeys,
                        translateItemTexts: true,
                        onChanged: (value) {
                          settings.misc.selectedTheme = value ?? settings.misc.themesLocaleKeys[0];
                          debugPrint(settings.misc.selectedTheme);
                          settings.save();
                          Phoenix.rebirth(context);
                        },
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),
                      // screen to show when app starts
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_misc_default_screen.tr(),
                        value: settings.misc.startupScreensLocales[settings.misc.selectedStartupScreen].tr(),
                        items: settings.misc.startupScreensLocales.map((e) => e.tr()).toList(),
                        onChanged: (newValue) {
                          if (newValue != null){
                            int i = settings.misc.startupScreensLocales.map(
                              (e) => e.tr()
                            ).toList().indexOf(newValue);
                            settings.misc.selectedStartupScreen = i;
                            settings.save();
                          }
                        },
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),
                      // app languages
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_misc_language.tr(), 
                        value: context.locale.toString(),
                        items: context.supportedLocales.map((e) => e.toString()).toList(),
                        onChanged: (newValue) {
                          if(newValue != null){
                            context.setLocale(Locale(newValue));
                          }
                        },
                        autoSizeGroup: g_SettingsAutoSizeGroup,
                      ),
                      // window size
                      if(g_desktopPlatform)
                        ResponsiveIconButtonTile(
                          text: LocaleKeys.SettingsScreen_misc_settings_window_size.tr(),
                          icon: Icons.screenshot_monitor,
                          onButtonPressed: () async {
                            var info = await windowManager.getSize();

                            settings.misc.windowHeight = info.height.toInt();
                            settings.misc.windowWidth = info.width.toInt();

                            settings.save();
                          },
                          autoSizeGroup: g_SettingsAutoSizeGroup,
                        ),
                      // window always on top
                      if(g_desktopPlatform)
                        ResponsiveCheckBoxTile(
                          value: settings.misc.alwaysOnTop,
                          text: LocaleKeys.SettingsScreen_misc_window_on_top.tr(),
                          onTileTapped: (checked) async {
                            windowManager.setAlwaysOnTop(checked);
                            settings.misc.alwaysOnTop = checked;
                            settings.save();
                          },
                          autoSizeGroup: g_SettingsAutoSizeGroup,
                        ),
                      // window opacity
                      if(g_desktopPlatform)
                        ResponsiveSliderTile(
                          text: LocaleKeys.SettingsScreen_misc_window_opacity.tr(),
                          value: settings.misc.windowOpacity,
                          min: 0.2,
                          onChanged: (double value) {
                            windowManager.setOpacity(value);
                            settings.misc.windowOpacity = value;
                            settings.save();
                          },
                          autoSizeGroup: g_SettingsAutoSizeGroup,
                        ),
                      // url for sharing dakanji
                      ResponsiveDropDownTile(
                        text: "Sharing pattern",
                        value: settings.misc.sharingScheme,
                        items: settings.misc.sharingSchemes,
                        onChanged: (value) async {
                          if(value == null){
                            return;
                          }
                          settings.misc.sharingScheme = value;
                          await settings.save();
                        },
                      ),
                      // #endregion

                      const Divider(),

                      // #region - advanced settings
                      ExpansionTile(
                        tilePadding: const EdgeInsets.all(0),
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            LocaleKeys.SettingsScreen_advanced_settings_title.tr(),
                            group: g_SettingsAutoSizeGroup,
                          ),
                        ),
                        children: [
                          // thanos dissolve effect for drawing screen
                          ResponsiveCheckBoxTile(
                            text: LocaleKeys.SettingsScreen_advanced_settings_snap.tr(),
                            value: settings.advanced.useThanosSnap,
                            onTileTapped: (newValue) {
                              settings.advanced.useThanosSnap = newValue;
                              settings.save();
                            },
                            autoSizeGroup: g_SettingsAutoSizeGroup,
                          ),
                          // optimize backends
                          ResponsiveIconButtonTile(
                            text: LocaleKeys.SettingsScreen_advanced_settings_optimize_nn.tr(),
                            icon: Icons.saved_search_sharp,
                            onButtonPressed: () {
                              optimizeBackendsPopup(context).show();
                            },
                            autoSizeGroup: g_SettingsAutoSizeGroup,
                          ),
                          // number of search isolates
                          ResponsiveSliderTile(
                            text: LocaleKeys.SettingsScreen_advanced_settings_number_search_procs.tr(),
                            min: 1,
                            max: max(Platform.numberOfProcessors.toDouble(), 2),
                            divisions: max(Platform.numberOfProcessors - 1, 1),
                            value: settings.advanced.noOfSearchIsolates.toDouble(),
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
                                settings.advanced.noOfSearchIsolates = value.toInt();
                                settings.save();
                              });
                            },
                            onChangeEnd: (double value) async {
                              await GetIt.I<DictionarySearch>().kill();
                              GetIt.I<DictionarySearch>().noIsolates = value.toInt();
                              await GetIt.I<DictionarySearch>().init();
                            },
                            autoSizeGroup: g_SettingsAutoSizeGroup,
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
                              UserData uD = UserData();
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
                              await GetIt.I<Isars>().searchHistory.close(deleteFromDisk: true);
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
                        ],
                      ),
                      // #endregion
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      )
    );
  }
}


