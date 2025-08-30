import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dakanji_db_ui/structured_content_widget.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        // Load the structured content from the local file.
        future: _loadStructuredContentFromFile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No structured content found.'));
          } else {
            // IMPORTANT: Replace this with the actual base path of your unzipped dictionary.
            const imageBasePath =
                "/Users/darioklepoch/dev/DaKanji/dakanji_db/samples/yomitan";

            return SelectableRegion(
              selectionControls: MaterialTextSelectionControls(),
              child: StructuredContentWidget(
                content: snapshot.data!,
                imageAssetBasePath: imageBasePath,
              ),
            );
          }
        },
      ),
    );
  }
}

/// Loads and parses the first structured content definition from a local file.
Future<Map<String, dynamic>?> _loadStructuredContentFromFile() async {
  const devYomitanPath =
      "/Users/darioklepoch/dev/DaKanji/dakanji_db/samples/yomitan/term_bank_2.json";
  final file = File(devYomitanPath);

  if (!await file.exists()) {
    throw Exception('File not found at "$devYomitanPath"');
  }

  final jsonString = await file.readAsString();
  final List<dynamic> termBank = jsonDecode(jsonString);

  if (termBank.isNotEmpty) {
    final entry = termBank.first;
    final definitions = entry[5] as List;

    for (final definition in definitions) {
      if (definition is Map && definition['type'] == 'structured-content') {
        return definition['content'] as Map<String, dynamic>;
      }
    }
  }
  return null; // No structured content found
}
