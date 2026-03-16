import 'dart:async';

import 'package:css_inline_flutter/css_inline_flutter.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db_ui/widgets/term/structured_content/custom_html_to_widget_factory.dart';
import 'package:da_db_ui/widgets/term/structured_content/structured_content_css.dart';
import 'package:da_db_ui/widgets/term/structured_content/structured_content_to_html.dart';
import 'package:da_db_ui/widgets/util/smart_html_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get_it/get_it.dart';



/// Widget that can render a definition entry of a yomitan dictionary
class TermBankDefinitionWidget extends StatefulWidget {
  /// The **raw (JSON)!** content of the structured content definitions
  final List<dynamic> definitions;

  /// The id of the index this definition belongs to
  final int indexId;

  /// Whether to render in compact mode (term bank entries in one line)
  final bool compactMode;

  /// Callback that is called when a URL is tapped.
  /// Should return true if the URL was handled.
  final FutureOr<bool> Function(String url)? onTapUrl;

  const TermBankDefinitionWidget({
    super.key,
    required this.definitions,
    required this.indexId,
    this.compactMode = false,
    this.onTapUrl,
  });

  @override
  State<TermBankDefinitionWidget> createState() => _TermBankDefinitionWidgetState();
}

class _TermBankDefinitionWidgetState extends State<TermBankDefinitionWidget> {


  /// Convert the structured content JSON into a standard HTML string and inline
  /// CSS from the index and the global CSS.
  /// Returns the final HTML string.
  Future<String> renderDefinition() async {

    String indexCss = await GetIt.I<DaDb>().mediaDao.getCssFromIndex(widget.indexId);
    
    String structuredContentHtmlString = renderDefinitions(
      widget.definitions, compactMode: widget.compactMode);
    structuredContentHtmlString = inlineFragmentSync(
      html: structuredContentHtmlString, css: indexCss);
    structuredContentHtmlString = inlineFragmentSync(
      html: structuredContentHtmlString, css: getStructuredContentCss(darkMode: true));

    return structuredContentHtmlString;
  }


  @override
  Widget build(BuildContext context) {
  
    return FutureBuilder(
      future: renderDefinition(),
      builder: (context, asyncSnapshot) {

        if (!asyncSnapshot.hasData || asyncSnapshot.data == null) {
          return SizedBox();
        } 
        else if (asyncSnapshot.hasError) {
          return Text('Error rendering definition: ${asyncSnapshot.error}');
        } 
        

        return SmartHtmlSelection(
          // TOOD: correct selection
          onTextSelected: (text) => print(text),
          child: HtmlWidget(
            asyncSnapshot.data!,
            textStyle: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
            // Use a custom factory to handle local assets.
            factoryBuilder: () => CustomHtmlToWidgetFactory(
              widget.indexId,
              GetIt.I<DaDb>(),
            ),
            // Handle taps on internal dictionary links.
            onTapUrl: widget.onTapUrl,
          ),
        );
      }
    );

  }

}
