import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';



class ManualSection extends StatelessWidget {
  
  final String title;
  final List<(Widget?, String?)> sectionHeaders;
  final List<(String text, bool isMarkdown)> sectionTexts;

  const ManualSection({
    required this.title,
    required this.sectionHeaders,
    required this.sectionTexts,
    super.key
  });

    
  /// heading 1 text style
  final TextStyle heading_1 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  /// heading 2 text style
  final TextStyle heading_2 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title, style: heading_1,),
      children: [
        const SizedBox(height: 15),
        for (int i = 0; i < sectionHeaders.length; i++) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                if(sectionHeaders[i].$1 != null)
                  ...[
                    sectionHeaders[i].$1!,
                    const SizedBox(width: 8,),
                  ],
                if(sectionHeaders[i].$2 != null)
                  Text(
                    sectionHeaders[i].$2!,
                    style: heading_2,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          sectionTexts[i].$2
            ? MarkdownBody(data: sectionTexts[i].$1)
            : Text(sectionTexts[i].$1),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 15),
      ],
    );
  }
}