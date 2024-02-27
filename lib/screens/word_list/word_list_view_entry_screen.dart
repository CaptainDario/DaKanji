// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';

// Project imports:
import 'package:da_kanji_mobile/widgets/dictionary/dictionary.dart';

class WordListViewEntryScreen extends StatelessWidget {

  /// The JMdict entry to show
  final JMdict entry;

  const WordListViewEntryScreen(
    this.entry,
    {
      super.key
    }
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Dictionary(
        false,
        initialEntryId: entry.id,
        includeFallingWords: false,),
    );
  }
}
