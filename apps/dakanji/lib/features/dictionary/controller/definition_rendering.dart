import 'dart:async';
import 'dart:isolate';
import 'package:css_inline_flutter/css_inline_flutter.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/term/structured_content/html/structured_content_css.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/term/structured_content/html/structured_content_to_html.dart';
import 'package:drift/isolate.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:language_processing/language_processing.dart';


/// Data required to render a Yomitan definition into an HTML string.
/// Sent to the background isolate; the worker fetches [indexCss] itself.
typedef RenderRequest = ({
  List<dynamic> definitions,
  int indexId,
  bool compactMode,
  bool darkMode,
});

/// Init payload sent once when spawning the worker isolate.
typedef _IsolateInit = ({
  SendPort mainSendPort,
  DriftIsolate dbConnection,
  bool inMemory,
  Map<String, dynamic> processorState,
});

final _varRefRegex = RegExp(
  r'var\(\s*(--[\w-]+)\s*(?:,\s*([^)]+))?\s*\)',
);

/// Extracts all `--name: value` declarations from [css].
Map<String, String> _extractCssVariables(String css) {
  final vars = <String, String>{};
  final re = RegExp(r'(--[\w-]+)\s*:\s*([^;}\n]+)', multiLine: true);
  for (final m in re.allMatches(css)) {
    vars[m.group(1)!.trim()] = m.group(2)!.trim();
  }
  return vars;
}

/// Recursively resolves `var()` references inside a single CSS value string.
String _resolveVarInValue(
  String value,
  Map<String, String> vars, [
  int depth = 0,
]) {
  if (depth > 10 || !value.contains('var(')) return value;
  return value.replaceAllMapped(_varRefRegex, (m) {
    final resolved = vars[m.group(1)!];
    if (resolved != null) return _resolveVarInValue(resolved, vars, depth + 1);
    return m.group(2)?.trim() ?? m.group(0)!;
  });
}

/// Resolves all `var(--name)` / `var(--name, fallback)` references in [html]
/// using custom-property declarations found in [combinedCss].
/// Handles chained references (variables that reference other variables).
String resolveCssVariables(String html, String combinedCss) {
  final vars = _extractCssVariables(combinedCss);
  if (vars.isEmpty) return html;

  // First pass: resolve chained references within the variable map itself.
  for (final key in vars.keys.toList()) {
    vars[key] = _resolveVarInValue(vars[key]!, vars);
  }

  // Second pass: replace all remaining var() references in the HTML.
  return html.replaceAllMapped(_varRefRegex, (m) {
    final resolved = vars[m.group(1)!];
    if (resolved != null) return resolved;
    return m.group(2)?.trim() ?? m.group(0)!;
  });
}

/// Internal message wrapper for tracking requests across Isolate boundaries.
typedef _IsolateEnvelope = ({int id, RenderRequest request});
typedef _IsolateResponse = ({int id, NodeList nodes, bool isError});

/// A service that manages a persistent background Isolate for HTML rendering.
/// Avoids initializing the Rust bridge multiple times and allows for
/// concurrent rendering requests.
///
/// A serializable Drift connection is forwarded to the worker isolate so it
/// can open its own [DaDb] instance and fetch index CSS directly — the same
/// pattern used by [DaDbSearchManager] and the dictionary parsers.
class YomitanRenderService {
  late SendPort _workerSendPort;
  final _pendingRequests = <int, Completer<NodeList>>{};
  final _ready = Completer<void>();
  int _requestIdCounter = 0;

  Future<void> get isReady => _ready.future;

  YomitanRenderService(DaDb db) {
    _init(db);
  }

  Future<void> _init(DaDb db) async {
    final receivePort = ReceivePort();
    final connection = await db.attachedDatabase.serializableConnection();

    await Isolate.spawn(_workerEntry, (
      mainSendPort: receivePort.sendPort,
      dbConnection: connection,
      inMemory: db.inMemory,
      processorState: db.languageProcessor.toJson(),
    ));

    receivePort.listen((message) {
      if (message is SendPort) {
        _workerSendPort = message;
        _ready.complete();
      }
      else if (message is _IsolateResponse) {
        final completer = _pendingRequests.remove(message.id);
        if (message.isError) {
          completer?.completeError(message.nodes);
        }
        else {
          completer?.complete(message.nodes);
        }
      }
    });
  }

  /// Renders [definitions] for the dictionary entry identified by [indexId]
  /// into an inlined HTML string. All work runs in the background isolate.
  Future<NodeList> render(RenderRequest request) async {
    await isReady;

    final id = _requestIdCounter++;
    final completer = Completer<NodeList>();
    _pendingRequests[id] = completer;

    _workerSendPort.send((id: id, request: request));
    return completer.future;
  }

  /// The entry point for the background Isolate.
  static void _workerEntry(_IsolateInit init) async {
    final childReceivePort = ReceivePort();
    init.mainSendPort.send(childReceivePort.sendPort);

    // Initialize Rust bridge exactly once for the lifetime of this Isolate.
    await initInlineCss();

    // Reconnect to the database inside this isolate.
    final processor = LanguageProcessor.fromJson(init.processorState);
    await processor.init();
    final db = DaDb(
      executor: await init.dbConnection.connect(),
      inMemory: init.inMemory,
      languageProcessor: processor,
    );

    await for (final dynamic message in childReceivePort) {
      if (message is! _IsolateEnvelope) continue;

      final (:id, :request) = message;
      try {
        // Fetch index-specific CSS from the DB inside the worker isolate.
        final indexCss = await db.mediaDao.getCssFromIndex(request.indexId);

        // Convert JSON definitions to raw HTML.
        String html = renderDefinitions(
          request.definitions,
          compactMode: request.compactMode,
        );

        // Apply index-specific and global CSS.
        final globalCss = getStructuredContentCss(darkMode: request.darkMode);
        html = inlineFragmentSync(html: html, css: indexCss);
        html = inlineFragmentSync(html: html, css: globalCss);

        // Resolve CSS custom properties (var(--name)) since
        // flutter_widget_from_html does not support them natively.
        final combinedCss = '$indexCss\n$globalCss';
        html = resolveCssVariables(html, combinedCss);

        final nodes = parseHtmlToNodes(html);

        init.mainSendPort.send((id: id, nodes: nodes, isError: false));
      }
      catch (e) {
        init.mainSendPort.send((id: id, html: e.toString(), isError: true));
      }
    }
  }
}