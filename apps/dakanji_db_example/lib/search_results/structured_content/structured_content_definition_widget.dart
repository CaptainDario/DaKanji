import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_example/search_results/structured_content/html_widget_factories/custom_html_to_widget_factory.dart';
import 'package:dakanji_db_example/search_results/structured_content/structured_content_to_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';



/// Widget that can render a definition entry of a yomitan dictionary
class StructuredContentDefinitionWidget extends StatefulWidget {
  /// The content (structured content map) of the definition entry
  final dynamic content;

  /// The id of the index this definition belongs to
  final int indexId;

  const StructuredContentDefinitionWidget({
    super.key,
    required this.content,
    required this.indexId,
  });

  @override
  State<StructuredContentDefinitionWidget> createState() => _StructuredContentDefinitionWidgetState();
}

class _StructuredContentDefinitionWidgetState extends State<StructuredContentDefinitionWidget> {

  final YomitanParser parser = YomitanParser();

  late final externalCss = '''
ul[data-sc-content='glossary'] {
    color: #ffff00;
}
  ''';

  @override
  void initState() {
    super.initState();
    parser.addExternalCss(externalCss);
  }

  @override
  Widget build(BuildContext context) {
    // Convert the structured content JSON into a standard HTML string.
    final htmlString = parser.convert(widget.content);
    print(htmlString);
    return HtmlWidget(
      htmlString,
      // Use a custom factory to handle local assets.
      factoryBuilder: () => CustomHtmlToWidgetFactory(widget.indexId, context.read<DaKanjiDB>()),

      // Handle taps on internal dictionary links.
      onTapUrl: (url) {
        print(url);
        // TODO URI
        if (url.startsWith('?')) {
          final uri = Uri.parse(url);
          final query = uri.queryParameters['query'];
          if (query != null) {
            // TODO 
            debugPrint('Internal link tapped! Search for: "$query"');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Search for: $query')),
            );
          }
          return true; // Mark the URL as handled.
        }
        return false; // Let the package handle external URLs.
      },
    );
  }
}

