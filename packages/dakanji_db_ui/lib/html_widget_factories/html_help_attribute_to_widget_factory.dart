import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';



BuildOp htmlHelpAttributeToWidget(String title){
  return BuildOp.inline(
    onRenderInlineBlock: (meta, child) {
      // Add the exlanation
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
  );
}