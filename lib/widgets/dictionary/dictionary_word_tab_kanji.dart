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
                          Text.rich(
                            TextSpan(
                              children: [
                                // the reading
                                WidgetSpan(
                                  child: Text(
                                    widget.entry.readings[j],
                                    style: readingStyle
                                  ),
                                ),
                                // add superscript to indicate smth special with this reading
                                if(widget.entry.readingInfo?[j] != null)
                                  WidgetSpan(
                                    child: Transform.translate(
                                      offset: const Offset(1, -7),
                                      child: SelectionContainer.disabled(
                                        child: Text(
                                          (readingInfos[widget.entry.readingInfo![j]!]).toString(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: hasKanji ? Colors.grey : null
                                          )
                                        ),
                                      ),
                                    ),
                                  ),
                                // add comma after each reading
                                WidgetSpan(
                                  child: SelectionContainer.disabled(
                                    child: Text(
                                      j != widget.entry.readings.length-1
                                        ? "、" : "",
                                      style: readingStyle
                                    ),
                                  ),
                                )
                              ]
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
          ),
          
          // pitch accent: 川蝦
          Row(
            children: [
              for (int i = 0; i < widget.entry.readings.length; i++)
                if(widget.entry.accents != null && widget.entry.accents![i] != null)
                  for (int a = 0; a < widget.entry.accents![i]!.split(",").length; a++)
                    ...[
                      for (int r = 0; r < widget.entry.readings[i].length; r++)
                        Container(
                          decoration: getPitchAccentDecoration(
                            int.parse(widget.entry.accents![i]!.split(",")[a]), 
                            widget.entry.readings[i],
                            r 
                          ),
                          child: Text(
                            widget.entry.readings[i][r],
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey
                            ),
                          ),
                        ),
                      if(i + a != widget.entry.readings.length-1 +
                        widget.entry.accents![i]!.split(",").length-1)
                        Text("、"),
                    ]
            ]
          ),
        ],
      ),
    );
  }

  /// Determines the pitchAccent BoxDecoration for a given `reading` at `at`
  /// using the `pitchAccent` information of the entry.
  /// Returns the decoration to use for the character at `at`.
  /// 
  /// pitch accent: <br/>
  /// 0 - 平板 <br/>
  /// 1 - 頭高 <br/>
  /// 1 < `pitchAccent` < `reading.length` - 中高 <br/>
  /// `pitchAccent` == `reading.length` - 尾高 <br/>
  BoxDecoration getPitchAccentDecoration(int pitchAccent, String reading, int at) {
    
    BorderSide empty = BorderSide(
      color: Colors.transparent,
      width: 1.5,
      
    );

    BoxDecoration falling = BoxDecoration(
      border: Border(
        left: empty,
        top: BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
        right: BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
        bottom: empty
      )
    );
    BoxDecoration rising = BoxDecoration(
      border: Border(
        left: empty,
        top: empty,
        right: BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
        bottom: BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
      )
    );    
    BoxDecoration low = BoxDecoration(
      border: Border(
        left: empty,
        top: empty,
        right: empty,
        bottom: BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
      )
    );
    BoxDecoration high = BoxDecoration(
      border: Border(
        left: empty,
        top: BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
        right: empty,
        bottom: empty
      )
    );

    // 平板 
    if(pitchAccent == 0){
      if(at == 0)
        return rising;
      else
        return high;
    }
    // 頭高
    else if(pitchAccent == 1 && 1 < reading.length){
      if(at == 0)
        return falling;
      else
        return low;
    }
    // 中高
    else if(1 < pitchAccent && pitchAccent < reading.length){
      if(at == 0){
        return rising;
      }
      else if (0 < at && at < pitchAccent-1){
        return high;
      }
      else if (at == pitchAccent-1){
        return falling;
      }
      else {
        return low;
      }
    }
    // 尾高
    else if(pitchAccent == reading.length)
      if(at == 0){
        if(reading.length == 1)
          return falling;
        else
          return rising;
      }
      else if(0 < at && at < reading.length-1)
        return high;
      else if(at == reading.length-1)
        return falling;
      else
        return low;
    else
      throw Exception("Invalid pitch accent");

  }
}