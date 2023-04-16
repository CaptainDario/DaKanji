import 'package:da_kanji_mobile/helper/anki/anki_note.dart';
import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/helper/anki/anki.dart';




/// The manual for the TextScreen
class ManualAnki extends StatelessWidget {
  ManualAnki({super.key});

  final String manualAnkiText = "";


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Anki manual"),
          TextButton(
            onPressed: () {
              AnkiNote note = AnkiNote.testNote();
              addNote(note);
            },
            child: Text("Test Anki connection"),
          )
        ],
      ),
    );
  }
}