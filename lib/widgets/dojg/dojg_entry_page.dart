// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:path/path.dart' as p;
import 'package:easy_localization/easy_localization.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/application/dojg/dojg_search_provider.dart';
import 'package:da_kanji_mobile/domain/dojg/dojg_entry.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_key_sentence_table.dart';

/// A page that shows all details about the given dojg entry
class DojgEntryPage extends ConsumerStatefulWidget {

  /// The DoJG entry of this page
  final DojgEntry dojgEntry;
  /// Is this dojg entry page is a separate route or is side by side with the search
  final bool isSeparateRoute;

  const DojgEntryPage(
    this.dojgEntry,
    this.isSeparateRoute,
    {
      super.key
    }
  );

  @override
  ConsumerState<DojgEntryPage> createState() => _DojgEntryPageState();
}

class _DojgEntryPageState extends ConsumerState<DojgEntryPage> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "${widget.dojgEntry.volumeTag} ${widget.dojgEntry.grammaticalConcept} (${widget.dojgEntry.page})"
          )
        ),
        actions: [ 
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              await Share.share(
                "https://dakanji.app/app/dojg?id=${1}"
              );
            },
          ),
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8 , 0),
        child: ListView(
          children: [

            const SizedBox(height: 16,),
            if(widget.dojgEntry.usage != null)
              Text(widget.dojgEntry.usage!),

            if([widget.dojgEntry.antonymExpression,
              widget.dojgEntry.relatedExpression,
              widget.dojgEntry.equivalent,
              widget.dojgEntry.pos].any((e) => e != null))
              ...[
                const SizedBox(height: 8,),
                LayoutGrid(
                  columnSizes: [auto, 1.fr],
                  rowSizes: const [auto, auto, auto, auto],
                  children: [
                    if(widget.dojgEntry.antonymExpression != null)
                      ...[
                        Text(
                          LocaleKeys.DojgScreen_dojg_antonym.tr(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          widget.dojgEntry.antonymExpression!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    if(widget.dojgEntry.relatedExpression != null)
                      ...[
                        Text(
                          LocaleKeys.DojgScreen_dojg_related.tr(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Wrap(
                          children: [
                            for (String exp in widget.dojgEntry.relatedExpression!
                              .replaceAll("【Related Expression: ", "")
                              .replaceAll("】", "").split(";")
                            )
                              RichText(
                                text: TextSpan(
                                  text: "$exp   ",
                                  recognizer: TapGestureRecognizer()..onTap = (
                                    () {
                                      ref.read(dojgSearchProvider.notifier)
                                        .setCurrentSearchTerm(exp
                                            // remove characters that break the search
                                            .replaceAll(RegExp(r"[\(|\)|\d]"), "")
                                            // remove excess whitespace
                                            .trim()
                                        );
                                      if(widget.isSeparateRoute){
                                        Navigator.of(context).pop();
                                      }
                                    }
                                  )
                                ),
                              )
                          ],
                        ),
                      ],
                    if(widget.dojgEntry.equivalent != null)
                      ...[
                        Text(
                          LocaleKeys.DojgScreen_dojg_eng_equivalent.tr(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          widget.dojgEntry.equivalent!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    if(widget.dojgEntry.pos != null)
                      ...[
                        Text(
                          LocaleKeys.DojgScreen_dojg_pos.tr(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          widget.dojgEntry.pos!,
                          style: const TextStyle(color: Colors.grey), 
                        ),
                      ],
                  ],
                ),
                const SizedBox(height: 16,),
              ],

            // formation ie. conjugation / usage
            if(widget.dojgEntry.formation != null)
              ...[
                Text(
                  LocaleKeys.DojgScreen_dojg_formation.tr(),
                  textScaleFactor: 1.25,
                ),
                HtmlWidget(
                  widget.dojgEntry.formation!,
                  customStylesBuilder: (element) {
                    if (element.classes.contains('concept')) {
                      return {'font-weight': 'bold'};
                    }
                    return null;
                  },
                  textStyle: const TextStyle(
                    fontFamily: g_japaneseFontFamily
                  ),
                )
              ],

            // key sentences
            if(widget.dojgEntry.keySentencesEn.isNotEmpty)
              ...[
                const SizedBox(height: 10,),
                Text(
                  LocaleKeys.DojgScreen_dojg_key_sentences.tr(),
                  textScaleFactor: 1.5
                ),
                const SizedBox(height: 5,),
                DojgSentenceTable(
                  widget.dojgEntry.keySentencesJp.map((e) => 
                    e.replaceAll(RegExp(r'<span class="green".*?n>'), "")
                  ).toList(),
                  widget.dojgEntry.keySentencesEn
                )
              ],
            // examples
            if(widget.dojgEntry.examplesEn.isNotEmpty)
              ...[
                const SizedBox(height: 10,),
                Text(
                  LocaleKeys.DojgScreen_dojg_examples.tr(),
                  textScaleFactor: 1.5,
                ),
                const SizedBox(height: 5,),
                DojgSentenceTable(
                  widget.dojgEntry.examplesJp.map((e) => 
                    e.replaceAll(RegExp(r'<span class="green".*?n>'), "")
                  ).toList(),
                  widget.dojgEntry.examplesEn
                )
              ],

            // small margin at the end of the list
            const SizedBox(height: 8,),

            if(widget.dojgEntry.noteImageName != null)
              ExpansionTile(
                title: Text(
                  LocaleKeys.DojgScreen_dojg_image.tr(),
                  textScaleFactor: 1.5,
                ),
                children: [
                  Image.file(File(
                    p.joinAll([g_documentsDirectory.path, "DaKanji", "dojg", widget.dojgEntry.noteImageName!])
                  ))
                ],
              )
          ],
        ),
      )
    );
  }
}
