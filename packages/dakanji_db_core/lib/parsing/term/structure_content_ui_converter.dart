import 'dart:convert';
import 'dart:io';
import 'package:html/dom.dart' as dom;
import 'package:recase/recase.dart';


// --- Helper Functions to Convert JSON to HTML ---

// Set of CSS properties that require a unit if their value is numeric.
const Set<String> _unitProperties = {
  'font-size',
  'margin', 'margin-top', 'margin-left', 'margin-right', 'margin-bottom',
  'padding', 'padding-top', 'padding-left', 'padding-right', 'padding-bottom',
  'border-radius', 'border-width',
};

/// Creates a single `dom.Element` from a structured content JSON object.
///
/// This function handles the creation of one element and applies its attributes
/// and inline styles. It uses `getStructuredContentHtml` to recursively
/// generate the inner HTML for its children.
dom.Element createElementFromStructuredContent(Map<String, dynamic> content) {
  final tag = content['tag'] as String?;
  final childContent = content['content'];
  final styleData = content['style'];
  final href = content['href'] as String?;
  final title = content['title'] as String?;

  // If there's no tag, we can't create a meaningful element.
  // Return an empty span as a safe fallback.
  if (tag == null) {
    return dom.Element.tag('span');
  }

  // Create the element with its specified tag.
  final element = dom.Element.tag(tag);

  // Add standard attributes like href for links and title for tooltips.
  if (href != null) element.attributes['href'] = href;
  if (title != null) element.attributes['title'] = title;

  // Process and apply inline styles.
  if (styleData is Map) {
    // Directly map the style entries to a CSS string.
    final styleString = styleData.entries.map((e) {
      final key = ReCase(e.key as String).paramCase;
      var value = e.value;

      // If the value is a number and the property requires a unit, append 'em'.
      // This is a common convention in the Yomitan format.
      if (value is num && _unitProperties.contains(key)) {
        return '$key: ${value}em';
      }

      // Otherwise, just convert the value to a string and create the CSS pair.
      return '$key: ${value.toString()}';
    }).join('; ');

    // Only add the style attribute if it's not empty.
    if (styleString.isNotEmpty) {
      element.attributes['style'] = styleString;
    }
  }

  // Recursively generate the inner HTML for all child content.
  element.innerHtml = convertDefinitionToHtml(childContent);

  return element;
}


/// Recursively builds an HTML string from a structured content object.
String convertDefinitionToHtml(dynamic content) {
  if (content == null) {
    return '';
  }
  if (content is String) {
    return content;
  }

  if (content is List) {
    return content.map(convertDefinitionToHtml).join();
  }

  if (content is Map<String, dynamic>) {
    // Use the new function to create the element and return its full HTML.
    return createElementFromStructuredContent(content).outerHtml;
  }

  return '';
}



Future<void> main() async {
  // Define the path to your Yomitan term bank file.
  const devYomitanPath = "/Users/darioklepoch/dev/DaKanji/dakanji_db/samples/yomitan/term_bank_2.json";
  final file = File(devYomitanPath);

  if (!await file.exists()) {
    print('Error: File not found at "$devYomitanPath"');
    print('Please update the devYomitanPath variable with the correct path.');
    return;
  }

  try {
    // Read the file content as a string.
    final jsonString = await file.readAsString();
    // Decode the JSON string into a list of entries.
    final List<dynamic> termBank = jsonDecode(jsonString);

    // Process the first entry in the term bank.
    if (termBank.isNotEmpty) {
      final entry = termBank.first;
      // The definitions are at index 5 and are a list.
      final definitions = entry[5] as List;

      print("--- Generating HTML for the first entry ---");

      // Iterate over each definition object in the list.
      for (final definition in definitions) {
        // Check if the definition is a structured-content map.
        if (definition is Map && definition['type'] == 'structured-content') {
          // Pass the *actual content* of the definition to the HTML generator.
          final actualContent = definition['content'];
          print(convertDefinitionToHtml(actualContent));
        } else if (definition is String) {
          // Handle simple string definitions.
          print(definition);
        }
      }
    }
  } catch (e) {
    print('An error occurred while reading or parsing the file: $e');
  }
}
