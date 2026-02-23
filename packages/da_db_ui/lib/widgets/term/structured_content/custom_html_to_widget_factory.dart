import 'package:da_db/database/da_db.dart';
import 'package:da_db_ui/widgets/term/structured_content/html_help_attribute_to_widget_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:util/widget_utils/future_image_provider.dart';

class CustomHtmlToWidgetFactory extends WidgetFactory {

  /// The id of the index this definition belongs to
  final int indexId;

  /// The database instance to fetch media from
  final DaDb db;

  CustomHtmlToWidgetFactory(this.indexId, this.db);

  @override
  String? urlFull(String url) {
    return url; 
  }

  @override
  ImageProvider<Object>? imageProviderFromNetwork(String url) {

    if (!url.startsWith(RegExp(r'^https?://'))){
      return FutureImageProvider(url,
        () => db.mediaDao.getMediaByPath(url, indexId),);
    }
    else {
      return super.imageProviderFromNetwork(url);
    }
  }

  @override
  Widget? buildImage(BuildTree tree, ImageMetadata data) {

    // build image the image using the library's default method
    final builtImage = super.buildImage(tree, data);
    if (builtImage == null) return null;

    final url = data.sources.isNotEmpty ? data.sources.first.url : '';
    if (url.isEmpty) return builtImage;

    final uniqueTag = "$url-${tree.element.hashCode}";

    // Wrap in Builder to get access to 'context'
    return Builder(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              PageRouteBuilder(
                opaque: false, // Transparent background
                barrierColor: Colors.black.withValues(alpha: 0.8),
                barrierDismissible: true,
                pageBuilder: (context, _, _) {

                  return Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth * 0.9,
                            maxHeight: constraints.maxHeight * 0.9,
                          ),
                          child: Center(
                            child: Hero(
                              tag: uniqueTag,
                              child: _buildInsetBackground(context, builtImage)
                            ),
                          ),
                        );
                      }
                    ),
                  );
                },
              ),
            );
          },
          child: Hero(
            tag: uniqueTag,
            child: builtImage,
            flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
              return _buildInsetBackground(context, builtImage);
            },
          ),
        );
      },
    );
  }

  /// Helper to apply shrinking + background paint
  Widget _buildInsetBackground(BuildContext context, Widget child) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: CustomPaint(
          // Paints the background 1px smaller than the child
          painter: _InsetBackgroundPainter(
            color: Theme.brightnessOf(context) == Brightness.dark
                ? Colors.white
                : Colors.grey[900]!,
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  void parse(BuildTree tree) {
    // Check if the element has the target style and title attribute
    final style = tree.element.attributes['style'];
    final title = tree.element.attributes['title'];

    if (title != null && style != null && style.contains('cursor: help')) {
      // Register a BuildOp to customize rendering
      tree.register(htmlHelpAttributeToWidget(title));
    }

    // call super.parse() to handle other elements
    super.parse(tree);
  }

}


class _InsetBackgroundPainter extends CustomPainter {
  final Color color;
  _InsetBackgroundPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    // Draw a rectangle that is indented by 1 pixel on all sides
    // This creates the "Inset" effect preventing the halo
    final rect = Rect.fromLTWH(1, 1, size.width - 2, size.height - 2);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}