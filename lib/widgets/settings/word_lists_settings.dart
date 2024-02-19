// Flutter imports:
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:da_kanji_mobile/application/app/restart.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:file_picker/file_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as p;

// Project imports:
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_button_tile.dart';

class WordListSettings extends StatefulWidget {
    
  /// DaKanji settings object
  final Settings settings;

  const WordListSettings(
    this.settings,
    {
      super.key
    }
  );

  @override
  State<WordListSettings> createState() => _WordListSettingsState();
}

class _WordListSettingsState extends State<WordListSettings> {

  @override
  Widget build(BuildContext context) {
    return ResponsiveHeaderTile(
      LocaleKeys.WordListsScreen_title.tr(),
      Icons.list,
      autoSizeGroup: g_SettingsAutoSizeGroup,
      children: [
        ResponsiveIconButtonTile(
          text: "Readd defaults folder",
          icon: Icons.undo,
          onButtonPressed: () async => await readdDefaults()
        ),
        ResponsiveIconButtonTile(
          text: "Export word lists database",
          icon: Icons.arrow_upward,
          onButtonPressed: () async => await exportWordLists(),
        ),
        ResponsiveIconButtonTile(
          text: "Import word lists database",
          icon: Icons.arrow_downward,
          onButtonPressed: () async => importWordLists(),
        ),
        // reshow tutorial
        ResponsiveIconButtonTile(
          text: LocaleKeys.SettingsScreen_show_tutorial.tr(),
          icon: Icons.replay_outlined,
          onButtonPressed: () {
            GetIt.I<UserData>().showTutorialWordLists = true;
            widget.settings.save();
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
      title: "Warning",
      desc: "This will overwrite all your word lists, are you sure?",
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

        // ignore: use_build_context_synchronously
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.noHeader,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title: "Error",
          desc: "The provide file is not valid. Please select a valid file and try again.",
          btnOkColor: g_Dakanji_green,
          btnOkOnPress: () {}
        ).show();
      }
      
    ).show();

  }
}
