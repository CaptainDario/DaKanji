import 'package:dakanji_db_core/parsing/term/structured_content_parser.dart';
import 'package:dakanji_db_ui/html_widget_factories/custom_html_to_widget_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


/// Widget that can render a definition entry of a yomitan dictionary
class DefinitionItemWidget extends StatelessWidget {
  /// The content of the definition entry, can be a string or a more complex
  /// structure (structured content map).
  final dynamic content;

  /// The absolute path to the directory where the dictionary archive was unzipped.
  /// This is used to load images referenced in the content.
  final String imageAssetBasePath;

  const DefinitionItemWidget({
    super.key,
    required this.content,
    required this.imageAssetBasePath,
  });

  @override
  Widget build(BuildContext context) {
    // Convert the structured content JSON into a standard HTML string.
    final htmlString = convertDefinitionToHtml(content);
    print(htmlString);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: HtmlWidget(
        htmlString,
        // Use a custom factory to handle local image assets.
        factoryBuilder: () => CustomHtmlToWidgetFactory(imageAssetBasePath),

        // Handle taps on internal dictionary links.
        onTapUrl: (url) {
          if (url.startsWith('?')) {
            final uri = Uri.parse(url);
            final query = uri.queryParameters['query'];
            if (query != null) {
              // TODO 
              // In a real app, you would trigger a search here.
              print('Internal link tapped! Search for: "$query"');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Search for: $query')),
              );
            }
            return true; // Mark the URL as handled.
          }
          return false; // Let the package handle external URLs.
        },
      ),
    );
  }
}

