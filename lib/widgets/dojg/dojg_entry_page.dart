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
            if(widget.dojgEntry.formation != null)
              HtmlWidget(
                widget.dojgEntry.formation!
              )
          ],
        ),
      )
    );
  }
}