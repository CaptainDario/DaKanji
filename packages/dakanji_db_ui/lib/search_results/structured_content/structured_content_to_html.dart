import 'dart:convert';

/// Main entry point: Renders a list of Yomitan definitions to a portable HTML string.
String renderDefinitions(List<dynamic> definitions) {
  final buffer = StringBuffer();
  final count = definitions.length;

  // 1. Outer Container
  // Yomitan Logic: If there is only 1 definition, no bullets (list-style: none).
  // Otherwise, use circle bullets.
  String listStyle = count == 1 ? 'none' : 'circle';
  String padding = count == 1 ? '0' : '1.4em';

  buffer.write(
      '<ul class="gloss-list" data-count="$count" style="list-style-type: $listStyle; padding-left: $padding; margin: 0;">');

  for (var def in definitions) {
    // Determine if we should force-hide the bullet for this specific item.
    // This prevents double-bullets when the content itself is a list (ul/ol).
    bool suppressBullet = false;

    if (def is Map && def['type'] == 'structured-content') {
      final content = def['content'];
      if (content is Map && ['ul', 'ol', 'table', 'div'].contains(content['tag'])) {
        suppressBullet = true;
      }
    }

    String itemStyle = 'margin-bottom: 0.25em;';
    if (suppressBullet) {
      itemStyle += ' list-style-type: none;';
    }

    // 2. List Item
    buffer.write('<li class="gloss-item" style="$itemStyle">');
    
    // 3. Content Wrapper
    buffer.write('<span class="gloss-content">');

    if (def is String) {
      buffer.write(_escapeHtml(def));
    } else if (def is Map) {
      final type = def['type'];

      if (type == 'structured-content') {
        buffer.write(_renderNode(def['content']));
      } else if (type == 'image') {
        buffer.write(_renderRootImage(def));
      } else if (type == 'text') {
        buffer.write(_escapeHtml(def['text']?.toString() ?? ""));
      }
    }

    buffer.write('</span>');
    buffer.write('</li>');
  }

  buffer.write('</ul>');
  return buffer.toString();
}

/// Recursively renders a node from the "structured-content" tree.
String _renderNode(dynamic node) {
  if (node == null) return '';

  if (node is String) {
    return _escapeHtml(node);
  }

  if (node is List) {
    return node.map((child) => _renderNode(child)).join('');
  }

  if (node is Map) {
    if (node.containsKey('tag')) {
      final String tag = node['tag'];

      // Dispatch to specific renderers
      if (tag == 'ul' || tag == 'ol') return _renderList(node);
      if (tag == 'a') return _renderLink(node);
      if (tag == 'img') return _renderInlineImage(node);
      if (tag == 'table') {
        return '<div class="gloss-sc-table-container">${_renderElement(node)}</div>';
      }
      if (tag == 'br') return '<br>';

      return _renderElement(node);
    }
  }

  return '';
}

/// Renders generic elements
String _renderElement(Map node) {
  final tag = node['tag'];
  final buffer = StringBuffer();

  buffer.write('<$tag class="gloss-sc-$tag"');
  _renderAttributes(node, buffer);
  _renderStyles(node, buffer);
  _renderDataAttributes(node, buffer);

  if (tag == 'details' && node['open'] == true) {
    buffer.write(' open');
  }

  buffer.write('>');

  if (node.containsKey('content')) {
    buffer.write(_renderNode(node['content']));
  }

  buffer.write('</$tag>');
  return buffer.toString();
}

/// Renders lists (ul/ol) with specific padding to match Yomitan layout
String _renderList(Map node) {
  final tag = node['tag'];
  final buffer = StringBuffer();
  
  // Default padding to ensure nested lists look correct
  String defaultStyles = 'padding-left: 1.4em;';

  buffer.write('<$tag class="gloss-sc-$tag"');
  _renderAttributes(node, buffer);
  
  // Merge default padding with any incoming styles
  if (node.containsKey('style') && node['style'] is Map) {
    String css = _mapToCss(node['style']);
    buffer.write(' style="$defaultStyles $css"');
  } else {
    buffer.write(' style="$defaultStyles"');
  }

  _renderDataAttributes(node, buffer);
  buffer.write('>');

  if (node.containsKey('content')) {
    buffer.write(_renderNode(node['content']));
  }

  buffer.write('</$tag>');
  return buffer.toString();
}

/// Renders anchor tags
String _renderLink(Map node) {
  final buffer = StringBuffer();
  final href = node['href']?.toString() ?? '';
  final isInternal = href.startsWith('?');

  buffer.write('<a class="gloss-link"');
  _renderAttributes(node, buffer);
  buffer.write(' data-external="${!isInternal}"');
  _renderStyles(node, buffer);
  buffer.write('>');

  buffer.write('<span class="gloss-link-text">');
  if (node.containsKey('content')) {
    buffer.write(_renderNode(node['content']));
  }
  buffer.write('</span>');

  if (!isInternal) {
    // Unicode arrow for external links
    buffer.write('<span class="gloss-link-external-icon icon" style="font-size:0.8em; margin-left:0.2em;">&#x2197;</span>');
  }

  buffer.write('</a>');
  return buffer.toString();
}

/// Renders root-level images (with caption support)
String _renderRootImage(Map node) {
  final sb = StringBuffer();
  final hasDescription = node.containsKey('description') &&
      node['description'] != null &&
      node['description'].toString().isNotEmpty;

  // Use <figure> to keep image and caption together
  if (hasDescription) sb.write('<figure style="margin:0; display:inline-block;">');

  sb.write(_renderInlineImage(node));

  if (hasDescription) {
    sb.write('<figcaption class="gloss-image-description" style="font-size:0.9em; color:#666;">');
    sb.write(_escapeHtml(node['description']));
    sb.write('</figcaption>');
  }

  if (hasDescription) sb.write('</figure>');
  return sb.toString();
}

/// Renders inline images as standard <img> tags for Flutter compatibility.
/// 
/// Note: This simplifies the "collapsible" structure (which uses <a> wrappers)
/// into a standard <img> tag so it renders reliably in widgets like flutter_widget_from_html.
String _renderInlineImage(Map node) {
  final buffer = StringBuffer();
  
  final width = node['preferredWidth'] ?? node['width'];
  final height = node['preferredHeight'] ?? node['height'];
  final sizeUnits = node['sizeUnits'] ?? 'px';

  buffer.write('<img class="gloss-image"');

  if (node.containsKey('path')) {
    buffer.write(' src="${_escapeAttribute(node['path'])}"');
  }

  // Handle Dimensions
  if (sizeUnits == 'em') {
    // For EM units, we use inline styles
    String style = '';
    if (width != null) style += 'width: ${width}em; ';
    if (height != null) style += 'height: ${height}em; ';
    if (style.isNotEmpty) buffer.write(' style="$style"');
  } else {
    // For pixels, attributes are safer for older parsers
    if (width != null) buffer.write(' width="$width"');
    if (height != null) buffer.write(' height="$height"');
  }

  // Fallback Alt Text
  String altText = node['alt'] ?? node['description'] ?? '';
  if (altText.isNotEmpty) buffer.write(' alt="${_escapeAttribute(altText)}"');

  // Handle Styles
  Map<String, dynamic> styles = {};
  if (node.containsKey('style') && node['style'] is Map) {
    styles.addAll(Map<String, dynamic>.from(node['style']));
  }
  if (node.containsKey('verticalAlign')) styles['vertical-align'] = node['verticalAlign'];
  if (node['pixelated'] == true || node['imageRendering'] == 'pixelated') styles['image-rendering'] = 'pixelated';
  if (node['appearance'] == 'monochrome') styles['filter'] = 'grayscale(100%)';

  if (styles.isNotEmpty && sizeUnits != 'em') {
     buffer.write(' style="${_mapToCss(styles)}"');
  }

  // Pass collapsed state as data attribute so you can handle it in Flutter if desired
  if (node['collapsed'] == true) buffer.write(' data-collapsed="true"');
  if (node['collapsible'] == true) buffer.write(' data-collapsible="true"');

  buffer.write(' />');
  return buffer.toString();
}

// --- Helpers ---

void _renderAttributes(Map node, StringBuffer buffer) {
  const attrMap = {
    'href': 'href',
    'title': 'title',
    'lang': 'lang',
    'rowSpan': 'rowspan',
    'colSpan': 'colspan',
    'cellPadding': 'cellpadding',
    'cellSpacing': 'cellspacing',
    'border': 'border',
  };

  attrMap.forEach((jsonKey, htmlAttr) {
    if (node.containsKey(jsonKey)) {
      buffer.write(' $htmlAttr="${_escapeAttribute(node[jsonKey].toString())}"');
    }
  });
}

void _renderStyles(Map node, StringBuffer buffer) {
  if (node.containsKey('style') && node['style'] is Map) {
    String css = _mapToCss(node['style']);
    if (css.isNotEmpty) {
      buffer.write(' style="$css"');
    }
  }
}

void _renderDataAttributes(Map node, StringBuffer buffer) {
  if (node.containsKey('data') && node['data'] is Map) {
    (node['data'] as Map).forEach((k, v) {
      buffer.write(' data-$k="${_escapeAttribute(v.toString())}"');
    });
  }
}

String _mapToCss(Map styleMap) {
  if (styleMap.isEmpty) return '';

  final buffer = StringBuffer();
  styleMap.forEach((key, value) {
    if (value != null) {
      final cssKey = _camelToKebab(key);
      String cssValue = value.toString();

      if (value is List) {
        cssValue = value.join(' ');
      }
      else if (value is num) {
        if (['marginTop', 'marginRight', 'marginBottom', 'marginLeft', 'fontSize'].contains(key)) {
          cssValue = '${value}em';
        }
      }

      buffer.write('$cssKey:$cssValue;');
    }
  });
  return buffer.toString();
}

String _camelToKebab(String input) {
  return input.replaceAllMapped(RegExp(r'[A-Z]'), (match) {
    return '-${match.group(0)!.toLowerCase()}';
  });
}

String _escapeHtml(String text) {
  return const HtmlEscape(HtmlEscapeMode.element).convert(text);
}

String _escapeAttribute(String text) {
  return const HtmlEscape(HtmlEscapeMode.attribute).convert(text);
}