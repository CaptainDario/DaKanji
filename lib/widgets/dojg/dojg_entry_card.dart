// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/domain/dojg/dojg_entry.dart';
import 'package:da_kanji_mobile/globals.dart';

class DojgEntryCard extends StatelessWidget {

  /// The DoJG entry of this widget
  final DojgEntry dojgEntry;
  /// Callback that is called when the user taps on this card. provides
  /// the `this.dojgEntry` as parameter
  final Function(DojgEntry entry)? onTap;


  const DojgEntryCard(
    this.dojgEntry,
    {
      this.onTap,
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
              onTap: () => onTap?.call(dojgEntry),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Text(
                      dojgEntry.grammaticalConcept,
                      textScaleFactor: 1.5,
                      style: const TextStyle(
                        fontFamily: g_japaneseFontFamily
                      ),
                    ),
                    Text(
                      dojgEntry.usage ?? "",
                      style: const TextStyle(
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
            dojgEntry.volumeTag + dojgEntry.page.toString(),
            textScaleFactor: 1.25,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
