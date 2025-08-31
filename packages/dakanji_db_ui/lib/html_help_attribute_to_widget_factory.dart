import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

// The final, corrected custom factory.
class HtmlHelpAttributeToWidgetFactory extends WidgetFactory {
  final BuildContext context;

  HtmlHelpAttributeToWidgetFactory(this.context);

  @override
  void parse(BuildTree tree) {
    final e = tree.element;
    if (e.attributes.containsKey('title')) {
      final title = e.attributes['title'];
      bool hasHelpCursor = false;
      for (final style in tree.styles) {
        if (style.property == 'cursor' && style.value == 'help') {
          hasHelpCursor = true;
          break;
        }
      }

      if (hasHelpCursor && title != null) {
        tree.register(BuildOp(
          onWidgets: (meta, widgets) {
            if (widgets.isEmpty) {
              return widgets;
            }
            return [
              MouseRegion(
                cursor: SystemMouseCursors.help,
                child: GestureDetector(
                  onTap: () => _showHelpDialog(title),
                  child: widgets.first,
                ),
              ),
              ...widgets.skip(1)
            ];
          },
        ));
      }
    }

    return super.parse(tree);
  }

  // Example callback function (remains the same).
  void _showHelpDialog(String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Help'),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}