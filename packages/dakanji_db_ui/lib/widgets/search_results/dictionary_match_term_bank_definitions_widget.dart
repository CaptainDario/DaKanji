import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';
import 'package:dakanji_db_core/helper/string_extensions.dart';
import 'package:dakanji_db_ui/widgets/search_results/dictionary_match_tag.dart';
import 'package:dakanji_db_ui/widgets/search_results/dictionary_match_term_bank_definition_widget.dart';
import 'package:dakanji_util/widgets/cut_and_fade_long_widget_wrapper.dart';
import 'package:flutter/material.dart';


class DictionaryMatchTermBankDefinitionsWidget extends StatefulWidget {

  /// The term bank entries to display 
  final List<TermBankV3Entry> entries;
  /// Max height for the definitions section. 0 = unlimited.
  final double definitionsMaxHeight;

  const DictionaryMatchTermBankDefinitionsWidget(
    this.entries,
    {
      this.definitionsMaxHeight = 0,
      super.key
    }
  );

  @override
  State<DictionaryMatchTermBankDefinitionsWidget> createState() => _DictionaryMatchTermBankDefinitionsWidgetState();
}

class _DictionaryMatchTermBankDefinitionsWidgetState extends State<DictionaryMatchTermBankDefinitionsWidget> {

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
                DictionaryMatchTermBankDefinitionWidget(
                  definitions: entriesToShow[i].structuredContentDefinitions,
                  indexId: entriesToShow[i].indexEntry.id
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

