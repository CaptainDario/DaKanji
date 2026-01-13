import 'package:css_inline_flutter/css_inline_flutter.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_ui/search_results/structured_content/custom_html_to_widget_factory.dart';
import 'package:dakanji_db_ui/search_results/structured_content/structured_content_css.dart';
import 'package:dakanji_db_ui/search_results/structured_content/structured_content_to_html.dart';
import 'package:dakanji_util/widgets/fade_long_widget_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';



/// Widget that can render a definition entry of a yomitan dictionary
class DictionaryMatchTermBankDefinitionWidget extends StatefulWidget {
  /// The **raw (JSON)!** content of the structured content definitions
  final List<dynamic> definitions;

  /// The id of the index this definition belongs to
  final int indexId;

  /// Whether to use compact mode for displaying definitions
  final bool compactMode;

  const DictionaryMatchTermBankDefinitionWidget({
    super.key,
    required this.definitions,
    required this.indexId,
    this.compactMode = false,
  });

  @override
  State<DictionaryMatchTermBankDefinitionWidget> createState() => _DictionaryMatchTermBankDefinitionWidgetState();
}

class _DictionaryMatchTermBankDefinitionWidgetState extends State<DictionaryMatchTermBankDefinitionWidget> {

  String indexCss = "";

  Future<bool> getCss() async {
    
    indexCss = await context.read<DaKanjiDB>().mediaDao
      .getCssFromIndex(widget.indexId);

    return true;

  }

  /// Convert the structured content JSON into a standard HTML string and inline
  /// CSS from the index and the global CSS.
  /// Returns the final HTML string.
  String renderDefinition() {
    
    String structuredContentHtmlString = renderDefinitions(widget.definitions);
    structuredContentHtmlString = inlineFragmentSync(html: structuredContentHtmlString, css: indexCss);
    structuredContentHtmlString = inlineFragmentSync(html: structuredContentHtmlString, css: getStructuredContentCss(darkMode: true));
    structuredContentHtmlString = structuredContentHtmlString.replaceAll("\n", "<br/>");

    return structuredContentHtmlString;
  }


  @override
  Widget build(BuildContext context) {
  
    return FutureBuilder(
      future: getCss(),
      builder: (context, asyncSnapshot) {

        return FadeLongWidgetWrapper(
          fadeStartPercentage: widget.compactMode ? 0.9 : 1.0,
          maxContentHeight: widget.compactMode ? 70 : double.infinity,
          child: HtmlWidget(
            renderDefinition(),
            textStyle: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
            // Use a custom factory to handle local assets.
            factoryBuilder: () => CustomHtmlToWidgetFactory(
              widget.indexId,
              context.read<DaKanjiDB>(),
            ),
          
            // Handle taps on internal dictionary links.
            onTapUrl: (url) {
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
            //onTapImage: (imageMetadata) {
            //  debugPrint('Image tapped: ${imageMetadata.sources.first.url}');
            //  return;
            //},
          ),
        );
      }
    );

  }

}
