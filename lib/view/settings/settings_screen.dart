import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'dart:io';

import 'package:universal_io/io.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:window_size/window_size.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:da_kanji_mobile/model/user_data.dart';
import 'package:da_kanji_mobile/model/Dict/dict_languages.dart';
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

  const SettingsScreen(this.openedByDrawer, {Key? key}) : super(key: key);

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
                        autoSizeGroup: globalSettingsAutoSizeGroup
                      ),
                      // Dictionary Options
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_long_press_opens.tr(),
                        value: settings.selectedDictionary,
                        items: settings.settingsDrawing.dictionaries,
                        onTap: (newValue) {
                          settings.selectedDictionary = newValue
                            ?? settings.settingsDrawing.dictionaries[0];
                          settings.save();
                        },
                      ),
                      // custom URL input
                      ResponsiveInputFieldTile(
                        text: settings.customURL,
                        enabled: settings.selectedDictionary
                          == settings.settingsDrawing.dictionaries[3],
                        hintText: LocaleKeys.SettingsScreen_custom_url_hint.tr(),
                        icon: Icons.info_outline,
                        onChanged: (value) {
                          settings.customURL = value;
                          settings.save();
                        },
                        onButtonPressed: () => showCustomURLPopup(context),
                        
                      ),
                      // invert long/short press
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_invert_short_long_press.tr(),
                        value: GetIt.I<Settings>().invertShortLongPress,
                        onTileTapped: (bool? newValue){
                          settings.invertShortLongPress = newValue ?? false;
                          settings.save();
                        }
                      ),
                      // double tap empties canvas
                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_empty_canvas_after_double_tap.tr(),
                        value: GetIt.I<Settings>().emptyCanvasAfterDoubleTap,
                        onTileTapped: (bool? newValue){
                          settings.emptyCanvasAfterDoubleTap = newValue ?? false;
                          settings.save();
                        }
                      ),
                      if(Platform.isAndroid || Platform.isIOS)
                        ResponsiveCheckBoxTile(
                          text: LocaleKeys.SettingsScreen_use_default_browser_for_online_dictionaries.tr(),
                          value: GetIt.I<Settings>().useWebview,
                          onTileTapped: (value) {
                            settings.useWebview = value;
                            settings.save();
                          },
                        ),
                      // settings
                      /*
                      ExpansionTile(
                        tilePadding: EdgeInsets.all(0),
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            "Key bindings",
                            group: globalSettingsAutoSizeGroup,
                          ),
                        ),
                        children: [
                          ResponsiveKeybindingInput(
                            keyBinding: settings.settingsDrawing.kbLongPressMod,
                            hintText: "Long Press modifier",
                            defaultKeyBinding:
                              settings.settingsDrawing.kbLongPressModDefault,
                            onChanged: (key) {
                              settings.settingsDrawing.kbLongPressMod = key;
                              settings.save();
                            },
                          ),
                          ResponsiveKeybindingInput(
                            keyBinding: settings.settingsDrawing.kbDoublePressMod,
                            hintText: "Double Press modifier",
                            defaultKeyBinding:
                              settings.settingsDrawing.kbDoublePressModDefault,
                            onChanged: (key) {
                              settings.settingsDrawing.kbDoublePressMod = key;
                              settings.save();
                            },
                          ),
                          ResponsiveKeybindingInput(
                            keyBinding: settings.settingsDrawing.kbClearCanvas,
                            hintText: "Clear canvas",
                            defaultKeyBinding:
                              settings.settingsDrawing.kbClearCanvasDefault,
                            onChanged: (key) {
                              settings.settingsDrawing.kbClearCanvas = key;
                              settings.save();
                            },
                          ),
                          ResponsiveKeybindingInput(
                            keyBinding: settings.settingsDrawing.kbUndoStroke,
                            hintText: "Undo last stroke",
                            defaultKeyBinding:
                              settings.settingsDrawing.kbUndoStrokeDefault,
                            onChanged: (key) {
                              settings.settingsDrawing.kbUndoStroke = key;
                              settings.save();
                            },
                          ),
                          ResponsiveKeybindingInput(
                            keyBinding: settings.settingsDrawing.kbWordBar,
                            hintText: "Press word bar",
                            defaultKeyBinding:
                              settings.settingsDrawing.kbWordBarDefault,
                            onChanged: (key) {
                              settings.settingsDrawing.kbWordBar = key;
                              settings.save();
                            },
                          ),
                          ResponsiveKeybindingInput(
                            keyBinding: settings.settingsDrawing.kbWordBarDelChar,
                            hintText: "Delete character from word bar",
                            defaultKeyBinding:
                              settings.settingsDrawing.kbWordBarDelCharDefault,
                            onChanged: (key) {
                              settings.settingsDrawing.kbWordBarDelChar = key;
                              settings.save();
                            },
                          ),

                          ...List.generate(
                            settings.settingsDrawing.kbPreds.length,
                            (i) => ResponsiveKeybindingInput(
                              keyBinding: settings.settingsDrawing.kbPreds[i],
                              hintText: "Press prediction ${i+1}",
                              defaultKeyBinding:
                                settings.settingsDrawing.kbPredsDefaults[i],
                              onChanged: (key) {
                                settings.settingsDrawing.kbPreds[i] = key;
                                settings.save();
                              },
                            ),
                          ),
                        ],
                      ),
                      */
                      // #endregion

                      const Divider(),

                      // #region - Dict header

                      ResponsiveHeaderTile(
                        LocaleKeys.Dictionary_title.tr(),
                        autoSizeGroup: globalSettingsAutoSizeGroup
                      ),

                      MultiSelectDialogField(
                        title: const Text("Select languages"),
                        buttonText: Text(LocaleKeys.SettingsScreen_dict_languages.tr()),
                        items: DictLanguages.values.map(
                          (e) => MultiSelectItem(e, e.name)
                        ).toList(),
                        listType: MultiSelectListType.CHIP,
                        onConfirm: (values) {
                          //_selectedAnimals = values;
                        },
                      ),

                      ResponsiveCheckBoxTile(
                        text: LocaleKeys.SettingsScreen_dict_include_names_in_dict.tr(),
                        value: GetIt.I<Settings>().emptyCanvasAfterDoubleTap,
                        onTileTapped: (bool? newValue){
                          settings.emptyCanvasAfterDoubleTap = newValue ?? false;
                          settings.save();
                        }
                      ),


                      // #endregion

                      const Divider(),

                      // #region - Miscellaneous header
                      ResponsiveHeaderTile(
                        LocaleKeys.SettingsScreen_miscellaneous_title.tr(),
                        autoSizeGroup: globalSettingsAutoSizeGroup
                      ),
                      // theme
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_theme.tr(), 
                        value: settings.selectedTheme,
                        items: settings.settingsMisc.themesLocaleKeys,
                        translateItemTexts: true,
                        onTap: (value) {
                          settings.selectedTheme = value ?? settings.settingsMisc.themesLocaleKeys[0];
                          print(settings.selectedTheme);
                          settings.save();
                          Phoenix.rebirth(context);
                        },
                      ),
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_misc_default_screen.tr(),
                        value: Screens.drawing.name,
                        items: [
                          Screens.drawing.name,
                          Screens.dictionary.name,
                          Screens.text.name,
                        ],
                        onTap: (newValue) {
                          settings.selectedDictionary = newValue
                            ?? settings.settingsDrawing.dictionaries[0];
                          settings.save();
                        },
                      ),
                      // language
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
                      // windows size
                      if(Platform.isLinux || Platform.isMacOS || Platform.isWindows)
                        ResponsiveIconButtonTile(
                          text: LocaleKeys.SettingsScreen_misc_settings_window_size.tr(),
                          icon: Icons.screenshot_monitor,
                          onButtonPressed: () async {
                            var info = await getWindowInfo();

                            settings.settingsMisc.windowHeight = info.frame.height.toInt();
                            settings.settingsMisc.windowWidth = info.frame.width.toInt();

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
                            group: globalSettingsAutoSizeGroup,
                          ),
                        ),
                        children: [
                          // thanos dissolve effect for drawing screen
                          ResponsiveCheckBoxTile(
                            text: LocaleKeys.SettingsScreen_advanced_settings_snap.tr(),
                            value: settings.useThanosSnap,
                            onTileTapped: (newValue) {
                              settings.useThanosSnap = newValue;
                              settings.save();
                            },
                          ),
                          // inference backend
                          ResponsiveDropDownTile(
                            text: LocaleKeys.SettingsScreen_advanced_settings_drawing_inference_backend.tr(), 
                            value: settings.inferenceBackend, 
                            items: settings.settingsAdvanced.inferenceBackends,
                            onTap: (newValue) {
                              if(newValue != null){
                                settings.inferenceBackend = newValue;
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


