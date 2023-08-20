import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:da_kanji_mobile/domain/navigation_arguments.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:tuple/tuple.dart';



/// `LayouGrid` structured to show a list of meanings with a count
class MeaningsGrid extends StatefulWidget {
  
  /// The style to be used for the text
  final TextStyle style;
  /// A list of meanings that should be shown
  final LanguageMeanings meanings;
  /// An offset that should used when showing the meanings
  final int countOffset;
  /// A limit of meanings that should be shown in this grid
  final int limit;

  const MeaningsGrid(
    {
      required this.meanings,
      required this.style,
      this.countOffset = 0,
      this.limit = 0,
      super.key
    }
  );

  @override
  State<MeaningsGrid> createState() => _MeaningsGridState();
}

class _MeaningsGridState extends State<MeaningsGrid> {

  /// if there are more than `widet.limit` meanings, should they be shown
  bool showAllMeanings = false;
  /// all related entries
  List<List<JMdict?>?> relatedEntries = [];
  /// all antonym entries
  List<List<JMdict?>?> antonymEntries = []; 
  /// the text style to use for the information texts
  TextStyle informationStyle = TextStyle(
    color: Colors.grey[600],
    fontSize: 14
  );

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void didUpdateWidget(covariant MeaningsGrid oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init(){
    relatedEntries = []; antonymEntries = [];
    
    // get all related entries (xref) and antonym entries (ant) from isar
    for (var pair in [Tuple2(widget.meanings.xref, relatedEntries), Tuple2(widget.meanings.antonyms, antonymEntries)]){
      var e = pair.item1, entries = pair.item2;
      if(e != null){
        for (var i = 0; i < e.length; i++) {
          if(e[i] != null){
            entries.add([]);
            for (var j = 0; j < e[i]!.attributes.length; j++) {
              entries[i]!.add(GetIt.I<Isars>().dictionary.jmdict.getSync(
                int.parse(e[i]!.attributes[j]!)
              ));
            }
          }
          else{
            entries.add(null);
          }
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    /// the lenght of this meanings table (how many rows)
    int tableLength = showAllMeanings ?
      widget.meanings.meanings.length : 
      min(widget.meanings.meanings.length, 5);
    /// should the 'show more'-button be there
    int hide = widget.meanings.meanings.length > 5 && !showAllMeanings ? 1 : 0;
    
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      alignment: Alignment.topCenter,
      child: LayoutGrid(
        gridFit: GridFit.loose,
        columnGap: 10,
        rowGap: 5,
        columnSizes: [auto, 0.95.fr],
        rowSizes: List.generate(tableLength + hide, (index) => auto),
        children: () {
          // one meaning row of the table 
          List<Widget> ret = [];
          for (int j = 0; j < tableLength; j++) {
            // the number of this meaning
            ret.add(
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "${(j+1).toString()}. ",
                  style: const TextStyle(
                    color: Colors.grey
                  )
                ),
              ),
            );
            // additional information for this entry
            ret.add(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // the actual meaning
                  SelectableText(
                    widget.meanings.meanings[j].attributes.join(", "),
                    style: widget.style
                  ),
                  // refernces, ex.: 悪どい, アメラグ
                  if(widget.meanings.xref != null && widget.meanings.xref![j] != null)
                    RichText(
                      text: TextSpan(
                        text: "${LocaleKeys.DictionaryScreen_word_see_also.tr()} ",
                        style: informationStyle,
                        children: [
                          for (int i = 0; i < relatedEntries[j]!.length; i++)
                            if(relatedEntries[j] != null)
                              TextSpan(
                                text: (relatedEntries[j]![i]!.kanjis.isEmpty
                                  ? relatedEntries[j]![i]!.readings.first
                                  : relatedEntries[j]![i]!.kanjis.first)
                                  + (i < relatedEntries[j]!.length - 1
                                    ? ", "
                                    : ""),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      int id = int.parse(widget.meanings.xref![j]!.attributes[i]!);
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        "/dictionary",
                                        (route) => false,
                                        arguments: NavigationArguments(
                                          false,
                                          initialEntryId: id
                                        )
                                      );
                                    },
                              )
                        ]
                      ),
                    ),
                  // antonyms: 空車
                  if(widget.meanings.antonyms != null && widget.meanings.antonyms![j] != null)
                    RichText(
                      text: TextSpan(
                        text: "${LocaleKeys.DictionaryScreen_word_antonyms.tr()} ",
                        style: informationStyle,
                        children: [
                          for (int i = 0; i < antonymEntries[j]!.length; i++)
                            if(antonymEntries[j] != null)
                              TextSpan(
                                text: (antonymEntries[j]![i]!.kanjis.isEmpty
                                  ? antonymEntries[j]![i]!.readings.first
                                  : antonymEntries[j]![i]!.kanjis.first)
                                  + (i < antonymEntries[j]!.length - 1
                                    ? ", "
                                    : ""),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      int id = int.parse(widget.meanings.antonyms![j]!.attributes[i]!);
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        "/dictionary",
                                        (route) => false,
                                        arguments: NavigationArguments(
                                          false,
                                          initialEntryId: id
                                        )
                                      );
                                    },
                              )
                        ]
                      ),
                    ),
                  // kanji targets: １つ星
                  if(widget.meanings.senseKanjiTarget != null && widget.meanings.senseKanjiTarget![j] != null)
                    Text(
                      "${LocaleKeys.DictionaryScreen_word_restricted_to.tr()} ${widget.meanings.senseKanjiTarget![j]!.attributes.join(",")}",
                      style: informationStyle,
                    ),
                  // reading targets: 空車
                  if(widget.meanings.senseReadingTarget != null && widget.meanings.senseReadingTarget![j] != null)
                    Text(
                      "${LocaleKeys.DictionaryScreen_word_restricted_to.tr()} ${widget.meanings.senseReadingTarget![j]!.attributes.join(",")}",
                      style: informationStyle,
                    ),
                  // field of usage: 一尉
                  if(widget.meanings.field != null && widget.meanings.field![j] != null)
                    Text(
                      "${LocaleKeys.DictionaryScreen_word_field.tr()} ${widget.meanings.field![j]!.attributes.join(",")}",
                      style: informationStyle,
                    ),
                  // source language of gairaigo: 金平糖
                  if(widget.meanings.source != null && widget.meanings.source![j] != null)
                    Text(
                      "${LocaleKeys.DictionaryScreen_word_source_language.tr()} ${widget.meanings.source![j]!.attributes.join(",")}",
                      style: informationStyle,
                    ),
                  // dialect where this word is used: 賢い
                  if(widget.meanings.dialect != null && widget.meanings.dialect![j] != null)
                    Text(
                      "${LocaleKeys.DictionaryScreen_word_field.tr()} ${widget.meanings.dialect![j]!.attributes.join(",")}",
                      style: informationStyle,
                    ),
                  // additional information for about this sense: 表す
                  if(widget.meanings.senseInfo != null && widget.meanings.senseInfo![j] != null)
                    Text(
                      "${LocaleKeys.DictionaryScreen_word_info.tr()} ${widget.meanings.senseInfo![j]!.attributes.join(",")}",
                      style: informationStyle,
                    ),
                  // Part of Speech: 食べる
                  if(widget.meanings.partOfSpeech != null && widget.meanings.partOfSpeech![j] != null)
                    Text(
                      widget.meanings.partOfSpeech![j]!.attributes.join(","),
                      style: informationStyle,
                    ),
                ],
              ),
            );
          }
          // show more button
          if(hide == 1) {
            ret.add(
              InkWell(
                onTap: () {
                  setState(() {
                    showAllMeanings = !showAllMeanings;
                  });
                },
                child: Row(
                  children: [
                    const Icon(Icons.expand_more),
                    const SizedBox(width: 10,),
                    Text(LocaleKeys.DictionaryScreen_word_meanings_more.tr())
                  ],
                )
              ).withGridPlacement(columnSpan: 2)
            );
          }
          
          return ret;
        } ()
      ),
    );
  }
}