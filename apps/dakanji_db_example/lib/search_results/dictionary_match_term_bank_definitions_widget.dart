import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_tag.dart';
import 'package:flutter/material.dart';


class DictionaryMatchTermBankDefinitionsWidget extends StatefulWidget {

  /// The indexes from which the entries come.
  final List<IndexTableEntry> indexes;
  /// The term bank entries to display 
  final List<TermBankV3Entry> entries;

  const DictionaryMatchTermBankDefinitionsWidget(this.indexes, this.entries, {super.key});

  @override
  State<DictionaryMatchTermBankDefinitionsWidget> createState() => _DictionaryMatchTermBankDefinitionsWidgetState();
}

class _DictionaryMatchTermBankDefinitionsWidgetState extends State<DictionaryMatchTermBankDefinitionsWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < widget.entries.length; i++) 
          Column(
            children: [
              SizedBox(
                width: double.infinity, // make sure the wrap uses the full width
                child: Row(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // numbering for each entry (1., 2. etc)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 4, 0, 0), // align number with tags
                      child: Text(
                        '${i + 1}. ',
                        style: const TextStyle(
                          color: Colors.grey
                        ),
                      ),
                    ),
                    // the rule identifiers for this definition
                    Expanded(
                      child: Wrap(
                        spacing: 2,
                        runSpacing: 4,
                        children: [
                          for (final identifier in widget.entries[i].definitionTags)
                            DictionaryMatchTag(identifier, null),
                          // the index from which this definitions comes
                          DictionaryMatchTag(
                            widget.indexes[i].title,
                            widget.indexes[i].description == ""
                              ? null
                              : widget.indexes[i].description,
                            color: Colors.grey[350],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // the actual definitions
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 4.0, 0.0, 4.0),
                child: Column(
                  children: [
                    for (final definition in widget.entries[i].definitions)
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("• "),
                              Expanded(
                                child: Text(
                                  definition,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ]
                ),
              )
            ],
          ),
      ],
    );
  }

}