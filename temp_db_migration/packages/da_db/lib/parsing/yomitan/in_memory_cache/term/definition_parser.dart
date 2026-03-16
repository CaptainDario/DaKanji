import 'package:da_db/parsing/yomitan/in_memory_cache/term/definition_parsing_classes.dart';

class YomitanDefinitionParser {
  
  /// Parses the definition list (index 5 of a Yomitan entry)
  /// and extracts definitions, examples, forms, and metadata.
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
  
  // Walker state
  String? pendingSentence;
  bool _foundSemanticContent = false;

  _DefinitionWalker(this._input);

  // 1. The all-important cleaner! Replaces double/triple spaces with a single space and trims.
  String _cleanStr(String input) => input.replaceAll(RegExp(r'\s+'), ' ').trim();

  ParsedDefinitions execute() {
    for (var item in _input) {
      if (item is String) {
        definitions.add(_cleanStr(item));
      } 
      else if (item is Map) {
        final type = item['type'];
        
        if (type == 'text' && item['text'] != null) {
          definitions.add(_cleanStr(item['text'].toString()));
        } 
        else if (type == 'image') {
           final desc = item['description'] as String?;
           definitions.add(_cleanStr(desc ?? '[Image]'));
        } 
        else if (type == 'structured-content') {
           _foundSemanticContent = false;
           _walk(item['content']);

           // Only fallback if we didn't find ANY mapped content
           if (!_foundSemanticContent) {
             final fallbackText = _cleanStr(_extractText(item['content']));
             if (fallbackText.isNotEmpty) {
               definitions.add(fallbackText);
             }
           }
        }
      }
      else if (item is List) {
        if (item.length >= 2 && item[0] is String && item[1] is List) {
           final uninflectedTerm = item[0] as String;
           final rules = (item[1] as List).join(', ');
           definitions.add(_cleanStr('$uninflectedTerm → $rules'));
        } else {
           definitions.add(_cleanStr(_extractText(item)));
        }
      }
    }

    return ParsedDefinitions(
      definitions: definitions.where((e) => e.isNotEmpty).toList(),
      posTags: posTags.where((e) => e.isNotEmpty).toSet().toList(),
      examples: examples,
      forms: forms,
      references: references.where((e) => e.isNotEmpty).toList(),
    );
  }

  void _walk(dynamic node) {
    if (node is Map) {
      final data = node['data'] as Map?;
      final content = node['content'];

      if (data != null) {
        // 1. Definitions
        if (data['content'] == 'glossary') {
          _foundSemanticContent = true;
          if (content is List) {
            for (var item in content) definitions.add(_cleanStr(_extractText(item)));
          } else {
             definitions.add(_cleanStr(_extractText(content)));
          }
        }
        // 2. Redirects
        else if (data['content'] == 'redirect-glossary') {
          _foundSemanticContent = true;
          final refText = _cleanStr(_extractText(content));
          if (refText.isNotEmpty && !references.contains(refText)) {
            references.add(refText);
          }
        }
        // 3. XRefs
        else if (data['content'] == 'xref' || data['content'] == 'xref-glossary') {
          _foundSemanticContent = true; 
        }
        // 4. POS
        else if (data.containsKey('code')) {
          posTags.add(_cleanStr(_extractText(node)));
        }
        // 5. Examples
        else if (data['content'] == 'example-sentence-a') {
          _foundSemanticContent = true;
          pendingSentence = _cleanStr(_extractText(node));
        }
        else if (data['content'] == 'example-sentence-b') {
          _foundSemanticContent = true;
          if (pendingSentence != null) {
             examples.add(ExampleSentence(pendingSentence!, _cleanStr(_extractText(node))));
             pendingSentence = null;
          }
        }
        // 6. Forms Table
        else if (data['content'] == 'forms') {
          _foundSemanticContent = true;
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

    // Clean headers
    final headerRow = rows[0]['content'] as List<dynamic>;
    final kanjiHeaders = headerRow.map((e) => _cleanStr(_extractText(e))).toList();

    for (int i = 1; i < rows.length; i++) {
      final cells = rows[i]['content'] as List<dynamic>?;
      if (cells == null || cells.isEmpty) continue;

      // Clean reading header
      final readingHeader = _cleanStr(_extractText(cells[0]));

      for (int k = 1; k < cells.length; k++) {
        if (k >= kanjiHeaders.length) break;
        
        // Clean status
        final status = _cleanStr(_extractText(cells[k]));
        
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
    
    // Keep join('') so inline Japanese characters don't get split
    if (node is List) return node.map(_extractText).join('');
    
    if (node is Map) {
      final tag = node['tag'];
      
      // Remove Ruby and Pronunciation tags
      if (tag == 'rt' || tag == 'rp') return ''; 
      
      // Extract image text and pad
      if (tag == 'img') {
        final imgText = [node['alt'], node['description'], node['title']]
            .where((e) => e != null && e.toString().isNotEmpty)
            .join(' ');
        return ' $imgText '; 
      }

      String contentText = '';
      if (node.containsKey('content')) {
        contentText = _extractText(node['content']);
      }

      // Inject spaces around block-level elements
      final blockTags = [
        'div', 'p', 'li', 'br', 'td', 'th', 'tr', 'table', 'ul', 'ol',
        'blockquote', 'dl', 'dt', 'dd', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6'
      ];
      
      if (blockTags.contains(tag)) {
        return ' $contentText '; 
      }

      return contentText;
    }
    return '';
  }
}