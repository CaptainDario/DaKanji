// Flutter imports:
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

AwesomeDialog ankiDialog(BuildContext context, JMdict entry) {

  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    btnOkColor: g_Dakanji_green,
    btnOkOnPress: () {
      AnkiNote note = AnkiNote(
        GetIt.I<Settings>().anki.defaultDeck!,
        ["test", "test"],
        entry.kanjis,
        "",
        "",
        ""
      );
      GetIt.I<Anki>().addNote(note);
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
