import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_tag.dart';
import 'package:dakanji_db_example/widgets.dart/pitch_accent_widget.dart';
import 'package:flutter/material.dart';



class DictionaryMatchTermMetaPitchWidget extends StatelessWidget {

  final List<TermMetaBankV3Entry> pitchTermMetaEntries;

  const DictionaryMatchTermMetaPitchWidget(this.pitchTermMetaEntries, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        // List all ptich term meta entries below each other
        for (final entry in pitchTermMetaEntries)
          // Also all pitches below each other
          for (final pitch in entry.pitchs)
            // only tags and the actual pitch should be 
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text("• "),
                for (final tag in pitch.tags)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: DictionaryMatchTag(text: tag.name),
                  ),
                PitchAccentWidget(
                  entry.reading ?? entry.term,
                  pitch.position
                ),
              ]
            ),
      ],
    );
  }
}