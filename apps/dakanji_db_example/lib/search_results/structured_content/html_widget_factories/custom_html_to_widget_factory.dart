import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_example/search_results/structured_content/html_widget_factories/html_help_attribute_to_widget_factory.dart';
import 'package:dakanji_db_example/search_results/structured_content/html_widget_factories/html_image_to_widget_factory.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class CustomHtmlToWidgetFactory extends WidgetFactory {

  /// The id of the index this definition belongs to
  final int indexId;

  /// The database instance to fetch media from
  final DaKanjiDB db;

  CustomHtmlToWidgetFactory(this.indexId, this.db);


  @override
  void parse(BuildTree tree) {
    // Check if the element has the target style and title attribute
    final style = tree.element.attributes['style'];
    final title = tree.element.attributes['title'];

    if (title != null && style != null && style.contains('cursor: help')) {
      // Register a BuildOp to customize rendering
      tree.register(htmlHelpAttributeToWidget(title));
    }
    if (tree.element.localName == 'img') {
      final src = tree.element.attributes['src'];
      if (src != null && src.isNotEmpty) {
        // Register a BuildOp to customize rendering
        tree.register(htmlImgToImageWidget(src, indexId, db));
      }
    }

    // Always call super.parse() to handle other elements
    super.parse(tree);
  }

}