import 'dart:async';

import 'package:da_db/database/da_db.dart';
import 'package:da_kanji_mobile/features/dictionary/controller/definition_rendering.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/term/structured_content/html/custom_html_to_widget_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_util/widgets/conditional_parent_widget.dart';
import 'package:flutter_util/widgets/smart_html_selection.dart';
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

  /// Callback that is called when a text is selected in the definition.
  /// Returns the selected text.
  final Function(String text)? onSmartTextSelected;

  /// Callback that is called when a URL is tapped.
  /// Should return true if the URL was handled.
  final FutureOr<bool> Function(String url)? onTapUrl;

  const TermBankDefinitionWidget({
    super.key,
    required this.definitions,
    required this.indexId,
    this.compactMode = false,
    this.onSmartTextSelected,
    this.onTapUrl,
  });

  @override
  State<TermBankDefinitionWidget> createState() => _TermBankDefinitionWidgetState();
}

class _TermBankDefinitionWidgetState extends State<TermBankDefinitionWidget> {

  late Future<String> _renderDefinitionFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    _renderDefinitionFuture = renderDefinition();
  }

  /// Convert the structured content JSON into a standard HTML string and inline
  /// CSS from the index and the global CSS.
  /// Returns the final HTML string.
  Future<String> renderDefinition() async {
    final darkMode = Theme.of(context).brightness == Brightness.dark;
    final indexCss = await GetIt.I<DaDb>().mediaDao.getCssFromIndex(widget.indexId);

    return GetIt.I<YomitanRenderService>().render((
      definitions: widget.definitions,
      indexCss: indexCss,
      compactMode: widget.compactMode,
      darkMode: darkMode,
    ));
  }


  @override
  Widget build(BuildContext context) {
  
    return FutureBuilder(
      future: _renderDefinitionFuture,
      builder: (context, asyncSnapshot) {

        if (asyncSnapshot.hasError) {
          return Text('Error rendering definition: ${asyncSnapshot.error}');
        }
        else if (!asyncSnapshot.hasData || asyncSnapshot.data == null) {
          return SizedBox();
        } 
        

        return ConditionalParentWidget(
          condition: widget.onSmartTextSelected != null,
          conditionalBuilder: (child) {
            return SmartHtmlSelection(
              onTextSelected: widget.onSmartTextSelected,
              child: child,
            );
          },
          child: HtmlWidget(
            asyncSnapshot.data!,
            buildAsync: false,
            enableCaching: true,
            renderMode: RenderMode.column,
            textStyle: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
            onLoadingBuilder: (context, element, loadingProgress) => const SizedBox(),
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
