import 'package:flutter/material.dart';

import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:da_kanji_mobile/domain/dojg/dojg_entry.dart';



/// A page that shows all details about the given dojg entry
class DojgEntryPage extends StatefulWidget {

  final DojgEntry dojgEntry;

  const DojgEntryPage(
    this.dojgEntry,
    {
      super.key
    }
  );

  @override
  State<DojgEntryPage> createState() => _DojgEntryPageState();
}

class _DojgEntryPageState extends State<DojgEntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(widget.dojgEntry.grammaticalConcept)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            Text(
              "${widget.dojgEntry.volumeTag} ${widget.dojgEntry.grammaticalConcept}",
              textScaleFactor: 2.0,
              style: const TextStyle(
                
              ),
            ),
            const SizedBox(height: 16,),
            // fomration ie. conjugation / usage
            if(widget.dojgEntry.formation != null)
              ...[
                Text(
                  "Formation",
                  textScaleFactor: 1.5,
                ),
                const SizedBox(height: 8,),
                HtmlWidget(
                  widget.dojgEntry.formation!
                )
              ],

            // key sentences
            if(widget.dojgEntry.examplesEn.isNotEmpty)
              ...[
                const SizedBox(height: 10,),
                Text(
                  "Key sentences",
                  textScaleFactor: 1.5,
                ),
                const SizedBox(height: 8,),
                for (int i = 0; i < widget.dojgEntry.keySentencesEn.length; i++)
                  ...[
                    HtmlWidget(widget.dojgEntry.keySentencesJp[i]),
                    Row(
                      children: [
                        const Text(
                          "(ksa).　",
                          style: TextStyle(color: Colors.transparent),
                        ),
                        Flexible(
                          child: Text(
                            widget.dojgEntry.keySentencesEn[i],
                            style: const TextStyle(
                              color: Colors.grey
                            ),
                          ),
                        ),
                      ],
                    ),
                    // after each ks pair (except last one) put a small margin
                    if(i != widget.dojgEntry.keySentencesEn.length-1)
                      const SizedBox(height: 4,)
                  ]
              ],

            // examples
          ],
        ),
      )
    );
  }
}