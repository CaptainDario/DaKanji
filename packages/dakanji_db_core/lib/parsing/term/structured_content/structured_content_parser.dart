import 'dart:convert';
import 'dart:io';

import 'package:dakanji_db_core/parsing/term/structured_content/parsing_classes.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'package:path/path.dart' as p;

class StructuredContentParser {
  
  static ParsedDictionaryEntry? parseEntry(List<dynamic> entry) {
    if (entry.length < 6) return null;

    final headword = entry[0] as String;
    final reading = entry[1] as String;
    
    // Structured content is typically at index 5
    final definitionList = entry[5] as List<dynamic>;
    if (definitionList.isEmpty) return null;
    
    final firstDef = definitionList[0];
    if (firstDef is! Map || firstDef['type'] != 'structured-content') return null;

    final rootContent = firstDef['content'];
    
    final definitions = <String>[];
    final posTags = <String>[];
    final examples = <ExampleSentence>[];
    final forms = <TermForm>[];
    String? pendingSentence;
    String? referenceLink;

    void walk(dynamic node) {
      if (node is Map) {
        final data = node['data'] as Map?;
        final content = node['content'];
        final tag = node['tag'];

        // 1. Definitions
        if (data != null && data['content'] == 'glossary') {
          if (content is List) {
            for (var item in content) definitions.add(_extractText(item));
          } else {
             definitions.add(_extractText(content));
          }
        }
        // 2. Redirects
        else if (data != null && data['content'] == 'redirect-glossary') {
          referenceLink = _extractText(content).replaceAll('⟶', '').trim();
        }
        // 3. XRefs (Skip "See Also" links)
        else if (data != null && (data['content'] == 'xref' || data['content'] == 'xref-glossary')) {
           return; 
        }
        // 4. POS
        else if (data != null && data.containsKey('code')) {
          posTags.add(_extractText(node));
        }
        // 5. Examples
        else if (data != null && data['content'] == 'example-sentence-a') {
          pendingSentence = _extractText(node);
        }
        else if (data != null && data['content'] == 'example-sentence-b') {
          if (pendingSentence != null) {
             examples.add(ExampleSentence(pendingSentence!, _extractText(node)));
             pendingSentence = null;
          }
        }
        // 6. Forms Table
        if (tag == 'table') {
          forms.addAll(_parseFormsTable(node.cast<String, dynamic>()));
          return; 
        }

        if (content != null) walk(content);

      } else if (node is List) {
        for (var child in node) walk(child);
      }
    }

    walk(rootContent);

    return ParsedDictionaryEntry(
      headword: headword,
      reading: reading,
      definitions: definitions,
      posTags: posTags.toSet().toList(),
      examples: examples,
      forms: forms,
      reference: referenceLink,
    );
  }

  static List<TermForm> _parseFormsTable(Map<String, dynamic> tableNode) {
    final forms = <TermForm>[];
    final rows = tableNode['content'] as List<dynamic>?;
    if (rows == null || rows.isEmpty) return [];

    // Row 0: Kanji Headers
    final headerRow = rows[0]['content'] as List<dynamic>;
    final kanjiHeaders = headerRow.map(_extractText).toList();

    // Row 1+: Readings vs Forms
    for (int i = 1; i < rows.length; i++) {
      final cells = rows[i]['content'] as List<dynamic>;
      if (cells.isEmpty) continue;

      // Col 0: Reading Header
      final readingHeader = _extractText(cells[0]);

      // Match data cells to headers
      for (int k = 1; k < cells.length; k++) {
        if (k >= kanjiHeaders.length) break;
        
        // Extract raw text. If the cell is empty (common in Yomitan for "valid"),
        // the string will be empty.
        final status = _extractText(cells[k]);
        
        // Only add the form if we have a header to map it to.
        forms.add(TermForm(
          kanjiHeaders[k], 
          readingHeader, 
          status
        ));
      }
    }
    return forms;
  }

  static String _extractText(dynamic node) {
    if (node is String) return node;
    if (node is List) return node.map(_extractText).join('');
    if (node is Map) {
      // Removing Ruby text (<rt>) is standard practice for search indexing
      if (node['tag'] == 'rt') return ''; 
      if (node.containsKey('content')) return _extractText(node['content']);
    }
    return '';
  }
}

// Main function for quick testing

void main() {
  // Replace with your actual file path
  File f = File(p.join(dakanjiDbProjectRoot, 'data/yomitan/term_bank_2.json'));
  
  if (!f.existsSync()) {
    print("File not found!");
    return;
  }

  List<dynamic> allEntries = jsonDecode(f.readAsStringSync());
  print("Loaded ${allEntries.length} entries.\n");

  for (var rawEntry in allEntries) {
    final parsed = StructuredContentParser.parseEntry(rawEntry);
    
    if (parsed != null) {
      print('------------------------------------------------');
      print(parsed.toString());
      
      // Optional: Print details if they exist
      if (parsed.forms.isNotEmpty) {
        print('  [Forms Found]: ${parsed.forms.length}');
      }
      if (parsed.examples.isNotEmpty) {
        print('  [Example]: ${parsed.examples.first}');
      }
    }
  }
}