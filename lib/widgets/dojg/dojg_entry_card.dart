import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/domain/dojg/dojg_entry.dart';



class DojgEntryCard extends StatelessWidget {

  /// The DoJG entry of this widget
  final DojgEntry dojgEntry;


  const DojgEntryCard(
    this.dojgEntry,
    {
      super.key
    }
  );


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Card(
            child: InkWell(
              onTap: () {
                print(this.dojgEntry.grammaticalConcept);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      this.dojgEntry.grammaticalConcept,
                      textScaleFactor: 1.5,
                      style: TextStyle(
                        fontFamily: g_japaneseFontFamily
                      ),
                    ),
                    Text(
                      this.dojgEntry.usage ?? "",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: g_japaneseFontFamily
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
        ),
        Positioned(
          right: 6,
          top: 4,
          child: SelectableText(
            this.dojgEntry.volumeTag + this.dojgEntry.page.toString(),
            textScaleFactor: 1.25,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}