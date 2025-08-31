import 'dart:convert';
import 'package:dakanji_db_core/parsing/term/css_preprocessing.dart';
import 'package:html/dom.dart' as dom;
import 'package:recase/recase.dart';
import 'package:html/parser.dart' as html_parser;



import '/parsing/term/parsed_term.dart';
import '/parsing/term/term_parsing_method.dart';


/// Recursively extracts all text from within a given JSON node.
/// This is used after a glossary node has been identified.
String _extractTextFromNode(dynamic node) {
  if (node is String) {
    return node;
  }
  if (node is List) {
    // Join multiple definitions (e.g., "springboard", "impetus") with a separator.
    return node.map(_extractTextFromNode).join('; ');
  }
  if (node is Map && node.containsKey('content')) {
    return _extractTextFromNode(node['content']);
  }
  return '';
}

/// Recursively traverses the JSON structure to find nodes specifically
/// marked as a "glossary" and extracts their text content.
List<String> _extractEnglishGlossaries(dynamic content) {
  final List<String> glossaries = [];

  // Inner function to perform the recursive search.
  void findGlossaryNodes(dynamic node) {
    if (node is List) {
      for (final item in node) {
        findGlossaryNodes(item);
      }
      return;
    }

    if (node is Map) {
      final data = node['data'];
      // Check if this node is explicitly marked as a glossary.
      if (data is Map && data['content'] == 'glossary') {
        // Found one. Extract all its text content and add it to our list.
        final text = _extractTextFromNode(node['content']);
        glossaries.add(text);
        // Stop traversing this branch, as we've processed the glossary.
        return;
      }

      // If it's not a glossary, continue searching its children.
      if (node.containsKey('content')) {
        findGlossaryNodes(node['content']);
      }
    }
  }

  findGlossaryNodes(content);
  // Return a clean list of non-empty glossary strings.
  return glossaries.map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
}

/// Extracts a list of plain-text definitions from a Yomitan term's definition list.
///
/// This function processes the raw definition list from a term entry, handling
/// plain text, simple text objects, and complex structured-content objects.
List<ParsedTerm> extractPlainTextDefinitions(List<dynamic> definitions) {
  final List<ParsedTerm> parsedDefinitions = [];
  for (final definition in definitions) {
    // A single definition entry can contain multiple terms (glossaries),
    // so we use addAll to collect them.
    parsedDefinitions.addAll(extractParsedTerms(definition));
  }
  return parsedDefinitions;
}

/// Helper function that processes a single item from the definitions list.
/// It can return multiple ParsedTerm objects if a single structured-content
/// block contains multiple glossaries.
List<ParsedTerm> extractParsedTerms(dynamic definition) {
  // Case 1: The definition is already a plain string.
  if (definition is String) {
    return [ParsedTerm(definition, TermParsingMethod.plainString)];
  }

  // Case 2: The definition is a map (e.g., text or structured-content).
  if (definition is Map<String, dynamic>) {
    final type = definition['type'];
    switch (type) {
      case 'text':
        final text = definition['text'] as String?;
        if (text != null) {
          return [ParsedTerm(text, TermParsingMethod.textObject)];
        }
        break;
      case 'structured-content':
        final content = definition['content'];
        if (content != null) {
          // Modern format: Check for the 'glossary' tag.
          if (jsonEncode(content).contains('"content":"glossary"')) {
            final glossaries = _extractEnglishGlossaries(content);
            // Map each found glossary to a ParsedTerm object.
            return glossaries
                .map((g) => ParsedTerm(g, TermParsingMethod.modernStructured))
                .toList();
          } else {
            // Old format: Fall back to extracting all text from the node.
            final plainText = _getPlainTextFromStructuredContent(content);
            if (plainText.isNotEmpty) {
              return [ParsedTerm(plainText, TermParsingMethod.legacyStructured)];
            }
          }
        }
        break;
    }
  }

  // Case 3: The definition is some other format we don't handle,
  // like a deinflection rule which is often a List.
  if (definition is List) {
    return [ParsedTerm('[Deinflection Rule]', TermParsingMethod.unsupported)];
  }

  return [
    ParsedTerm(
        '[Unsupported Format: ${definition.runtimeType}]', TermParsingMethod.unsupported)
  ];
}

/// Converts a structured-content object to HTML and then extracts all plain text.
/// This is a fallback for older dictionary formats without the 'glossary' tag.
String _getPlainTextFromStructuredContent(dynamic content) {
  try {
    final html = getHtmlFromContent(content);
    final document = html_parser.parse(html);
    return document.body?.text.trim() ?? '';
  } catch (e) {
    return '';
  }
}



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
dom.Element _createElementFromStructuredContent(Map<String, dynamic> content) {
  final tag = content['tag'] as String?;
  final childContent = content['content'];
  final styleData = content['style'];
  final href = content['href'] as String?;
  final title = content['title'] as String?;

  if (tag == null) return dom.Element.tag('span');
  final element = dom.Element.tag(tag);

  if (href != null) element.attributes['href'] = href;
  if (title != null) element.attributes['title'] = title;

  if (styleData is Map) {
    // Preprocess the styles to handle shorthands and other conversions.
    final processedStyles = preprocessCssForFlutterWidget(styleData as Map<String, dynamic>);

    final styleString = processedStyles.entries.map((e) {
      final key = ReCase(e.key).paramCase;
      var value = e.value;
      if (value is num && _unitProperties.contains(key)) {
        return '$key: ${value}em';
      }
      return '$key: ${value.toString()}';
    }).join('; ');

    if (styleString.isNotEmpty) {
      element.attributes['style'] = styleString;
    }
  }

  element.innerHtml = getHtmlFromContent(childContent);
  return element;
}

String getHtmlFromContent(dynamic content) {
  if (content == null) return '';
  if (content is String) return content;
  if (content is List) return content.map(getHtmlFromContent).join();
  if (content is Map<String, dynamic>) {
    return _createElementFromStructuredContent(content).outerHtml;
  }
  return '';
}

/// Recursively builds an HTML string from a structured content object.
String convertDefinitionToHtml(dynamic definition) {
  // Handle null definitions gracefully.
  if (definition == null) return '';

  // Case 1: The definition is a simple plain text string.
  if (definition is String) {
    return definition;
  }

  // Case 2: The definition is a list (e.g., deinflection rules).
  // We will join them, but a more advanced implementation could format them.
  if (definition is List) {
    return definition.map((item) => item.toString()).join(' ');
  }

  // Case 3: The definition is a complex object.
  if (definition is Map<String, dynamic>) {
    final type = definition['type'];

    switch (type) {
      // It's a structured content object, which contains the actual content to render.
      case 'structured-content':
        return getHtmlFromContent(definition['content']);

      // It's a simple text object.
      case 'text':
        return definition['text'] ?? '';

      // It's an image object. Create an <img> tag for the factory to handle.
      case 'image':
        final path = definition['path'] ?? '';
        return '<img src="$path">';

      // Fallback for maps that don't have a 'type' but might be raw content nodes.
      default:
        if (definition.containsKey('tag')) {
          return getHtmlFromContent(definition);
        }
    }
  }

  // Return a placeholder for any unknown or unsupported format.
  return '[Unsupported definition format]';
}

