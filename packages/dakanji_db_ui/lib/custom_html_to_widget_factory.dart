import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class CustomHtmlToWidgetFactory extends WidgetFactory {
  @override
  void parse(BuildTree meta) {
    // Check if the element has the target style and title attribute
    final style = meta.element.attributes['style'];
    final title = meta.element.attributes['title'];

    if (title != null && style != null && style.contains('cursor: help')) {
      // Register a BuildOp to customize rendering
      meta.register(BuildOp.inline(
        onRenderInlineBlock: (meta, child) {
          // 1. Wrap the default child widget with a Tooltip
          final interactiveWidget = Tooltip(
            message: title,
            child: MouseRegion(
              cursor: SystemMouseCursors.help,
              child: child,
            ),
          );

          // 2. Return the result inside a WidgetPlaceholder to keep it inline
          return WidgetPlaceholder(
            child: interactiveWidget,
          );
        },
      ));
    }

    // Always call super.parse() to handle other elements
    super.parse(meta);
  }
}