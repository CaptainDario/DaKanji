import 'package:flutter/material.dart';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';



/// Table widget that shows japanese example sentences and their matching
/// english translations
class DojgSentenceTable extends StatelessWidget {
  /// A list of Japanese sentences to show in this widget
  final List<String> sentencesJp;
  /// A list of English sentences to show below the Japanese sentences less
  /// noticable
  final List<String> sentencesEn;
  
  const DojgSentenceTable(
    this.sentencesJp,
    this.sentencesEn,
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: LayoutGrid(
                    
        columnSizes: [auto, 1.fr],
        rowSizes: List.generate(
          (sentencesEn.length*3).floor(),
          (index) => auto
        ),
        children: [
          for (int i = 0; i < sentencesEn.length; i++)
            ...[
              Text("${i+1}. ",
                style: const TextStyle(color: Colors.grey)
              ),
              HtmlWidget(
                sentencesJp[i],
                customStylesBuilder: (element) {
                  if (element.classes.contains('cloze')) {
                    return {'color': 'red'};
                  }
    
                  return null;
                },
              ),
              const SizedBox(),
              Text(
                sentencesEn[i],
                style: const TextStyle(
                  color: Colors.grey
                ),
              ),
              const SizedBox(height: 4,),
              const SizedBox(height: 4,)
            ],
        ]
      ),
    );
  }
}