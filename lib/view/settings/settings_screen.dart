import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reorderables/reorderables.dart';
import 'dart:io';

import 'package:universal_io/io.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:window_size/window_size.dart';

import 'package:da_kanji_mobile/model/user_data.dart';
import 'package:da_kanji_mobile/model/screens.dart';
import 'package:da_kanji_mobile/provider/settings.dart';
import 'package:da_kanji_mobile/view/widgets/fullScreenList/responsive_header_tile.dart';
import 'package:da_kanji_mobile/view/drawer/drawer.dart';
import 'package:da_kanji_mobile/view/settings/custom_url_popup.dart';
import 'package:da_kanji_mobile/view/widgets/fullScreenList/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/view/widgets/fullScreenList/responsive_drop_down_tile.dart';
import 'package:da_kanji_mobile/view/widgets/fullScreenList/responsive_icon_button_tile.dart';
import 'package:da_kanji_mobile/view/widgets/fullScreenList/responsive_input_field_tile.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/globals.dart';



/// The "settings"-screen.
/// 
/// Here all settings of the app can be managed.
class SettingsScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;

  const SettingsScreen(this.openedByDrawer, {super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}


class _SettingsScreenState extends State<SettingsScreen> {

  late ScrollController scrollController;

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
        animationAtStart: !widget.openedByDrawer,
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
                        LocaleKeys.SettingsScreen_drawing_title.tr(),
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      // Dictionary Options
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_long_press_opens.tr(),
                        value: settings.drawing.selectedDictionary,
                        items: settings.drawing.dictionaries,
                        onTap: (newValue) {
                          settings.drawing.selectedDictionary = newValue
                            ?? settings.drawing.dictionaries[0];
                          settings.save();
                        },
                      ),
                      // custom URL input
                      ResponsiveInputFieldTile(
                        text: settings.drawing.customURL,
                        enabled: settings.drawing.selectedDictionary
                          == settings.drawing.dictionaries[3],
                        hintText: LocaleKeys.SettingsScreen_custom_url_hint.tr(),
                        icon: Icons.info_outline,
                        onChanged: (value) {
                          settings.drawing.customURL = value;
                          settings.save();
                        },
                        onButtonPressed: () => showCustomURLPopup(context),
                        
                      ),
                      // invert long/short press
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_invert_short_long_press.tr(),
                        value: GetIt.I<Settings>().drawing.invertShortLongPress,
                        onTileTapped: (bool? newValue){
                          settings.drawing.invertShortLongPress = newValue ?? false;
                          settings.save();
                        }
                      ),
                      // double tap empties canvas
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_empty_canvas_after_double_tap.tr(),
                        value: GetIt.I<Settings>().drawing.emptyCanvasAfterDoubleTap,
                        onTileTapped: (bool? newValue){
                          settings.drawing.emptyCanvasAfterDoubleTap = newValue ?? false;
                          settings.save();
                        }
                      ),
                      if(Platform.isAndroid || Platform.isIOS)
                        ResponsiveCheckBoxTile(
                          text: LocaleKeys.SettingsScreen_use_default_browser_for_online_dictionaries.tr(),
                          value: GetIt.I<Settings>().drawing.useWebview,
                          onTileTapped: (value) {
                            settings.drawing.useWebview = value;
                            settings.save();
                          },
                        ),
                      // reshow tutorial
                      ResponsiveIconButtonTile(
                        text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
                        icon: Icons.replay_outlined,
                        onButtonPressed: () {
                          GetIt.I<UserData>().showShowcaseDrawing = true;
                          settings.save();
                          Phoenix.rebirth(context);
                        },
                      ),

                      const Divider(),

                      // #region - Dict header

                      ResponsiveHeaderTile(
                        LocaleKeys.Dictionary_title.tr(),
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: Align(
                          alignment: Alignment.centerLeft, 
                          child: AutoSizeText(
                            "Show translations in (drag to reorder)",
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
                              String lang = GetIt.I<Settings>().dictionary.translationLanguageCodes[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if(!settings.dictionary.selectedTranslationLanguages.contains(lang)){
                                      settings.dictionary.selectedTranslationLanguages.add(lang);
                                    }
                                    else{
                                      if(settings.dictionary.selectedTranslationLanguages.length <= 1){
                                        return;
                                      }
                                      settings.dictionary.selectedTranslationLanguages.remove(lang);
                                    }
                                    settings.save();
                                  });
                                },
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
                      // reshow tutorial
                      ResponsiveIconButtonTile(
                        text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
                        icon: Icons.replay_outlined,
                        onButtonPressed: () {
                          GetIt.I<UserData>().showShowcaseDictionary = true;
                          settings.save();
                          Phoenix.rebirth(context);
                        },
                      ),

                      // #endregion

                      const Divider(),

                      // #region - Text header

                      ResponsiveHeaderTile(
                        LocaleKeys.TextScreen_title.tr(),
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      // reshow tutorial
                      ResponsiveIconButtonTile(
                        text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
                        icon: Icons.replay_outlined,
                        onButtonPressed: () {
                          GetIt.I<UserData>().showShowcaseText = true;
                          settings.save();
                          Phoenix.rebirth(context);
                        },
                      ),

                      // #endregion

                      const Divider(),

                      // #region - Miscellaneous header
                      ResponsiveHeaderTile(
                        LocaleKeys.SettingsScreen_miscellaneous_title.tr(),
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      // theme
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_theme.tr(), 
                        value: settings.misc.selectedTheme,
                        items: settings.misc.themesLocaleKeys,
                        translateItemTexts: true,
                        onTap: (value) {
                          settings.misc.selectedTheme = value ?? settings.misc.themesLocaleKeys[0];
                          debugPrint(settings.misc.selectedTheme);
                          settings.save();
                          Phoenix.rebirth(context);
                        },
                      ),
                      // screen to show when app starts
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_misc_default_screen.tr(),
                        value: settings.misc.selectedStartupScreen,
                        items: settings.misc.startupScreens,
                        onTap: (newValue) {
                          if (newValue != null){
                            settings.misc.selectedStartupScreen = newValue;
                            settings.save();
                          }
                        },
                      ),
                      // app languages
                      ResponsiveDropDownTile(
                        text: LocaleKeys.General_language.tr(), 
                        value: context.locale.toString(),
                        items: context.supportedLocales.map((e) => e.toString()).toList(),
                        onTap: (newValue) {
                          if(newValue != null){
                            context.setLocale(Locale(newValue));
                          }
                        },
                      ),
                      // windows size
                      if(Platform.isLinux || Platform.isMacOS || Platform.isWindows)
                        ResponsiveIconButtonTile(
                          text: LocaleKeys.SettingsScreen_misc_settings_window_size.tr(),
                          icon: Icons.screenshot_monitor,
                          onButtonPressed: () async {
                            var info = await getWindowInfo();

                            settings.misc.windowHeight = info.frame.height.toInt();
                            settings.misc.windowWidth = info.frame.width.toInt();

                            settings.save();
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
                          ),
                          // inference backend
                          ResponsiveDropDownTile(
                            text: LocaleKeys.SettingsScreen_advanced_settings_drawing_inference_backend.tr(), 
                            value: settings.advanced.inferenceBackend, 
                            items: settings.advanced.inferenceBackends,
                            onTap: (newValue) {
                              if(newValue != null){
                                settings.advanced.inferenceBackend = newValue;
                                settings.save();
                              }
                            },
                          )
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


