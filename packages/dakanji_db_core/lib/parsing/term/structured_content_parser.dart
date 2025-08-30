import 'dart:convert';
import 'dart:io';
import '/parsing/term/structure_content_ui_converter.dart';

import '/parsing/term/parsed_term.dart';
import '/parsing/term/term_parsing_method.dart';
import 'package:html/parser.dart';

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

/// Extracts a list of plain-text definitions from a single Yomichan term bank entry.
///
/// This function processes the raw definition list from a term entry, handling
/// plain text, simple text objects, and complex structured-content objects.
///
/// @param termEntryJson A list representing a single entry from a term_bank.json file.
/// @returns A list of ParsedDefinition objects, each containing the definition
///          text and the method used to parse it.
List<ParsedTerm> extractPlainTextDefinitions(List<dynamic> termEntryJson) {
  // The definitions are always at index 5 in the term entry array.
  final List<dynamic> rawDefinitions = termEntryJson[5];
  final List<ParsedTerm> parsedDefinitions = [];

  for (final rawDefinition in rawDefinitions) {
    // Case 1: The definition is already a plain string.
    if (rawDefinition is String) {
      parsedDefinitions.add(ParsedTerm(rawDefinition, TermParsingMethod.plainString));
      continue;
    }

    // Case 2: The definition is a map (e.g., text or structured-content).
    if (rawDefinition is Map) {
      final type = rawDefinition['type'];
      switch (type) {
        case 'text':
          final text = rawDefinition['text'] as String?;
          if (text != null) {
            parsedDefinitions.add(ParsedTerm(text, TermParsingMethod.textObject));
          }
          break;
        case 'structured-content':
          final content = rawDefinition['content'];
          if (content != null) {
            final jsonStringForCheck = jsonEncode(content);
            if (jsonStringForCheck.contains('"content":"glossary"')) {
              // Modern format: Precisely extract only the glossary parts.
              final glossaries = _extractEnglishGlossaries(content);
              for (final glossary in glossaries) {
                 parsedDefinitions.add(ParsedTerm(glossary, TermParsingMethod.modernStructured));
              }
            } else {
              // Old format: Fall back to extracting all text from the node.
              final plainText = getCustomDefinitionText(jsonStringForCheck);
              if (plainText.isNotEmpty) {
                parsedDefinitions.add(ParsedTerm(plainText, TermParsingMethod.legacyStructured));
              }
            }
          }
          break;
      }
      continue;
    }
    
    // Case 3: The definition is some other format we don't handle,
    // like a deinflection rule which is often a List.
    if(rawDefinition is List) {
        parsedDefinitions.add(ParsedTerm('[Unsupported data: Deinflection]', TermParsingMethod.unsupported));
    }
  }

  return parsedDefinitions;
}

/// Takes a JSON string from a structured-content definition and converts it
/// into clean, readable plain text.
String getCustomDefinitionText(String jsonString) {
  try {
    final dynamic content = jsonDecode(jsonString);
    final html = getStructuredContentHtml(content);

    // Use the standard 'html' package to parse the document and get its text.
    final document = parse(html);
    return document.body?.text.trim() ?? '';
  } catch (e) {
    // If parsing fails, return an empty string.
    return '';
  }
}




Future<void> main() async {
  print(Directory("../../").listSync());
  const devYomitanPath = "../../data/yomitan/term_bank_2.json";
  final file = File(devYomitanPath);

  try {
    // Read the file content as a string.
    final jsonString = await file.readAsString();
    // Decode the JSON string into a list of entries.
    final List<dynamic> termBank = jsonDecode(jsonString);

    // Process each entry in the term bank.
    for (final entry in termBank) {
      if (entry is List) {
        final term = entry[0];
        final reading = entry[1];
        print('\n--- Term: $term ($reading) ---');

        final definitions = extractPlainTextDefinitions(entry);
        if (definitions.isEmpty) {
          print('No definitions found.');
        } else {
          definitions.forEach((def) => print(def));
        }
      }

      break;
    }
  } catch (e) {
    print('An error occurred while reading or parsing the file: $e');
  }
}
