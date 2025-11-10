import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_tag.dart';
import 'package:flutter/material.dart';


class DictionaryMatchTermMetaIpaWidget extends StatelessWidget {

  final List<TermMetaBankV3Entry> ipaTermMetaEntries;

  const DictionaryMatchTermMetaIpaWidget(
    this.ipaTermMetaEntries,
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        // List all ipa term meta entries below each other
        for (final entry in ipaTermMetaEntries)
          for (final ipa in entry.ipas)
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text("• "),
                for (final tag in ipa.tags)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: DictionaryMatchTag(text: tag.name),
                  ),
                Text(ipa.ipa),
              ]
            ),
      ],
    );
  }
}