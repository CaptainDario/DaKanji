// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';

// Project imports:
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_word_card.dart';

/// A [DictionaryWordCard] that can be used to take a off-screen screenshot
class DictionaryWordCardScreenshot extends StatefulWidget {

  /// the dict entry that should be shown 
  final JMdict? entry;
  /// should the conjugation table be included in this widget
  final bool showConjugationTable;

  const DictionaryWordCardScreenshot(
    this.entry,
    this.showConjugationTable,
    {
      super.key
    }
  );

  @override
  State<DictionaryWordCardScreenshot> createState() => _DictionaryWordCardScreenshotState();
}

class _DictionaryWordCardScreenshotState extends State<DictionaryWordCardScreenshot> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: Theme(
        data: ThemeData.dark(),
        child: SizedBox(
          width: 500,
          child: DictionaryWordCard(
              widget.entry,
              showConjugationTable: widget.showConjugationTable,
              conjugationTableExpandable: false,
              showImageSearch: false,
            ),
          ),
      ),
    );
  }
}
