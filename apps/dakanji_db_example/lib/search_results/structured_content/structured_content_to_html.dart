

/// A generator that converts Yomitan Structured Content (JSON/Map) into
/// portable, renderable HTML.
class StructuredContentGenerator {
  final String? _baseUrl;
  final bool _embedCss;

  /// [baseUrl] is optional. If provided, it is prepended to image paths and link hrefs.
  /// [embedCss] if true (default), injects the standard Yomitan CSS styles at the start of the HTML.
  StructuredContentGenerator({
    String? baseUrl,
    bool embedCss = true,
  })  : _baseUrl = baseUrl,
        _embedCss = embedCss;

  /// Main method to convert the structured content [data] (List or Map) to HTML.
  String render(dynamic data) {
    final buffer = StringBuffer();

    if (_embedCss) {
      buffer.write('<style>$_coreCss</style>');
    }

    buffer.write('<div class="structured-content">');
    _processContent(buffer, data);
    buffer.write('</div>');

    return buffer.toString();
  }

  void _processContent(StringBuffer buffer, dynamic content) {
    if (content == null) return;

    if (content is String) {
      // Escape text content to prevent XSS/rendering issues
      buffer.write(_escapeHtml(content));
      return;
    }

    if (content is List) {
      for (var item in content) {
        _processContent(buffer, item);
      }
      return;
    }

    if (content is Map) {
      // It's an element map
      final map = content as Map<String, dynamic>;
      _renderElement(buffer, map);
      return;
    }
  }

  void _renderElement(StringBuffer buffer, Map<String, dynamic> node) {
    final String tag = node['tag'] ?? 'span';

    switch (tag) {
      case 'br':
        buffer.write('<br>');
        break;
      case 'img':
        _renderImage(buffer, node);
        break;
      case 'a':
        _renderLink(buffer, node);
        break;
      case 'table':
        buffer.write('<div class="gloss-sc-table-container">');
        _renderGenericElement(buffer, node, 'table', 'gloss-sc-table');
        buffer.write('</div>');
        break;
      // Table elements
      case 'tr':
      case 'thead':
      case 'tbody':
      case 'tfoot':
        _renderGenericElement(buffer, node, tag, 'gloss-sc-$tag');
        break;
      case 'td':
      case 'th':
        _renderTableCell(buffer, node);
        break;
      // Standard styled elements
      case 'div':
      case 'span':
      case 'ol':
      case 'ul':
      case 'li':
      case 'ruby':
      case 'rt':
      case 'rp':
      case 'details':
      case 'summary':
        _renderGenericElement(buffer, node, tag, 'gloss-sc-$tag');
        break;
      default:
        // Fallback for unknown tags, treat as span
        _renderGenericElement(buffer, node, 'span', 'gloss-sc-span');
        break;
    }
  }

  void _renderGenericElement(
    StringBuffer buffer,
    Map<String, dynamic> node,
    String tag,
    String className,
  ) {
    buffer.write('<$tag class="$className"');
    _writeStandardAttributes(buffer, node);
    buffer.write('>');

    if (node.containsKey('content')) {
      _processContent(buffer, node['content']);
    }

    buffer.write('</$tag>');
  }

  void _renderTableCell(StringBuffer buffer, Map<String, dynamic> node) {
    final tag = node['tag'] ?? 'td';
    buffer.write('<$tag class="gloss-sc-$tag"');

    if (node.containsKey('colSpan')) {
      buffer.write(' colspan="${node['colSpan']}"');
    }
    if (node.containsKey('rowSpan')) {
      buffer.write(' rowspan="${node['rowSpan']}"');
    }

    _writeStandardAttributes(buffer, node);
    buffer.write('>');

    if (node.containsKey('content')) {
      _processContent(buffer, node['content']);
    }

    buffer.write('</$tag>');
  }

  void _renderLink(StringBuffer buffer, Map<String, dynamic> node) {
    // Handling hrefs
    String href = node['href'] ?? '';
    final bool isInternal = href.startsWith('?');
    
    // If external and base URL provided, logic can be adjusted here.
    // Assuming standard handling for now.
    
    buffer.write('<a class="gloss-link" href="$href"');
    buffer.write(isInternal ? ' data-external="false"' : ' target="_blank" rel="noreferrer noopener" data-external="true"');
    _writeStandardAttributes(buffer, node);
    buffer.write('>');

    // Link text wrapper
    buffer.write('<span class="gloss-link-text">');
    if (node.containsKey('content')) {
      _processContent(buffer, node['content']);
    }
    buffer.write('</span>');

    // External link icon
    if (!isInternal) {
       buffer.write('<span class="gloss-link-external-icon icon" data-icon="external-link"></span>');
    }

    buffer.write('</a>');
  }

  /// Replicates the complex image structure from JS `createDefinitionImage`
  void _renderImage(StringBuffer buffer, Map<String, dynamic> node) {
    final String path = node['path'] ?? '';
    final String? resolvedPath = _baseUrl != null ? '$_baseUrl/$path' : path;
    
    // Extract properties
    final num? width = node['width'];
    final num? height = node['height'];
    final num? preferredWidth = node['preferredWidth'];
    final num? preferredHeight = node['preferredHeight'];
    final String? sizeUnits = node['sizeUnits']; // 'px' or 'em'
    final String? verticalAlign = node['verticalAlign'];
    final bool collapsed = node['collapsed'] == true;
    
    // Calculate aspect ratio logic
    final bool hasPrefW = preferredWidth != null;
    final bool hasPrefH = preferredHeight != null;
    
    // Default to 100x100 if no dims provided, purely for calculation safety
    final double safeW = (width ?? 100).toDouble();
    final double safeH = (height ?? 100).toDouble();

    final double invAspectRatio = (hasPrefW && hasPrefH)
        ? (preferredHeight / preferredWidth)
        : (safeH / safeW);
        
    final double usedWidth = hasPrefW 
        ? preferredWidth.toDouble() 
        : (hasPrefH ? preferredHeight.toDouble() / invAspectRatio : safeW);

    // Build the outer anchor
    buffer.write('<a class="gloss-image-link" target="_blank" href="$resolvedPath"');
    
    if (collapsed) buffer.write(' data-collapsed="true"');
    if (verticalAlign != null) buffer.write(' data-vertical-align="$verticalAlign"');
    
    // Data attributes for JS interactivity if needed later
    buffer.write(' data-path="$path"');
    
    buffer.write('>'); // Open <a>

    // Container
    buffer.write('<span class="gloss-image-container" style="');
    
    // Container sizing
    String widthCss = '${usedWidth}px';
    if (sizeUnits == 'em') {
       widthCss = '${usedWidth}em';
    } else if (!hasPrefW && !hasPrefH && width == null) {
       // If no specific size is requested, standard behavior is usually max-width or auto
       // But based on JS, it sets specific width if available.
    }
    buffer.write('width: $widthCss;');
    
    if (node['border'] != null) buffer.write(' border: ${node['border']};');
    if (node['borderRadius'] != null) buffer.write(' border-radius: ${node['borderRadius']};');
    buffer.write('">'); // Open container

    // Sizer (maintain aspect ratio)
    buffer.write('<span class="gloss-image-sizer" style="padding-top: ${(invAspectRatio * 100).toStringAsFixed(4)}%;"></span>');

    // The actual image
    buffer.write('<img class="gloss-image" src="$resolvedPath"');
    // Yomitan sets 100% W/H on inner image because container handles size
    buffer.write(' style="width: 100%; height: 100%;"');
    if (node['alt'] != null) buffer.write(' alt="${_escapeHtml(node['alt'])}"' );
    buffer.write('>');

    buffer.write('</span>'); // Close container
    
    // Link text fallback (usually hidden by CSS unless collapsed)
    buffer.write('<span class="gloss-image-link-text">Image</span>');
    
    buffer.write('</a>'); // Close <a>
  }

  void _writeStandardAttributes(StringBuffer buffer, Map<String, dynamic> node) {
    // Lang
    if (node.containsKey('lang')) {
      buffer.write(' lang="${node['lang']}"');
    }

    // Title
    if (node.containsKey('title')) {
      buffer.write(' title="${_escapeHtml(node['title'])}"');
    }

    // Open (for details)
    if (node['open'] == true) {
      buffer.write(' open');
    }

    // Data attributes (mapped to data-sc-*)
    if (node.containsKey('data') && node['data'] is Map) {
      final Map<String, dynamic> dataMap = node['data'];
      dataMap.forEach((key, value) {
        // Convert camelCase to PascalCase for the attribute key logic seen in JS
        // JS: key = `sc${key[0].toUpperCase()}${key.substring(1)}`;
        if (key.isNotEmpty) {
           final String attrKey = 'data-sc-${key}';
           buffer.write(' $attrKey="$value"');
        }
      });
    }

    // Style
    if (node.containsKey('style') && node['style'] is Map) {
      final styleString = _mapStyleToCss(node['style']);
      if (styleString.isNotEmpty) {
        buffer.write(' style="$styleString"');
      }
    }
  }

  String _mapStyleToCss(Map<String, dynamic> style) {
    final sb = StringBuffer();

    // Helper for simple properties
    void add(String key, String? val) {
      if (val != null) sb.write('$key: $val; ');
    }
    
    // Helper for numeric/unit properties
    void addUnit(String key, dynamic val) {
      if (val == null) return;
      if (val is num) {
        sb.write('$key: ${val}em; ');
      } else {
        sb.write('$key: $val; ');
      }
    }

    // Mapping based on StructuredContentStyle interface
    add('font-style', style['fontStyle']);
    add('font-weight', style['fontWeight']);
    add('font-size', style['fontSize']);
    add('color', style['color']);
    add('background-color', style['backgroundColor'] ?? style['background']);
    
    // Text decoration
    var textDec = style['textDecorationLine'];
    if (textDec != null) {
      if (textDec is List) {
        add('text-decoration', textDec.join(' '));
      } else {
        add('text-decoration', textDec.toString());
      }
    }
    add('text-decoration-style', style['textDecorationStyle']);
    add('text-decoration-color', style['textDecorationColor']);

    add('border-color', style['borderColor']);
    add('border-style', style['borderStyle']);
    add('border-radius', style['borderRadius']);
    add('border-width', style['borderWidth']);
    
    add('vertical-align', style['verticalAlign']);
    add('text-align', style['textAlign']);
    add('margin', style['margin']);
    add('padding', style['padding']);
    add('cursor', style['cursor']);
    add('list-style-type', style['listStyleType']);
    add('word-break', style['wordBreak']);
    add('white-space', style['whiteSpace']);

    // Directional margin/padding (handles numbers as ems)
    addUnit('margin-top', style['marginTop']);
    addUnit('margin-bottom', style['marginBottom']);
    addUnit('margin-left', style['marginLeft']);
    addUnit('margin-right', style['marginRight']);
    
    addUnit('padding-top', style['paddingTop']);
    addUnit('padding-bottom', style['paddingBottom']);
    addUnit('padding-left', style['paddingLeft']);
    addUnit('padding-right', style['paddingRight']);

    return sb.toString();
  }

  String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }
  
  // Minimal CSS derived from structured-content.css and display.css
  static const String _coreCss = '''
    .structured-content { font-family: sans-serif; line-height: 1.5; }
    .gloss-sc-ruby { display: inline-block; text-indent: 0; }
    .gloss-sc-rt { display: ruby-text; font-size: 0.5em; }
    .gloss-sc-rp { display: none; }
    
    /* Tables */
    .gloss-sc-table-container { display: block; overflow-x: auto; }
    .gloss-sc-table { table-layout: auto; border-collapse: collapse; border-spacing: 0; }
    .gloss-sc-thead, .gloss-sc-tfoot, .gloss-sc-th { font-weight: bold; background-color: #eee; }
    .gloss-sc-th, .gloss-sc-td { border: 1px solid #ccc; padding: 0.25em; vertical-align: top; }
    
    /* Lists */
    .gloss-sc-ol, .gloss-sc-ul { margin: 0; padding-left: 1.5em; }
    .gloss-sc-details { padding-left: 1.4em; }
    .gloss-sc-summary { list-style-position: outside; cursor: pointer; }
    
    /* Links */
    .gloss-link { color: #00e; text-decoration: none; cursor: pointer; }
    .gloss-link:hover { text-decoration: underline; }
    .gloss-link-external-icon { 
      display: inline-block; vertical-align: middle; 
      width: 0.8em; height: 0.8em; margin-left: 0.25em; background-color: #00e; 
      mask-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath d='M14 3v2h3.59l-9.83 9.83 1.41 1.41L19 6.41V10h2V3h-7zm-2 16H5V5h7V3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2v-7h-2v7z'/%3E%3C/svg%3E");
      -webkit-mask-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath d='M14 3v2h3.59l-9.83 9.83 1.41 1.41L19 6.41V10h2V3h-7zm-2 16H5V5h7V3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2v-7h-2v7z'/%3E%3C/svg%3E");
      mask-size: contain; -webkit-mask-size: contain; mask-repeat: no-repeat; -webkit-mask-repeat: no-repeat;
    }

    /* Images */
    .gloss-image-link { display: inline-block; position: relative; max-width: 100%; vertical-align: top; }
    .gloss-image-container { display: inline-block; position: relative; line-height: 0; overflow: hidden; max-width: 100%; }
    .gloss-image-sizer { display: inline-block; width: 0; vertical-align: top; }
    .gloss-image-link[data-collapsed="true"] .gloss-image-container { display: none; }
    .gloss-image-link-text { display: none; }
    .gloss-image-link[data-collapsed="true"] .gloss-image-link-text { display: inline; text-decoration: underline; }
    .gloss-image-link[data-vertical-align="baseline"] { vertical-align: baseline; }
    .gloss-image-link[data-vertical-align="middle"] { vertical-align: middle; }
    .gloss-image-link[data-vertical-align="top"] { vertical-align: top; }
  ''';
}