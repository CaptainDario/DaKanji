import 'package:dakanji_db_core/parsing/term/definition_parsing_classes.dart';


class YomitanDefinitionParser {
  
  /// Parses the definition list (index 5 of a Yomitan entry)
  /// and extracts definitions, examples, forms, and metadata.
  /// 
  /// Handles:
  /// - Plain strings
  /// - Text/Image objects
  /// - Structured content (recursive traversal)
  /// - Mixed lists of the above
  static ParsedDefinitions parse(List<dynamic> definitionList) {

    // assure only the entry[5] part is passed
    for (var i = 0; i < definitionList.length; i++) {
      assert(
        definitionList[i] is String || 
        definitionList[i] is Map ||
        definitionList[i] is List,
        'Invalid definition item at index $i: ${definitionList[i]} (type: ${definitionList[i].runtimeType}).'
        'Pass ONLY the definition list (entry[5] of Yomitan entrys).'
      );      
    }

    return _DefinitionWalker(definitionList).execute();
  }
}

class _DefinitionWalker {
  final List<dynamic> _input;
  
  final definitions = <String>[];
  final posTags = <String>[];
  final examples = <ExampleSentence>[];
  final forms = <TermForm>[];
  final references = <String>[]; 
  
  // Walker state (needs to be persistent across the recursive walk)
  String? pendingSentence;

  _DefinitionWalker(this._input);

  ParsedDefinitions execute() {
    // 3. Iterate through top-level definition items
    for (var item in _input) {
      if (item is String) {
        definitions.add(item);
      } 
      else if (item is Map) {
        final type = item['type'];
        
        if (type == 'text' && item['text'] != null) {
          definitions.add(item['text']);
        } 
        else if (type == 'image') {
           final desc = item['description'] as String?;
           definitions.add(desc ?? '[Image]');
        } 
        else if (type == 'structured-content') {
           _walk(item['content']);
        }
      }
    }

    return ParsedDefinitions(
      definitions: definitions,
      posTags: posTags.toSet().toList(),
      examples: examples,
      forms: forms,
      references: references,
    );
  }

  void _walk(dynamic node) {
    if (node is Map) {
      final data = node['data'] as Map?;
      final content = node['content'];

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
        final refText = _extractText(content);
        if (!references.contains(refText)) {
          references.add(refText);
        }
      }
      // 3. XRefs (Skip "See Also" links as per original logic)
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
      if (data != null && data['content'] == 'forms') {
        Map<String, dynamic>? tableNode;
        if (content is List) {
           final found = content.firstWhere((e) => e is Map && e['tag'] == 'table', orElse: () => null);
           if (found != null) tableNode = (found as Map).cast<String, dynamic>();
        } else if (content is Map && content['tag'] == 'table') {
           tableNode = content.cast<String, dynamic>();
        }

        if (tableNode != null) {
          forms.addAll(_parseFormsTable(tableNode));
        }
        return; 
      }

      if (content != null) _walk(content);

    } else if (node is List) {
      for (var child in node) _walk(child);
    }
  }

  List<TermForm> _parseFormsTable(Map<String, dynamic> tableNode) {
    final forms = <TermForm>[];
    
    List<dynamic> findRows(dynamic content) {
      final rows = <dynamic>[];
      if (content is List) {
        for (var item in content) {
          if (item is Map) {
            if (item['tag'] == 'tr') rows.add(item);
            else if (item['content'] != null) rows.addAll(findRows(item['content']));
          }
        }
      }
      return rows;
    }

    final rows = findRows(tableNode['content']);
    if (rows.isEmpty || rows[0]['content'] == null) return [];

    // Row 0: Kanji Headers
    final headerRow = rows[0]['content'] as List<dynamic>;
    final kanjiHeaders = headerRow.map(_extractText).toList();

    // Row 1+: Readings vs Forms
    for (int i = 1; i < rows.length; i++) {
      final cells = rows[i]['content'] as List<dynamic>?;
      if (cells == null || cells.isEmpty) continue;

      // Col 0: Reading Header
      final readingHeader = _extractText(cells[0]);

      // Match data cells to headers
      for (int k = 1; k < cells.length; k++) {
        if (k >= kanjiHeaders.length) break;
        
        final status = _extractText(cells[k]);
        
        forms.add(TermForm(
          kanjiHeaders[k], 
          readingHeader, 
          status
        ));
      }
    }
    return forms;
  }

  String _extractText(dynamic node) {
    if (node == null) return '';
    if (node is String) return node;
    if (node is List) return node.map(_extractText).join('');
    if (node is Map) {
      // Removing Ruby text (<rt>) is standard practice
      if (node['tag'] == 'rt') return ''; 
      
      // Use alt text for images
      if (node['tag'] == 'img') return node['alt'] ?? '';

      if (node.containsKey('content')) return _extractText(node['content']);
    }
    return '';
  }
}