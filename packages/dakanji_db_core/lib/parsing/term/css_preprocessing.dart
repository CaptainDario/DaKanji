/// Preprocesses border-related properties into the CSS `border` shorthand.
Map<String, dynamic> preprocessCssBorderForFlutterWidget(Map<String, dynamic> styleData) {
  // Make a mutable copy to handle special cases.
  final styleMap = Map<String, dynamic>.from(styleData);

  // --- Border shorthand logic ---
  // Extract individual border properties, removing them from the map.
  final borderWidth = styleMap.remove('borderWidth');
  final borderStyle = styleMap.remove('borderStyle');
  final borderColor = styleMap.remove('borderColor');

  // If any border property exists, construct the shorthand.
  if (borderWidth != null || borderStyle != null || borderColor != null) {
    final parts = [borderWidth, borderStyle, borderColor]
        .where((p) => p != null) // Filter out null properties
        .map((p) => p.toString()) // Convert them to strings
        .join(' '); // Join with spaces

    if (parts.isNotEmpty) {
      // Add the shorthand property back to the map.
      styleMap['border'] = parts;
    }
  }

  return styleMap;
}

/// Preprocesses `border-radius` percentages into a large pixel value.
/// Flutter HTML packages often don't support percentage values for border-radius,
/// so this converts values like "100%" into a large pixel value to simulate a circle.
Map<String, dynamic> preprocessBorderRadiusForFlutterWidget(Map<String, dynamic> styleData) {
  final styleMap = Map<String, dynamic>.from(styleData);
  const camelCaseKey = 'borderRadius';
  const paramCaseKey = 'border-radius';

  // Check if the camelCase key exists.
  if (styleMap.containsKey(camelCaseKey)) {
    final value = styleMap[camelCaseKey];
    if (value is String && value.endsWith('%')) {
      // Remove the camelCase key and add the processed value with the param-case key.
      styleMap.remove(camelCaseKey);
      styleMap[paramCaseKey] = '9999px 9999px 9999px 9999px';
    }
  }

  return styleMap;
}

/// Applies a chain of preprocessing methods to a CSS style map to make it
/// more compatible with Flutter HTML widgets.
Map<String, dynamic> preprocessCssForFlutterWidget(Map<String, dynamic> styleData) {
  var processedStyles = styleData;

  // The chain of preprocessing functions. More can be added here in the future.
  final preprocessors = [
    preprocessCssBorderForFlutterWidget,
    preprocessBorderRadiusForFlutterWidget
  ];

  for (final preprocessor in preprocessors) {
    processedStyles = preprocessor(processedStyles);
  }

  return processedStyles;
}