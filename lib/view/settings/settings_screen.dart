import 'package:da_kanji_mobile/helper/iso/iso_table.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reorderables/reorderables.dart';

import 'package:da_kanji_mobile/model/user_data.dart';
import 'package:da_kanji_mobile/model/screens.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';
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
                        LocaleKeys.SettingsScreen_draw_title.tr(),
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      // Dictionary Options
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_draw_long_press_opens.tr(),
                        value: settings.drawing.selectedDictionary,
                        items: settings.drawing.dictionaries,
                        onTap: (newValue) {
                          settings.drawing.selectedDictionary = newValue
                            ?? settings.drawing.dictionaries[0];
                          settings.save();
                        },
                      ),
                      // custom URL input
                      if(settings.drawing.selectedDictionary == settings.drawing.webDictionaries[3])
                        ResponsiveInputFieldTile(
                          text: settings.drawing.customURL,
                          enabled: true,
                          hintText: LocaleKeys.SettingsScreen_draw_custom_url_hint.tr(),
                          icon: Icons.info_outline,
                          onChanged: (value) {
                            settings.drawing.customURL = value;
                            settings.save();
                          },
                          onButtonPressed: () => showCustomURLPopup(context),
                        ),
                      // invert long/short press
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_draw_invert_short_long_press.tr(),
                        value: GetIt.I<Settings>().drawing.invertShortLongPress,
                        onTileTapped: (bool? newValue){
                          settings.drawing.invertShortLongPress = newValue ?? false;
                          settings.save();
                        }
                      ),
                      // double tap empties canvas
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_draw_double_tap_empty_canvas.tr(),
                        value: GetIt.I<Settings>().drawing.emptyCanvasAfterDoubleTap,
                        onTileTapped: (bool? newValue){
                          settings.drawing.emptyCanvasAfterDoubleTap = newValue ?? false;
                          settings.save();
                        }
                      ),
                      if(g_webViewSupported)
                        ResponsiveCheckBoxTile(
                          text: LocaleKeys.SettingsScreen_draw_browser_for_online_dict.tr(),
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
                      // #endregion

                      const Divider(),

                      // #region - Dict header

                      ResponsiveHeaderTile(
                        LocaleKeys.DictionaryScreen_title.tr(),
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
                              String lang = GetIt.I<Settings>().dictionary.translationLanguageCodes[index];
                              return GestureDetector(
                                onTap: () {
                                  if(lang == iso639_1.en.name)
                                    return;

                                  setState(() {
                                    if(!settings.dictionary.selectedTranslationLanguages.contains(lang)){
                                      settings.dictionary.selectedTranslationLanguages.add(lang);
                                    }
                                    else{
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
                      // Do not deconjugate inputs to the dictionary
                      /*
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_dict_deconjugate.tr(),
                        value: false,
                        onTileTapped: (value) {

                        },
                      ),
                      */
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
                        LocaleKeys.SettingsScreen_misc_title.tr(),
                        autoSizeGroup: g_SettingsAutoSizeGroup
                      ),
                      // theme
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_misc_theme.tr(), 
                        value: settings.misc.selectedTheme,
                        items: settings.misc.themesLocaleKeys,
                        translateItemTexts: true,
                        onTap: (value) {
                          settings.misc.selectedTheme = value ?? settings.misc.themesLocaleKeys[0];
                          print(settings.misc.selectedTheme);
                          settings.save();
                          Phoenix.rebirth(context);
                        },
                      ),
                      // screen to show when app starts
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_misc_default_screen.tr(),
                        value: settings.misc.startupScreensLocales[settings.misc.selectedStartupScreen].tr(),
                        items: settings.misc.startupScreensLocales.map((e) => e.tr()).toList(),
                        onTap: (newValue) {
                          if (newValue != null){
                            int i = settings.misc.startupScreensLocales.map(
                              (e) => e.tr()
                            ).toList().indexOf(newValue);
                            settings.misc.selectedStartupScreen = i;
                            settings.save();
                          }
                        },
                      ),
                      // app languages
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_misc_language.tr(), 
                        value: context.locale.toString(),
                        items: context.supportedLocales.map((e) => e.toString()).toList(),
                        onTap: (newValue) {
                          if(newValue != null){
                            context.setLocale(Locale(newValue));
                            Phoenix.rebirth(context);
                          }
                        },
                      ),
                      // windows size
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
                        ),
                      // window opacity
                      if(g_desktopPlatform)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                LocaleKeys.SettingsScreen_misc_window_opacity.tr()
                              )
                            ),
                            Expanded(
                              flex: 4,
                              child: Slider(
                                value: settings.misc.windowOpacity,
                                max: 1.0,
                                min: 0.2,
                                onChanged: (double value) {
                                  windowManager.setOpacity(value);
                                  settings.misc.windowOpacity = value;
                                  settings.save();
                                },
                              ),
                            ),
                          ],
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


