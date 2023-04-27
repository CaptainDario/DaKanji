import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:database_builder/database_builder.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_progress_indicator.dart';
import 'package:da_kanji_mobile/application/wikipedia/wikipedia_api.dart';
import 'package:da_kanji_mobile/data/iso/iso_table.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/widgets/dictionary/meanings_grid.dart';
import 'package:url_launcher/url_launcher_string.dart';



class WordMeanings extends StatefulWidget {
  
  /// The entry of which the meanings should be shown
  final JMdict entry;
  /// The style to aply to the meanings
  final TextStyle meaningsStyle;
  /// Whether to include the wikipedia definition
  final bool includeWikipediaDefinition;

  const WordMeanings(
    {
      required this.entry,
      required this.meaningsStyle,
      this.includeWikipediaDefinition = false,
      super.key
    }
  );

  @override
  State<WordMeanings> createState() => _WordMeaningsState();
}

class _WordMeaningsState extends State<WordMeanings> {

  // did the user expand the wikipedia entries
  Map<String, bool> wikiExpanded = Map.fromIterable(
    GetIt.I<Settings>().dictionary.selectedTranslationLanguages,
    key: (lang) => lang, 
    value: (value) => false,
  );

  Future<String>? wikipediaRequest;

  Map<String, String> wikipediaSummary = {};


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      // create the children in the same order as in the settings
      children: [
        ...GetIt.I<Settings>().dictionary.selectedTranslationLanguages.map((lang) {
        
          List<Widget> ret = [];

          // get the meaning of the selected language
          List<LanguageMeanings> meanings = widget.entry.meanings.where(
            (element) => isoToiso639_1[element.language]!.name == lang
          ).toList();
          
          if(!wikipediaSummary.containsKey(lang)){
            wikipediaRequest = getWikipediaDefinition(
              // for japanese words, use the kanji/kana, otherwise the first meaning
              lang == "ja"
                ? widget.entry.kanjis.length > 0 ? widget.entry.kanjis.first : widget.entry.readings.first
                : meanings.first.meanings!.first.split("⬜").first,
              lang
            ).then<String>((value) {
              setState(() {
                wikipediaSummary[lang] = value;
              });
              return value;
            });
          }
          
          // language flag
          if(meanings.isNotEmpty || wikipediaSummary != "" && wikipediaSummary != null)
            ret.add(
              Row(
                children: [
                  SizedBox(
                    height: 10,
                    width: 10,
                    child: SvgPicture.asset(
                      GetIt.I<Settings>().dictionary.translationLanguagesToSvgPath[lang]!
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    isoToLanguage[isoToiso639_1[lang]]!
                  )
                ],
              ),
            );
          // add the meanings
          if(meanings.isNotEmpty)
            ret.add(
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
                child: Column(
                  children: [
                    MeaningsGrid(
                      meanings: meanings.first.meanings!,
                      style: widget.meaningsStyle,
                      limit: 5,
                    ),
                  ],
                ),
              )
            );
          // add the wikipedia definition
          if(this.widget.includeWikipediaDefinition)
            ret.add(
              FutureBuilder(
                future: wikipediaRequest,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done &&
                    wikipediaSummary[lang] != "" && wikipediaSummary[lang] != null)
                    return Column( 
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.DictionaryScreen_word_wikipedia.tr(),
                          style: TextStyle(
                            fontSize: 14
                          ),
                        ),
                        SizedBox(height: 10,),
                        if(wikipediaSummary[lang]!.length < 400 || wikiExpanded[lang]!)
                          HtmlWidget(
                            wikipediaSummary[lang]!.toString(),
                            
                            onTapUrl: (p0) {
                              launchUrlString(p0);
                              return false;
                            },
                          ),
                        if(wikipediaSummary[lang]!.length >= 400)
                          HtmlWidget(
                            wikipediaSummary[lang]!.toString().substring(0, 400) + "<a href='...'>...</a>",
                            
                            onTapUrl: (p0) {
                              if(p0 == "...")
                                setState(() {
                                  wikiExpanded[lang] = true;
                                });
                              else
                                launchUrlString(p0);
                              return true;
                            },
                          ),
                      ]
                    );
                  else if(snapshot.connectionState == ConnectionState.done &&
                    snapshot.data == "")
                    return Container();
                  else
                    return Center(child: const DaKanjiProgressIndicator());
                },
              )
            );
          ret.add(SizedBox(height: 20,));

          return ret;
        }).expand((element) => element).toList(),

      ]
    );
  }
}