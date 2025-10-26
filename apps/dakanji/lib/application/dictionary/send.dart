// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/anki/anki_dialog.dart';
import 'package:da_kanji_mobile/widgets/anki/anki_not_setup_dialog.dart';

/// Function to quick add this entry to the word lists selected in the settings
Future quickAddToWordList(JMdict entry, BuildContext context) async {

  // get all lists that currently still exist and that are selected
  List<int> allIDsInDB  = await GetIt.I<WordListsSQLDatabase>().getAllNodeIDs();
  List<int> selectedIDs = GetIt.I<Settings>().wordLists.quickAddListIDs
    .where((e) => allIDsInDB.contains(e))
    .toList();
  // if there are no lists selected, show a message to the user
  if(selectedIDs.isEmpty){
    await AwesomeDialog(
      // ignore: use_build_context_synchronously
      context: context,
      dialogType: DialogType.noHeader,
      btnOkColor: g_Dakanji_green,
      btnOkOnPress: () {
        
      },
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(LocaleKeys.DictionaryScreen_word_tab_menu_quick_add_to_list_no_lists_selected.tr()),
      ),
    ).show();
    return;
  }

  await GetIt.I<WordListsSQLDatabase>().addEntriesToWordLists(
    selectedIDs, [entry.id]);

}

/// Function to quick send this entry to anki
Future quickSendToAnki(JMdict entry, BuildContext context) async {

  if(!GetIt.I<UserData>().ankiSetup){
    await ankiNotSetupDialog(context).show();
  }
  else{
    addToAnki(entry, context, GetIt.I<Settings>().anki.allowDuplicates);
  }

}
