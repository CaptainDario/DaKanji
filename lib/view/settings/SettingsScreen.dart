import 'package:da_kanji_mobile/view/widgets/fullScreenList/ResponsiveInputFieldTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:universal_io/io.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/model/UserData.dart';
import 'package:da_kanji_mobile/view/widgets/fullScreenList/ResponsiveHeaderTile.dart';
import 'package:da_kanji_mobile/model/Screens.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/view/drawer/Drawer.dart';
import 'package:da_kanji_mobile/view/settings/customURLPopup.dart';
import 'package:da_kanji_mobile/view/widgets/fullScreenList/ResponsiveCheckBoxTile.dart';
import 'package:da_kanji_mobile/view/widgets/fullScreenList/ResponsiveDropDownTile.dart';
import 'package:da_kanji_mobile/view/widgets/fullScreenList/ResponsiveIconIconButtonTile.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



/// The "settings"-screen.
/// 
/// Here all settings of the app can be managed.
class SettingsScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;

  SettingsScreen(this.openedByDrawer);

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

                      // Drawing header
                      ResponsiveHeaderTile(
                        LocaleKeys.SettingsScreen_drawing_title.tr(),
                        autoSizeGroup: settingsAutoSizeGroup
                      ),
                      // Dictionary Options
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_long_press_opens.tr(),
                        value: settings.selectedDictionary,
                        items: settings.dictionaries,
                        onTap: (newValue) {
                          settings.selectedDictionary = newValue ?? settings.dictionaries[0];
                          settings.save();
                        },
                      ),
                      // custom URL input
                      ResponsiveInputFieldTile(
                        text: settings.customURL,
                        enabled: settings.selectedDictionary == settings.dictionaries[3],
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

                      Divider(),
                      // Miscellaneous header
                      ResponsiveHeaderTile(
                        LocaleKeys.SettingsScreen_miscellaneous_title.tr(),
                        autoSizeGroup: settingsAutoSizeGroup
                      ),
                      // theme
                      ResponsiveDropDownTile(
                        text: LocaleKeys.SettingsScreen_theme.tr(), 
                        value: settings.selectedTheme,
                        items: settings.themesLocaleKeys,
                        translateItemTexts: true,
                        onTap: (value) {
                          settings.selectedTheme = value ?? settings.themesLocaleKeys[0];
                          print(settings.selectedTheme);
                          settings.save();
                          Phoenix.rebirth(context);
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
                          onButtonPressed: () {
                            
                          },
                        ),

                      // advanced settings
                      ExpansionTile(
                        tilePadding: EdgeInsets.all(0),
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            LocaleKeys.SettingsScreen_advanced_settings_title.tr(),
                            group: settingsAutoSizeGroup,
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
                            value: settings.backendCNNSingleChar, 
                            items: settings.inferenceBackends,
                          )
                        ],
                      ),
              
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


