// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/application/anki/anki.dart';
import 'package:da_kanji_mobile/entities/anki/anki_note.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/settings/settings_anki.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/settings/anki_settings_column.dart';

/// A dialog that allows to change the export to anki settings just this time.
/// `useAnkiSettings` defines if the settings of Anki are used or the settings
/// of exporting word lists
AwesomeDialog? ankiDialog(BuildContext context, JMdict entry) {

  return AwesomeDialog(
    context: context,
    useRootNavigator: false,
    autoDismiss: false,
    onDismissCallback: (type) {},
    dialogType: DialogType.noHeader,
    btnOkColor: g_Dakanji_green,
    btnOkText: LocaleKeys.DictionaryScreen_word_tab_menu_send_to_anki.tr(),
    btnOkOnPress: () {
      addToAnki(entry, context, GetIt.I<Settings>().anki.allowDuplicates);
      if(g_NavigatorKey.currentContext != null){
        Navigator.of(g_NavigatorKey.currentContext!).pop();
      }
    },
    btnCancelColor: g_Dakanji_red,
    btnCancelOnPress: () {
      Navigator.pop(context);
    },
    body: SingleChildScrollView(
      child: Column(
        children: [
          Text(
            LocaleKeys.WordListsScreen_send_to_anki.tr(),
            style: const TextStyle(
              fontSize: 24
            ),
          ),
          const SizedBox(height: 32,),
          ExpansionTile(
            title: Text(LocaleKeys.SettingsScreen_title.tr()),
            children: [
              AnkiSettingsColumn(GetIt.I<Settings>()),
            ],
          ),
          const SizedBox(height: 16,),
        ]
      )
    )
  );

}

/// Adds the given note to anki
void addToAnki(JMdict entry, BuildContext context, bool allowDuplicates) async {

  SettingsAnki ankiSettings = GetIt.I<Settings>().anki;

  List<String> langsToInclude = ankiSettings.langsToInclude(
      GetIt.I<Settings>().dictionary.selectedTranslationLanguages
    );

  AnkiNote note = AnkiNote.fromJMDict(
    GetIt.I<Settings>().anki.defaultDeck!,
    entry,
    langsToInclude: langsToInclude,
    translationsPerLang: ankiSettings.noTranslations,
    includeExample: true
  );

  // set example sentence
  await note.setExamplesFromDict(entry,
    langsToInclude: langsToInclude,
    includeTranslations: ankiSettings.includeExampleTranslations,
    numberOfExamples: ankiSettings.noExamples);

  // add the note to anki
  bool added = await GetIt.I<Anki>().addNote(note, allowDuplicates);

  if(!added){
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(
        LocaleKeys.ManualScreen_anki_test_connection_not_installed.tr()
      )),
    );
  }

}
