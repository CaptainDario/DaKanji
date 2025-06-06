// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:database_builder/database_builder.dart';

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
  /// Map of infos about kanjis without duplicates and their index in the kanji list
  late Map<String, int> kanjiInfos;
  /// Map of infos about readings without duplicates and their index in the reading list
  late Map<String, int> readingInfos;
  /// the text style to use for all words (kanji writing)
  TextStyle kanjiStyle = const TextStyle(
    fontSize: 30
  );
  /// the text style to use for all words (kanji writing) if there are multiple
  late TextStyle kanjiStyleSecondary = const TextStyle(
    fontSize: 24, color: Colors.grey
  );
  /// the text style to use for all readings
  late TextStyle readingStyle =const TextStyle(
    fontSize: 14,
    color: Colors.grey
  );
  
  /// A list of kana that are not mora on their own
  List<String> nonMora = ["ゃ", "ゅ", "ょ", "ャ", "ュ", "ョ"];
  /// List of pitch accent and if available info
  List<List<int>?> accents = [];
  /// the regex to find the accent pattern
  RegExp accentRegex = RegExp(r"(\d+)");


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
    hasKanji = widget.entry.kanjis.isNotEmpty;

    readingInfos = List<String>.from((widget.entry.readingInfo ?? [])
        .nonNulls.map((e) => e.attributes)
        .flattened.nonNulls.toSet().toList())
      .asMap().map((key, value) => MapEntry(value, key+1));

    kanjiInfos = List<String>.from((widget.entry.kanjiInfo ?? [])
        .nonNulls.map((e) => e.attributes)
        .flattened.nonNulls.toSet().toList())
      .asMap().map((key, value) => MapEntry(value, readingInfos.length+key+1));
  
    accents = [];
    for (var i = 0; i < widget.entry.readings.length; i++) {
      if(widget.entry.accents != null && widget.entry.accents![i] != null){
        accents.add([]);
        for (var j = 0; j < widget.entry.accents![i]!.attributes.length; j++) {
          int accentPattern = int.parse(
            accentRegex.allMatches(
              widget.entry.accents![i]!.attributes[j]!
            ).first.group(0)!
          );
          if(!accents[i]!.contains(accentPattern)) {
            accents[i]!.add(accentPattern);
          }
        }
      }
      else{
        accents.add(null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Wrap(
              children: [
                // kanjis and writings
                for (int i = 0; i < (hasKanji ? widget.entry.kanjis.length : 1); i++)
                  ...[
                    SizedBox(
                      width: i == 0 ? constraints.maxWidth : null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // first kanji writing + reading
                          Transform.translate(
                            offset: const Offset(0, 6),
                            child: Wrap(
                              children: [
                                for (int j = 0; j < widget.entry.readings.length; j++)
                                  if(widget.entry.readingRestriction == null ||
                                    widget.entry.readingRestriction![j] == null ||
                                    widget.entry.readingRestriction![j]!.attributes.contains(widget.entry.kanjis[i]))
                                      ...[
                                        // the reading
                                        SizedBox(
                                          width: j == 0 && !hasKanji ? constraints.maxWidth : null,
                                          child: SelectableText(
                                            widget.entry.readings[j],
                                            style: hasKanji
                                              ? readingStyle
                                              : j != 0 
                                                ? kanjiStyleSecondary
                                                : kanjiStyle
                                          ),
                                        ),
                                        // add superscript to indicate smth special with this reading
                                        if(widget.entry.readingInfo?[j] != null)
                                          Transform.translate(
                                            offset: const Offset(1, -7),
                                            child: Text(
                                              (readingInfos[widget.entry.readingInfo![j]!.attributes.join(", ")]).toString(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: hasKanji || j != 0 && !hasKanji
                                                  ? Colors.grey
                                                  : null
                                              )
                                            ),
                                          ),
                                        // add comma after each reading
                                        if(((j != 0 && !hasKanji) || hasKanji) && j != widget.entry.readings.length-1)
                                          Text("、",
                                            style: hasKanji
                                              ? readingStyle
                                              : j != 0 
                                                ? kanjiStyleSecondary
                                                : kanjiStyle
                                          )
                                      ],
                                ],
                              ),
                          ),
                          // additional kanjis + readings in grey and smaller
                          if(hasKanji)
                            SelectableText.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget.entry.kanjis[i],
                                    style: i == 0 ? kanjiStyle : kanjiStyleSecondary
                                  ),
                                  // kanji super script
                                  if(widget.entry.kanjiInfo != null && widget.entry.kanjiInfo![i] != null)
                                    for (String? info in widget.entry.kanjiInfo![i]!.attributes)
                                      if(info != null)
                                        WidgetSpan(
                                          child: Transform.translate(
                                            offset: const Offset(1, -18),
                                            child: SelectionContainer.disabled(
                                              child: Text(
                                                kanjiInfos[info].toString() +
                                                  (info == widget.entry.kanjiInfo![i]!.attributes.last
                                                    ? ""
                                                    : ","),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: i != 0 ? Colors.grey : null
                                                )
                                              ),
                                            ),
                                          )
                                        ),
                                  if(i != 0 && i != widget.entry.kanjis.length-1)
                                    TextSpan(
                                      text: "、",
                                      style: kanjiStyleSecondary
                                    ),
                                ]
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
              ],
            ),

            const SizedBox(height: 5,),

            // pitch accent
            // test: 川蝦, 結構, 誕生日, 上機嫌, 役所
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  ...() {
                    List<Widget> ret = [];

                    for (int i = 0; i < widget.entry.readings.length; i++){
                      if(accents[i] != null){
                        for (var a = 0; a < accents[i]!.length; a++){
                          String readingWoNonMora = 
                            widget.entry.readings[i].replaceAll(RegExp(nonMora.join("|")), "");
                          String reading = widget.entry.readings[i];

                          for (int r = 0; r < readingWoNonMora.length; r++){
                            int moraTillR = () {
                              int moraTillR = 0; int i = 0;
                              while (i-moraTillR < r){
                                if(nonMora.contains(reading[i])){
                                  moraTillR++;
                                }
                                i++;
                              }
                              return moraTillR;
                            } ();
                            ret.add(
                              Container(
                                decoration: getPitchAccentDecoration(
                                  accents[i]![a],
                                  readingWoNonMora,
                                  r 
                                ),
                                child: Text(
                                  readingWoNonMora[r] +
                                    (r+moraTillR+1 < reading.length && nonMora.contains(reading[r+moraTillR+1])
                                      ? reading[r+moraTillR+1]
                                      : ""),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey
                                  ),
                                ),
                              ),
                            );
                          }
                          // add "," to separate pitch readings
                          if(a < accents[i]!.length-1){
                            ret.add(const Text("、"));
                          }
                        }
                        // add "," to separate pitch readings
                        if(i < widget.entry.readings.length-1){
                          ret.add(const Text("、"));
                        }
                      }
                    }

                    return ret;
                  } ()
                ]
              ),
            ),
        
            const SizedBox(height: 5),
        
            // special information: 刺草 (re_inf & ke_inf), 然う言う (2x rei_inf), 真っ当 (2x ke_inf) 
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < readingInfos.length; i++)
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(0, -5),
                              child: SelectionContainer.disabled(
                                child: Text(
                                  "${readingInfos.values.toList()[i]} ",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey
                                  )
                                ),
                              )
                            )
                          ),
                          TextSpan(
                            text: ": ${readingInfos.keys.toList()[i]}",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey
                            )
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
                                offset: const Offset(0, -5),
                                child: Text(
                                  "${kanjiInfos.values.toList()[i]} ",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey
                                  )
                                )
                              )
                            ),
                            TextSpan(
                              text: ": ${kanjiInfos.keys.toList()[i]}",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                ]
              ),
            ),
            
          ],
        );
      }
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
    
    BorderSide empty = const BorderSide(
      color: Colors.transparent,
      width: 1.5,
      
    );
    BoxDecoration falling = BoxDecoration(
      border: Border(
        left: empty,
        top: const BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
        right: const BorderSide(
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
        right: const BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
        bottom: const BorderSide(
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
        bottom: const BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
      )
    );
    BoxDecoration high = BoxDecoration(
      border: Border(
        left: empty,
        top: const BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
        right: empty,
        bottom: empty
      )
    );


    // 平板 
    if(pitchAccent == 0){
      if(at == 0) {
        return rising;
      } else {
        return high;
      }
    }
    // 頭高
    else if(pitchAccent == 1 && 1 < reading.length){
      if(at == 0) {
        return falling;
      } else {
        return low;
      }
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
    else if(pitchAccent == reading.length){
      if(at == 0){
        if(reading.length == 1) {
          return falling;
        } else {
          return rising;
        }
      }
      else if(0 < at && at < reading.length-1) {
        return high;
      } else if(at == reading.length-1) {
        return falling;
      } else {
        return low;
      }
    }
    else {
      throw Exception("Invalid pitch accent");
    }
  }
}
