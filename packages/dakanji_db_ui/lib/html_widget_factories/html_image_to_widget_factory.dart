import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';


BuildOp htmlToImage(String path) {
  return BuildOp.inline(
    onRenderInlineBlock: (meta, child) {
      return WidgetPlaceholder(
        child: Image.file(File(path)),
      );
    },
  );
}