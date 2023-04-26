import 'package:database_builder/database_builder.dart';
import 'package:flutter/material.dart';



class DictionaryWordTabKanji extends StatefulWidget {


  /// the dict entry that should be shown
  final JMdict entry;

  const DictionaryWordTabKanji(
    this.entry,
    {
      super.key
    }
  );

  @override
  State<DictionaryWordTabKanji> createState() => _DictionaryWordTabKanjiState();
}

class _DictionaryWordTabKanjiState extends State<DictionaryWordTabKanji> {
  @override
  Widget build(BuildContext context) {

    /// the text style to use for all words
    TextStyle kanjiStyle = const TextStyle(
      fontSize: 30
    );

    /// the text style to use for all readings
    TextStyle readingStyle = const TextStyle(
      fontSize: 14,
      color: Colors.grey
    );

    Map<String, int> readingInfos = List<String>.from((widget.entry.readingInfo ?? [])
        .where((e) => e != null)
        .toSet().toList())
      .asMap().map((key, value) => MapEntry(value, key+1));

    Map<String, int> kanjiInfos = List<String>.from((widget.entry.kanjiInfo ?? [])
        .where((e) => e != null && e != "")
        .toSet().toList())
      .asMap().map((key, value) => MapEntry(value, key+1+readingInfos.length));


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // kanjis and writings
        for (int i = 0; i < widget.entry.kanjis.length; i++)
          ...[
            Transform.translate(
              offset: Offset(0, 6),
              child: SelectionArea(
                child: Wrap(
                  children: [
                    for (int j = 0; j < widget.entry.readings.length; j++)
                      if(widget.entry.readingRestriction == null ||
                        widget.entry.readingRestriction![j] == null ||
                        widget.entry.readingRestriction![j]!.contains(widget.entry.kanjis[i]))
                        for (int k = 0; k < widget.entry.readings[j].length; k++)
                          Container(
                            decoration: const BoxDecoration(
                              // TODO: pitch accent - @ DaKanji v3.4
                              //border: Border(right: BorderSide(color: Colors.white,width: 1.5,),)
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  // the reading
                                  TextSpan(
                                    text: widget.entry.readings[j][k],
                                    style: readingStyle
                                  ),
                                  // add superscript to indicate smth special with this reading
                                  WidgetSpan(
                                    child: Transform.translate(
                                      offset: const Offset(1, -7),
                                      child: Text(
                                        k == widget.entry.readings[j].length-1 &&
                                        widget.entry.readingInfo?[j] != null
                                          ? (readingInfos[widget.entry.readingInfo![j]!]).toString()
                                          : "",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey
                                        )
                                      ),
                                    ),
                                  ),
                                  // add comma after each reading
                                  TextSpan(
                                    text: j != widget.entry.readings.length-1 &&
                                    k == widget.entry.readings[j].length-1
                                      ? "、" : "",
                                    style: readingStyle
                                  ),
                                ]
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: widget.entry.kanjis[i],
                    style: kanjiStyle
                  ),
                  for (String info in widget.entry.kanjiInfo![i]!.split("⬜"))
                    if(info != "")
                      WidgetSpan(
                        child: Transform.translate(
                          offset: Offset(1, -18),
                          child: Text(
                            kanjiInfos[info].toString() +
                              (info == widget.entry.kanjiInfo![i]!.split("⬜").last
                                ? ""
                                : ","),
                          ),
                        )
                      )
                ]
              )
            )
          ],
        
        // special information
        RichText(
          text: TextSpan(
            children: [
              for (int i = 0; i < readingInfos.length; i++)
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Transform.translate(
                        offset: Offset(0, -5),
                        child: Text(
                          "${readingInfos.values.toList()[i]} ",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey
                          )
                        )
                      )
                    ),
                    TextSpan(
                      text: ": " + readingInfos.keys.toList()[i],
                      style: readingStyle
                    ),
                  ],
                ),
              for (int i = 0; i < kanjiInfos.length; i++)
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Transform.translate(
                        offset: Offset(0, -5),
                        child: Text(
                          "${kanjiInfos.values.toList()[i]} ",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey
                          )
                        )
                      )
                    ),
                    TextSpan(
                      text: ": " + kanjiInfos.keys.toList()[i],
                      style: readingStyle
                    ),
                  ],
                ),
            ]
          )
        ),
      ],
    );
  }
}