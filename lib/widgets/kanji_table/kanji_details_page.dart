import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:da_kanji_mobile/widgets/dictionary/kanji_card.dart';
import 'package:database_builder/database_builder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';





class KanjiDetailsPage extends StatefulWidget {

  /// The kanji that should be shown in this page
  final String kanji;

  const KanjiDetailsPage(
    this.kanji,
    {
      super.key
    }
  );

  @override
  State<KanjiDetailsPage> createState() => _KanjiDetailsPageState();
}

class _KanjiDetailsPageState extends State<KanjiDetailsPage> {

  late KanjiSVG kanjiSVG;

  late Kanjidic2 kanjidic2;


  @override
  void initState() {

    kanjidic2 = GetIt.I<Isars>().dictionary.kanjidic2s.where()
      .characterEqualTo(widget.kanji)
    .findAllSync().first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: DictionaryScreenKanjiCard(
                  kanjidic2,
                  const ["en"],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}