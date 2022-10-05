import 'package:flutter/material.dart';

import 'package:database_builder/src/jm_enam_and_dict_to_db/data_classes.dart' as Jmdict;




class DictionaryScreenWordTab extends StatefulWidget {
  DictionaryScreenWordTab(
    this.entry,
    {Key? key}
  ) : super(key: key);

  /// the dict entry that should be shown 
  final Jmdict.Entry? entry;


  @override
  State<DictionaryScreenWordTab> createState() => _DictionaryScreenWordTabState();
}

class _DictionaryScreenWordTabState extends State<DictionaryScreenWordTab> {

  /// the text style to use for all words
  TextStyle kanjiStyle = TextStyle(
    fontSize: 20
  );

  /// the text style to use for all readings
  TextStyle readingStyle = TextStyle(
    fontSize: 20
  );

  /// the text style to use for all partOfSpeech elementes
  TextStyle partOfSpeechStyle = TextStyle(
    fontSize: 12,
    color: Colors.blueGrey
  );

  TextStyle meaningsStyle = TextStyle(
    fontSize: 20
  );


  @override
  Widget build(BuildContext context) {
    if(widget.entry == null)
      return Container();
    else
      return SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // word
                    SelectableText(
                      widget.entry!.kanjis.length != 0 ?
                        widget.entry!.kanjis[0] : "",
                      style: kanjiStyle
                    ),
                    // word reading
                    Row(
                      children: 
                      [
                        ...List.generate(
                          widget.entry!.readings.length,
                          (index_1) => SelectionArea(
                            child: Row(
                              children:
                              [
                                ...List.generate(
                                  widget.entry!.readings[index_1].length,
                                  (index_2) => Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                      )
                                    ),
                                    child: Text (
                                      widget.entry!.readings[index_1][index_2],
                                      style: readingStyle
                                    ),
                                  ),
                                ),
                                SelectionContainer.disabled(
                                  child: Text(
                                    ", ",
                                    style: readingStyle,
                                  ),
                                )
                              ]
                            ),
                          )
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // part of speech
                    ...List.generate(widget.entry!.partOfSpeech.length, (index) =>
                      Text(
                        widget.entry!.partOfSpeech[index],
                        style: partOfSpeechStyle,
                      )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // meaning 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List.generate(
                          widget.entry!.meanings[0].meanings.length,
                          (int index) => Row(
                            children: [
                              Text(
                                "${(index+1).toString()}.",
                                style: meaningsStyle
                              ),
                              SelectableText(
                                "${widget.entry!.meanings[0].meanings[index]}",
                                style: meaningsStyle
                              ),
                            ],
                          )
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ExpansionTile(
                      title: Text("Images")
                    ),
                    ExpansionTile(
                      title: Text("Proverbs")
                    ),
                    ExpansionTile(
                      title: Text("Synonyms")
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      );
  }
}