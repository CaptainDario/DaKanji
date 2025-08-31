import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

/// A custom WidgetFactory that resolves image paths from the local filesystem.
class HtmlImageToWidgetFactory extends WidgetFactory {
  final String imageAssetBasePath;

  HtmlImageToWidgetFactory(this.imageAssetBasePath);

  @override
  Widget? buildImage(BuildTree tree, ImageMetadata meta) {
    // The image URL is available in the ImageMetadata sources.
    final imageUrl = meta.sources.firstOrNull?.url;
    if (imageUrl == null) {
      return null;
    }

    // Construct the full, absolute path to the image file.
    final imagePath = '$imageAssetBasePath/$imageUrl';
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