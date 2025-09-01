import 'package:dakanji_db_ui/html_widget_factories/html_help_attribute_to_widget_factory.dart';
import 'package:dakanji_db_ui/html_widget_factories/html_image_to_widget_factory.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:path/path.dart' as p;

class CustomHtmlToWidgetFactory extends WidgetFactory {

  /// The base directory in which all image assets are stored.
  final String imageAssetBasePath;

  CustomHtmlToWidgetFactory(this.imageAssetBasePath);

  @override
  void parse(BuildTree meta) {
    // Check if the element has the target style and title attribute
    final style = meta.element.attributes['style'];
    final title = meta.element.attributes['title'];

    if (title != null && style != null && style.contains('cursor: help')) {
      // Register a BuildOp to customize rendering
      meta.register(htmlHelpAttributeToWidget(title));
    }
    if (meta.element.localName == 'img') {
      final src = meta.element.attributes['src'];
      if (src != null && src.isNotEmpty) {
        // Register a BuildOp to customize rendering
        meta.register(htmlToImage(p.join(imageAssetBasePath, src)));
      }
    }

    // Always call super.parse() to handle other elements
    super.parse(meta);
  }
}