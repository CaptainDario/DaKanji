import 'package:flutter/material.dart';

import 'package:universal_io/io.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/model/core/Screens.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/view/DaKanjiDrawer.dart';
import 'package:da_kanji_mobile/globals.dart';
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
            builder: (context, settings, child){
              return ListView(
                primary: false,
                padding: EdgeInsets.zero,
                children: <Widget>[
                  // different options for dictionary on long press
                  ListTile(
                    title: Text(
                      LocaleKeys.SettingsScreen_drawing_title.tr(), 
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    )
                  ),
                  // dictionary selection
                  ListTile(
                    title: Text(LocaleKeys.SettingsScreen_long_press_opens.tr()),
                    trailing: DropdownButton<String>(
                        value: settings.selectedDictionary,
                        items: settings.dictionaries 
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: () {
                              String text = value.replaceAll("url", LocaleKeys.General_custom_url.tr());
                              text = text.replaceAll("app", LocaleKeys.General_app.tr());
                              text = text.replaceAll("web", LocaleKeys.General_web.tr());
                              
                              return Text(text);
                            } ()
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          settings.selectedDictionary = newValue ?? settings.dictionaries[0];
                          settings.save();
                        },
                      ),
                    onTap: (){},
                  ),
                  // let the user enter a custom url for flexibility
                  ListTile(
                    title: Row(
                      children: [
                        Container(
                          child: Expanded(
                            child: TextField(
                              enabled:
                                settings.selectedDictionary == settings.dictionaries[3],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: settings.customURL,
                                hintText: LocaleKeys.SettingsScreen_custom_url_hint.tr()), 
                              onChanged: (value) {
                                settings.customURL = value;
                                settings.save();
                              },
                            )
                          )
                        ),
                        IconButton(
                          icon: Icon(Icons.info_outline),
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.INFO,
                              headerAnimationLoop: false,
                              body: Column(
                                children: [
                                  Text(
                                    LocaleKeys.SettingsScreen_custom_url_format.tr(),
                                    textScaleFactor: 2,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          LocaleKeys.SettingsScreen_custom_url_explanation.tr(
                                            namedArgs: {'kanjiPlaceholder' : 
                                              settings.kanjiPlaceholder}
                                          )
                                        ),
                                      ]
                                    )
                                  ),
                                ],
                              ),
                            )..show();
                          }
                        )
                      ]
                    ),
                      onTap: () {}
                  ),
                  // invert if short press or long press opens dict / copies to clip
                  CheckboxListTile(
                    title: Text(LocaleKeys.SettingsScreen_invert_short_long_press.tr()),
                    value: settings.invertShortLongPress, 
                    onChanged: (bool? newValue){
                      settings.invertShortLongPress = newValue ?? false;
                      settings.save();
                    }
                  ),
                  // should a double tap on a prediction button empty the canvas
                  CheckboxListTile(
                    title: Text(LocaleKeys.SettingsScreen_empty_canvas_after_double_tap.tr()),
                    value: settings.emptyCanvasAfterDoubleTap, 
                    onChanged: (bool? newValue){
                      settings.emptyCanvasAfterDoubleTap = newValue ?? false;
                      settings.save();
                    }
                  ),
                  if(Platform.isAndroid || Platform.isIOS)
                    CheckboxListTile(
                      title: Text(LocaleKeys.SettingsScreen_use_default_browser_for_online_dictionaries.tr()),
                      value: settings.useWebview,
                      onChanged: (bool? newValue){
                        settings.useWebview = newValue ?? false;
                        settings.save();
                      }
                    ),

                  Divider(),
                  // miscellaneous header
                  ListTile(
                    title: Text(
                      LocaleKeys.SettingsScreen_miscellaneous_title.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                  ),
                  // setting for which theme to use
                  ListTile(
                    title: Text(LocaleKeys.SettingsScreen_theme.tr()),
                    trailing: DropdownButton<String>(
                      value: settings.selectedTheme,
                      items: settings.themes
                        .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: () {
                            String text = value.replaceAll("light", LocaleKeys.General_light.tr());
                            text = text.replaceAll("dark", LocaleKeys.General_dark.tr());
                            text = text.replaceAll("system", LocaleKeys.General_system.tr());
                            
                            return Text(text);
                          } ()
                          );
                        }
                      ).toList(),
                      onChanged: (String? newValue) {
                        settings.selectedTheme = newValue ?? settings.themes[0];
                        settings.save();
                        Phoenix.rebirth(context);
                      },
                    ),
                    onTap: () {}
                  ),
                  // Setting for which language to use
                  ListTile(
                    title: Text(LocaleKeys.General_language.tr()),
                    trailing: DropdownButton<String>(
                      value: settings.selectedLocale.toString(),
                      items: context.supportedLocales
                        .map<DropdownMenuItem<String>>((Locale value) {
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: () {
                              return Text(value.languageCode);
                            } ()
                          );
                        }
                      ).toList(),
                      onChanged: (String? newValue) {
                        context.setLocale(Locale(newValue ?? "en"));
                        settings.selectedLocale = Locale(newValue ?? "en");
                        settings.save();
                      },
                    ),
                    onTap: () {}
                  ),
                  // reshow tutorial
                  ListTile(
                    title: Text(LocaleKeys.SettingsScreen_show_tutorial.tr()),
                    trailing: IconButton(
                      icon: Icon(Icons.replay_outlined),
                      onPressed: () { 
                        SHOW_SHOWCASE_DRAWING = true;
                        settings.save();
                        Phoenix.rebirth(context);
                      }
                    )
                  ),
                  // advanced settings
                  ExpansionTile(
                    title: Text(LocaleKeys.SettingsScreen_advanced_settings_title.tr()),
                    children: [
                      ListTile(
                        title: Text(LocaleKeys.SettingsScreen_advanced_settings_drawing_inference_backend.tr()),
                        trailing: DropdownButton<String>(
                            value: settings.backendCNNSingleChar,
                            items: settings.inferenceBackends 
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: () { 
                                  return Text(value); 
                                } ()
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              print(newValue);
                              settings.backendCNNSingleChar = newValue ?? settings.inferenceBackends[0];
                              settings.save();
                              print(newValue);
                            },
                          ),
                        onTap: (){},
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        )
      )
    );
  }
}
