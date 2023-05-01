import 'package:database_builder/database_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';



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

  /// does this entry have kanji
  late bool hasKanji;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DictionaryWordTabKanji oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init(){
    hasKanji = !widget.entry.kanjis.isEmpty;
  }

  @override
  Widget build(BuildContext context) {

    /// the text style to use for all words
    TextStyle kanjiStyle = const TextStyle(
      fontSize: 30
    );

    /// the text style to use for all readings
    TextStyle readingStyle = hasKanji
      ? const TextStyle(
        fontSize: 14,
        color: Colors.grey
      )
      : kanjiStyle
    ;

    Map<String, int> readingInfos = List<String>.from((widget.entry.readingInfo ?? [])
        .where((e) => e != null)
        .toSet().toList())
      .asMap().map((key, value) => MapEntry(value, key+1));

    Map<String, int> kanjiInfos = List<String>.from((widget.entry.kanjiInfo ?? [])
        .where((e) => e != null && e != "")
        .toSet().toList())
      .asMap().map((key, value) => MapEntry(value, key+1+readingInfos.length));


    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // kanjis and writings
          for (int i = 0; i < (hasKanji ? widget.entry.kanjis.length : 1); i++)
            ...[
              // readings
              Transform.translate(
                offset: Offset(0, 6),
                child: Wrap(
                  children: [
                    for (int j = 0; j < widget.entry.readings.length; j++)
                      if(widget.entry.readingRestriction == null ||
                        widget.entry.readingRestriction![j] == null ||
                        widget.entry.readingRestriction![j]!.contains(widget.entry.kanjis[i]))
                        for (int k = 0; k < widget.entry.readings[j].length; k++)
                          Container(
                            // TODO pitch accent decoration
                            decoration: BoxDecoration(
                              border: widget.entry.accents != null &&
                                widget.entry.accents![j] != null &&
                                widget.entry.accents![j]!.contains((k+1).toString())
                              ? Border(
                                top: BorderSide(
                                  color: Colors.grey,
                                  width: 1.5,
                                ),
                                right: BorderSide(
                                  color: Colors.grey,
                                  width: 1.5,
                                ),
                              )
                              : null
                            ),
                            child: Text.rich(
                              TextSpan(
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
                                      child: SelectionContainer.disabled(
                                        child: Text(
                                          k == widget.entry.readings[j].length-1 &&
                                          widget.entry.readingInfo?[j] != null
                                            ? (readingInfos[widget.entry.readingInfo![j]!]).toString()
                                            : "",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: hasKanji ? Colors.grey : null
                                          )
                                        ),
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
              // kanjis in big font, if there are kanjis
              if(widget.entry.kanjis.isNotEmpty)
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < readingInfos.length; i++)
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Transform.translate(
                          offset: Offset(0, -5),
                          child: SelectionContainer.disabled(
                            child: Text(
                              "${readingInfos.values.toList()[i]} ",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey
                              )
                            ),
                          )
                        )
                      ),
                      TextSpan(
                        text: ": " + readingInfos.keys.toList()[i],
                        style: readingStyle
                      ),
                    ],
                  ),
                ),
              for (int i = 0; i < kanjiInfos.length; i++)
                SelectionContainer.disabled(
                  child: RichText(
                    text: TextSpan(
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
                  ),
                ),
            ]
          )
          
        ],
      ),
    );
  }
}