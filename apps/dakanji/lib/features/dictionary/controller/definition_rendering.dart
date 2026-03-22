import 'dart:async';
import 'dart:isolate';
import 'package:css_inline_flutter/css_inline_flutter.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/term/structured_content/html/structured_content_css.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/term/structured_content/html/structured_content_to_html.dart';

/// Data required to render a Yomitan definition into an HTML string.
typedef RenderRequest = ({
  List<dynamic> definitions,
  String indexCss,
  bool compactMode,
  bool darkMode,
});

/// Internal message wrapper for tracking requests across Isolate boundaries.
typedef _IsolateEnvelope = ({int id, RenderRequest request});
typedef _IsolateResponse = ({int id, String html, bool isError});

/// A service that manages a persistent background Isolate for HTML rendering.
/// 
/// **Why this exists:**
/// 1. `initInlineCss` (Rust Bridge) has a high initialization cost.
/// 2. `compute()` spawns a new Isolate every time, re-triggering that cost.
/// 3. This service keeps one Isolate "hot" to handle requests instantly.
class YomitanRenderService {
  late SendPort _workerSendPort;
  final _pendingRequests = <int, Completer<String>>{};
  final _ready = Completer<void>();
  int _requestIdCounter = 0;

  Future<void> get isReady => _ready.future;

  YomitanRenderService() {
    _init();
  }

  Future<void> _init() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_workerEntry, receivePort.sendPort);

    receivePort.listen((message) {
      if (message is SendPort) {
        _workerSendPort = message;
        _ready.complete();
      }
      else if (message is _IsolateResponse) {
        final completer = _pendingRequests.remove(message.id);
        if (message.isError) {
          completer?.completeError(message.html);
        }
        else {
          completer?.complete(message.html);
        }
      }
    });
  }

  /// Sends rendering data to the background Isolate and returns the HTML string.
  Future<String> render(RenderRequest request) async {
    await isReady;

    final id = _requestIdCounter++;
    final completer = Completer<String>();
    _pendingRequests[id] = completer;

    _workerSendPort.send((id: id, request: request));
    return completer.future;
  }

  /// The entry point for the background Isolate.
  static void _workerEntry(SendPort mainSendPort) async {
    final childReceivePort = ReceivePort();
    mainSendPort.send(childReceivePort.sendPort);

    // Initialize Rust bridge exactly once for the lifetime of this Isolate.
    await initInlineCss();

    await for (final dynamic message in childReceivePort) {
      if (message is! _IsolateEnvelope) continue;

      final (:id, :request) = message;
      try {
        // Convert JSON definitions to raw HTML
        String html = renderDefinitions(
          request.definitions, 
          compactMode: request.compactMode,
        );

        // Apply index-specific and global CSS
        html = inlineFragmentSync(html: html, css: request.indexCss);
        html = inlineFragmentSync(
          html: html, 
          css: getStructuredContentCss(darkMode: request.darkMode),
        );

        mainSendPort.send((id: id, html: html, isError: false));
      }
      catch (e) {
        mainSendPort.send((id: id, html: e.toString(), isError: true));
      }
    }
  }
}