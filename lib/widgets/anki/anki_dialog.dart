// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:collection/collection.dart';
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/application/anki/anki.dart';
import 'package:da_kanji_mobile/entities/anki/anki_note.dart';
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/globals.dart';

AwesomeDialog ankiDialog(BuildContext context, JMdict entry) {

  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    btnOkColor: g_Dakanji_green,
    btnOkOnPress: () async {
      AnkiNote note = AnkiNote.fromJMDict(
        GetIt.I<Settings>().anki.defaultDeck!,
        entry,
        langsToInclude: GetIt.I<Settings>().anki.includedLanguages.mapIndexed(
          (index, element) => element 
            ? isoToiso639_2B[
                GetIt.I<Settings>().dictionary.translationLanguageCodes[index]
              ]!.name
            : null
        ).whereNotNull().toList(),
        translationsPerLang: GetIt.I<Settings>().anki.noTranslations
      );
      await GetIt.I<Anki>().addNote(note);
    },
    btnCancelColor: g_Dakanji_red,
    btnCancelOnPress: () {
      
    },
    body: const SingleChildScrollView(
      child: Column(
        children: [
          Text("send")
        ]
      )
    )
  );

}
