import 'package:dakanji_db_example/search_results/dictionary_match_tag.dart';
import 'package:flutter/material.dart';


class DictionaryMatchPopularityWidget extends StatefulWidget {

  final List<int> popularities;

  const DictionaryMatchPopularityWidget(this.popularities, {super.key});

  @override
  State<DictionaryMatchPopularityWidget> createState() => _DictionaryMatchPopularityWidgetState();
}

class _DictionaryMatchPopularityWidgetState extends State<DictionaryMatchPopularityWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (final popularity in widget.popularities)
          DictionaryMatchTag(
            popularity.toString(),
            null,
            color: Colors.orange[200],
          ),
      ],
    );
  }
}