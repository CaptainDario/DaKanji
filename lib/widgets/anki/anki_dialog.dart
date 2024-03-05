// Flutter imports:
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/settings/anki_settings_column.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/application/anki/anki.dart';
import 'package:da_kanji_mobile/entities/anki/anki_note.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/globals.dart';



/// A dialog that allows to change the export to anki settings just this time.
/// `useAnkiSettings` defines if the settings of Anki are used or the settings
/// of exporting word lists
AwesomeDialog ankiDialog(
  BuildContext context,
  JMdict entry,
) {

  // create a local settings object just for sending these notes to anki
  Settings s = Settings(isTemp: true)..load();

  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    btnOkColor: g_Dakanji_green,
    btnOkOnPress: () async {
      AnkiNote note = AnkiNote.fromJMDict(
        s.anki.defaultDeck!,
        entry,
        langsToInclude: s.anki.langsToInclude(
          GetIt.I<Settings>().dictionary.selectedTranslationLanguages
        ),
        translationsPerLang: s.anki.noTranslations
      );
      await GetIt.I<Anki>().addNote(note);
    },
    btnCancelColor: g_Dakanji_red,
    btnCancelOnPress: () { },
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
              AnkiSettingsColumn(s,),
            ],
          ),
          const SizedBox(height: 16,),
        ]
      )
    )
  );

}
