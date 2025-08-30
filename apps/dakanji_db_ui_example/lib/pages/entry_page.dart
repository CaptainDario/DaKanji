import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dakanji_db_ui/structured_content_widget.dart';
import 'package:dakanji_db_shared/paths.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>?>(
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
                content: snapshot.data?.first,
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
Future<List<dynamic>?> _loadStructuredContentFromFile() async {
  final devYomitanPath = "$yomitanSampleDictionaryPath/term_bank_2.json";
  print(devYomitanPath);
  final file = File(devYomitanPath);

  if (!await file.exists()) {
    throw Exception('File not found at "$devYomitanPath"');
  }

  final jsonString = await file.readAsString();
  final List<dynamic> termBank = jsonDecode(jsonString);

  if (termBank.isNotEmpty) {
    final entry = termBank.first;
    final definitions = entry[5] as List;
    return definitions;
  }
  return null; // No structured content found
}
