// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';

// Project imports:
import 'package:da_kanji_mobile/application/anki/anki.dart';
import 'package:da_kanji_mobile/domain/anki/anki_note.dart';
import 'package:da_kanji_mobile/globals.dart';

AwesomeDialog AnkiDialog(BuildContext context) {

  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    btnOkColor: g_Dakanji_green,
    btnOkOnPress: () {
      AnkiNote note = AnkiNote.testNote();
      addNote(note);
    },
    btnCancelColor: g_Dakanji_red,
    btnCancelOnPress: () {
      
    },
    body: SingleChildScrollView(
      child: Column(
        children: [
          Text("send")
        ]
      )
    )
  );

}
