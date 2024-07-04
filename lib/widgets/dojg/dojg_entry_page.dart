// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:da_kanji_mobile/entities/dojg/dojg_search_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/dojg/dojg_entry.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_key_sentence_table.dart';

/// A page that shows all details about the given dojg entry
class DojgEntryPage extends StatefulWidget {

  /// The DoJG entry of this page
  final DojgEntry dojgEntry;
  /// Is this dojg entry page is a separate route or is side by side with the search
  final bool isSeparateRoute;
  /// Callback that is executed when the use taps on the back button of the 
  /// DoJG screen
  final Function()? onTapBack;


  const DojgEntryPage(
    this.dojgEntry,
    this.isSeparateRoute,
    {
      this.onTapBack,
      super.key
    }
  );

  @override
  State<DojgEntryPage> createState() => _DojgEntryPageState();
}

class _DojgEntryPageState extends State<DojgEntryPage> {

  int pointerCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onTapBack,
        ),
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
                "${GetIt.I<Settings>().misc.sharingScheme}dojg?search=${widget.dojgEntry.grammaticalConcept}&open=true",
                sharePositionOrigin: const Rect.fromLTWH(1, 1, 10, 10)
              );
            },
          ),
        ]
      ),
      body: Listener(
        onPointerDown: (event) {
          setState(() {
            pointerCount++;
          });
        },
        onPointerUp: (event) {
          setState(() {
            pointerCount--;
          });
        },
        onPointerCancel: (event) {
          setState(() {
            pointerCount--;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8 , 0),
          child: ListView(
            physics: pointerCount > 1
              ? const NeverScrollableScrollPhysics()
              : const ScrollPhysics(),
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
                                        context.read<DojgSearch>()
                                          .currentSearchTerm = exp
                                            // remove characters that break the search
                                            .replaceAll(RegExp(r"[\(|\)|\d]"), "")
                                            // remove excess whitespace
                                            .trim();
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
                    textScaler: const TextScaler.linear(1.25),
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
                    textScaler: const TextScaler.linear(1.5),
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
                    textScaler: const TextScaler.linear(1.5),
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
                    textScaler: const TextScaler.linear(1.5),
                  ),
                  children: [
                    GestureDetector(
                      onDoubleTap: () {
                        openDojgImageFullScreen();
                      },
                      child: InteractiveViewer(
                        panEnabled: true, // Set it to false
                        boundaryMargin: const EdgeInsets.all(100),
                        child: Image.file(File(
                          p.joinAll([g_DakanjiPathManager.dojgDirectory.path, widget.dojgEntry.noteImageName!])
                        )),
                      ),
                    )
                  ],
                )
            ],
          ),
        ),
      )
    );
  }

  void openDojgImageFullScreen(){
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.dojgEntry.grammaticalConcept)
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(100),
                minScale: 0.1,
                maxScale: 10,
                clipBehavior: Clip.none,
                child: Image.file(File(
                  p.joinAll([g_DakanjiPathManager.dojgDirectory.path, widget.dojgEntry.noteImageName!])
                )),
              ),
            ),
          ),
        );
      }
    ));
  }
}
