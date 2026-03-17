import 'dart:async';

import 'package:da_db/database/term/term_bank_v3_entry.dart';
import 'package:da_db/util/data_converters/string_extensions.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/tag/tag_widget.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/term/term_bank_definition_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_util/widgets/cut_and_fade_long_widget_wrapper.dart';


class TermBankDefinitionsWidget extends StatefulWidget {

  /// The term bank entries to display 
  final List<TermBankV3Entry> entries;
  /// Max height for the definitions section. 0 = unlimited.
  final double definitionsMaxHeight;

  /// Whether to render in compact mode (term bank entries in one line)
  final bool compactMode;

  /// Callback that is called when a URL is tapped.
  /// Should return true if the URL was handled.
  final FutureOr<bool> Function(String url)? onTapUrl;

  const TermBankDefinitionsWidget(
    this.entries,
    {
      this.definitionsMaxHeight = 0,
      this.compactMode = false,
      this.onTapUrl,
      super.key
    }
  );

  @override
  State<TermBankDefinitionsWidget> createState() => _TermBankDefinitionsWidgetState();
}

class _TermBankDefinitionsWidgetState extends State<TermBankDefinitionsWidget> {

  List<TermBankV3Entry> entriesToShow = [];

  @override
  void initState() {
    super.initState();

    // filter out duplicate entries in the group list
    for (final entry in widget.entries) {
      if (entriesToShow.any((existing) =>
        existing.compareToGroupEntry(entry))
      ) {
        continue;
      }
      entriesToShow.add(entry);
    }
  }

  @override
  Widget build(BuildContext context) {

    return CutAndFadeLongWidgetWrapper(
      maxContentHeight: widget.definitionsMaxHeight,
      enabled: widget.definitionsMaxHeight > 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < entriesToShow.length; i++) 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity, // make sure the wrap uses the full width
                  child: Row(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // numbering for each entry (1., 2. etc)
                      Text(
                        '${i + 1}. ',
                        style: const TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      // the rule identifiers for this definition
                      Expanded(
                        child: Wrap(
                          spacing: 2,
                          runSpacing: 4,
                          children: [
                            for (final definitionTag in entriesToShow[i].definitionTags)
                              DictionaryMatchTag(
                                texts: [definitionTag.name],
                                details: definitionTag.notes.nullIfEmptyOrNull
                              ),
                            // the index from which this definitions comes
                            DictionaryMatchTag(
                              texts: [entriesToShow[i].indexEntry.title],
                              details: entriesToShow[i].indexEntry.description.nullIfEmptyOrNull,
                              textColors: [Colors.grey],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4,),
                // the actual definitions (structured content or not)
                TermBankDefinitionWidget(
                  definitions: entriesToShow[i].structuredContentDefinitions,
                  indexId: entriesToShow[i].indexEntry.id,
                  onTapUrl: widget.onTapUrl,
                  compactMode: widget.compactMode,
                ),
                if(i != entriesToShow.length - 1)
                  const SizedBox(height: 4,),
              ],
            ),
        ],
      ),
    );
  }

}

