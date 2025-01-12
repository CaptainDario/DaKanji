// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as p;

// Project imports:
import 'package:da_kanji_mobile/application/app/restart.dart';
import 'package:da_kanji_mobile/application/screensaver/screensaver.dart';
import 'package:da_kanji_mobile/entities/da_kanji_icons.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_slider_tile.dart';
import 'package:da_kanji_mobile/widgets/settings/export_include_languages_chips.dart';
import 'package:da_kanji_mobile/widgets/settings/show_word_frequency_setting.dart';
import 'package:da_kanji_mobile/widgets/word_lists/word_lists_selection_dialog.dart';
import 'package:provider/provider.dart';

class WordListSettings extends StatefulWidget {
    
  const WordListSettings({super.key});

  @override
  State<WordListSettings> createState() => _WordListSettingsState();
}

class _WordListSettingsState extends State<WordListSettings> {

  @override
  Widget build(BuildContext context) {

    Settings settings = context.watch<Settings>();

    return ResponsiveHeaderTile(
      LocaleKeys.WordListsScreen_title.tr(),
      DaKanjiIcons.wordLists,
      autoSizeGroup: g_SettingsAutoSizeGroup,
      children: [
        // show word frequency in search results / dictionary
        ShowWordFrequencySetting(
          settings.wordLists.showWordFruequency,
          onTileTapped: (value) {
            setState(() {
              settings.wordLists.showWordFruequency = value;
              settings.save();
            });
          },
        ),
        // which langauges should be included
        ExportLanguagesIncludeChips(
          text: LocaleKeys.SettingsScreen_word_lists_languages_to_include_in_export.tr(),
          includedLanguages: settings.wordLists.includedLanguages,
          selectedTranslationLanguages: settings.dictionary.selectedTranslationLanguages,
          settings: settings,
          setIncludeLanguagesItem: settings.wordLists.setIncludeLanguagesItem,
        ),
        // To which lists should be added when quick adding
        ResponsiveIconButtonTile(
          text: "${LocaleKeys.SettingsScreen_word_lists_quick_add_lists.tr()} ${settings.wordLists.quickAddListIDs.length}",
          icon: Icons.perm_device_information_outlined,
          onButtonPressed: () async {

            List<int> selectedItems = settings.wordLists.quickAddListIDs;

            await showWordListSelectionDialog(context,
              wordlists: GetIt.I<WordListsSQLDatabase>(),
              selectedItems: selectedItems,
              onSelectionConfirmed: (selection) async {
                
                List<int> listsToAddTo = selection
                  .where((e) => e.value.type == WordListNodeType.wordList)
                  .map((e) => e.id).toList();

                settings.wordLists.quickAddListIDs = listsToAddTo;

                Navigator.of(context).pop();

                await settings.save();
                setState(() { });
              },
            );
          },
        ),
        // PDF:  how many different translations from entries should be included
        ResponsiveSliderTile(
          text: LocaleKeys.SettingsScreen_word_lists_pdf_max_meanings_per_vocabulary.tr(),
          value: settings.wordLists.pdfMaxMeaningsPerVocabulary.toDouble(),
          min: 1,
          max: 50,
          divisions: 50,
          showLabelAsInt: true,
          autoSizeGroup: g_SettingsAutoSizeGroup,
          
          onChanged: (value) {
            setState(() {
              settings.wordLists.pdfMaxMeaningsPerVocabulary = value.toInt();
              settings.save();
            });
          },
        ),
        // PDF: how many words per meaning
        ResponsiveSliderTile(
          text: LocaleKeys.SettingsScreen_word_lists_pdf_max_words_per_meaning.tr(),
          value: settings.wordLists.pdfMaxWordsPerMeaning.toDouble(),
          min: 1,
          max: 50,
          divisions: 50,
          showLabelAsInt: true,
          autoSizeGroup: g_SettingsAutoSizeGroup,

          onChanged: (value) {
            setState(() {
              settings.wordLists.pdfMaxWordsPerMeaning = value.toInt();
              settings.save();
            });
          },
        ),
        // PDF translations
        ResponsiveSliderTile(
          text: LocaleKeys.SettingsScreen_word_lists_pdf_max_lines_per_meaning.tr(),
          value: settings.wordLists.pdfMaxLinesPerMeaning.toDouble(),
          min: 1,
          max: 50,
          divisions: 50,
          showLabelAsInt: true,
          autoSizeGroup: g_SettingsAutoSizeGroup,

          onChanged: (value) {
            setState(() {
              settings.wordLists.pdfMaxLinesPerMeaning = value.toInt();
              settings.save();
            });
          },
        ),
        //pdf include kana
        ResponsiveCheckBoxTile(
          text:  LocaleKeys.SettingsScreen_word_lists_pdf_include_kana.tr(),
          value: settings.wordLists.pdfIncludeKana,
          onTileTapped: (value) {
            setState(() {
              settings.wordLists.pdfIncludeKana = value;
              settings.save();
            });
          },
        ),

        // Screensaver: should it automatically start after the set interval
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_word_lists_screensaver_auto_show.tr(),
          value: settings.wordLists.autoStartScreensaver,
          onTileTapped: (value) {
            settings.wordLists.autoStartScreensaver = value;
            settings.save();
          },
        ),
        // Screen saver: show
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_word_lists_screensaver_show.tr(),
          icon: Icons.play_arrow,
          onButtonPressed: () async {
            startScreensaver(settings.wordLists.screenSaverWordLists);
          },
        ),
        // Screen saver: Which word lists to use
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_word_lists_screensaver_word_lists_to_use.tr(),
          icon: Icons.list_alt,
          onButtonPressed: () async {
            await showWordListSelectionDialog(
              context,
              onSelectionConfirmed: (selection) async {
                settings.wordLists.screenSaverWordLists =
                  selection.map((e) => e.id).toList();
                settings.save();
                Navigator.of(context, rootNavigator: false).pop();
              },
            );
          },
        ),
        // Screen Saver: how long to auto start
        if(g_desktopPlatform)
          ResponsiveSliderTile(
            text: LocaleKeys.SettingsScreen_word_lists_screensaver_seconds_to_start.tr(),
            value: settings.wordLists.screenSaverSecondsToStart.toDouble(),
            min: 1,
            max: 60*10,
            showLabelAsInt: true,
            onChanged: (value) async {
              settings.wordLists.screenSaverSecondsToStart = value.toInt();
              await settings.save();
            },
          ),
        // Screen Saver: seconds to next card
        ResponsiveSliderTile(
          text: LocaleKeys.SettingsScreen_word_lists_screensaver_seconds_to_next_card.tr(),
          value: settings.wordLists.screenSaverSecondsToNextCard.toDouble(),
          min: 1,
          max: 120,
          showLabelAsInt: true,
          onChanged: (value) async {
            settings.wordLists.screenSaverSecondsToNextCard = value.toInt();
            await settings.save();
          },
        ),
        // readd defaults
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_word_lists_readd_defaults.tr(),
          icon: Icons.undo,
          onButtonPressed: () async => await readdDefaults()
        ),
        // export word lists
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_word_lists_export.tr(),
          icon: Icons.arrow_upward,
          onButtonPressed: () async => await exportWordLists(),
        ),
        // import word lists
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_word_lists_import.tr(),
          icon: Icons.arrow_downward,
          onButtonPressed: () async => importWordLists(),
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
      ],
    );
  }

  /// Readds the defaults folder to the words lists root if it has been removed
  Future readdDefaults() async {
    await GetIt.I<WordListsSQLDatabase>().readdDefaultsToRoot();
  }

  /// Exports the current word lists
  /// Lets the user select a directory and stores the file there 
  Future exportWordLists() async {

    final exportDir = await FilePicker.platform.getDirectoryPath();
    if(exportDir != null){
      g_DakanjiPathManager.wordListsSqlFile.copy(
        p.join(exportDir, p.basename(g_DakanjiPathManager.wordListsSqlFile.path)));
    }

  }

  /// Lets the user select a wordlists database file and import it
  Future importWordLists() async {

    await AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      title: LocaleKeys.SettingsScreen_word_lists_import_warning.tr(),
      desc: LocaleKeys.SettingsScreen_word_lists_import_warning_description.tr(),
      btnCancelColor: g_Dakanji_red,
      btnCancelOnPress: () {},
      btnOkColor: g_Dakanji_green,
      btnOkOnPress: () async {
        final files = await FilePicker.platform.pickFiles(
          lockParentWindow: true,
          type: FileType.any,
          allowedExtensions: [".sqlite"]
        );
        if(files != null &&
          files.files.first.path != null && 
          files.files.first.name.endsWith(".sqlite")){

          File dbFile = File(files.files.first.path!);
          bool fileSeemsvalid = false;

          // try loading the file to check that it is valid
          try {
            await GetIt.I.unregister(
              instance: GetIt.I<WordListsSQLDatabase>(),
              disposingFunction: (WordListsSQLDatabase p0) async {
                await p0.close();
              },
            );

            WordListsSQLDatabase db = WordListsSQLDatabase(dbFile);
            await db.init();
            fileSeemsvalid = true;
          } 
          catch (e) {
            debugPrint(e.toString());  
          }

          // overwrite existing database
          if(fileSeemsvalid){
            g_DakanjiPathManager.wordListsSqlFile.deleteSync();
            dbFile.copySync(g_DakanjiPathManager.wordListsSqlFile.path);
            
            // ignore: use_build_context_synchronously
            await restartApp(context);
          }
        }

        await AwesomeDialog(
          // ignore: use_build_context_synchronously
          context: context,
          dialogType: DialogType.noHeader,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title: LocaleKeys.SettingsScreen_word_lists_import_error.tr(),
          desc: LocaleKeys.SettingsScreen_word_lists_import_error_description.tr(),
          btnOkColor: g_Dakanji_green,
          btnOkOnPress: () {}
        ).show();
      }
      
    ).show();

  }
}

