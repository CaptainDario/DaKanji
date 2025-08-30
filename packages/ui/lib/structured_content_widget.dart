import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class StructuredContentWidget extends StatelessWidget {
  /// The structured content JSON object from the dictionary entry.
  final Map<String, dynamic> content;

  /// The absolute path to the directory where the dictionary archive was unzipped.
  /// This is used to load images referenced in the content.
  final String imageAssetBasePath;

  const StructuredContentWidget({
    super.key,
    required this.content,
    required this.imageAssetBasePath,
  });

  @override
  Widget build(BuildContext context) {
    // Convert the structured content JSON into a standard HTML string.
    final htmlString = getStructuredContentHtml(content);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: HtmlWidget(
        htmlString,
        // Use a custom factory to handle local image assets.
        factoryBuilder: () => _MyWidgetFactory(imageAssetBasePath),
        // Handle taps on internal dictionary links.
        onTapUrl: (url) {
          if (url.startsWith('?')) {
            final uri = Uri.parse(url);
            final query = uri.queryParameters['query'];
            if (query != null) {
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

// --- Custom WidgetFactory for Image Handling ---

/// A custom WidgetFactory that resolves image paths from the local filesystem.
class _MyWidgetFactory extends WidgetFactory {
  final String imageAssetBasePath;

  _MyWidgetFactory(this.imageAssetBasePath);

  @override
  Widget? buildImage(BuildTree tree, ImageSource src) {
    // Construct the full, absolute path to the image file.
    final imagePath = '$imageAssetBasePath/${src.url}';
    final imageFile = File(imagePath);

    // If the image file exists, display it. Otherwise, show a placeholder.
    if (imageFile.existsSync()) {
      return Image.file(imageFile);
    } else {
      // Return a placeholder or an empty container if the image is not found.
      print('Image not found: $imagePath');
      return const SizedBox.shrink();
    }
  }
}