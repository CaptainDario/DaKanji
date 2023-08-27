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
            // formation ie. conjugation / usage
            if(widget.dojgEntry.formation != null)
              ...[
                Text("Formation", textScaleFactor: 1.5,),
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
                Text("Key sentences", textScaleFactor: 1.5,),
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
                Text("Examples", textScaleFactor: 1.5,),
                const SizedBox(height: 5,),
                DojgSentenceTable(
                  widget.dojgEntry.examplesJp.map((e) => 
                    e.replaceAll(RegExp(r'<span class="green".*?n>'), "")
                  ).toList(),
                  widget.dojgEntry.examplesEn
                )
              ],

            // small margin at the end of the list
            const SizedBox(height: 8,)
          ],
        ),
      )
    );
  }
}