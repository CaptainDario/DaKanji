// Flutter imports:
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

}
