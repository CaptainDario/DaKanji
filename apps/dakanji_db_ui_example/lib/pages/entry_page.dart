import 'dart:convert';
import 'dart:io';
import 'package:dakanji_db_ui/definitions_widget.dart';
import 'package:path/path.dart' as p;

import 'package:dakanji_db_core/parsing/term/structured_content/structured_content_parser.dart';
import 'package:flutter/material.dart';
import 'package:dakanji_db_shared/paths.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {

  List<dynamic> allSamples = [];

  int currentSampleIdx = 0;
  

  @override
  void initState() {
    super.initState();
    getAllSamples();
  }

  Future<bool> wait() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        // Load the structured content from the local file.
        future: Future.sync(() => true),
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data == false) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // IMPORTANT: Replace this with the actual base path of your unzipped dictionary.
            final imageBasePath = yomitanSampleDictionaryPath;

            String definitions = extractPlainTextDefinitions(allSamples[currentSampleIdx])
              .map((def) => "\t\t\t\t${def.text}").join("\n");

            return Column(
              children: [
                DropdownButton<int>(
                  items: List.generate(allSamples.length, (i) => 
                    DropdownMenuItem(value:i, child: Text("$i"))
                  ),
                  onChanged: (int? value) {
                    setState(() {
                      currentSampleIdx = value ?? 0;
                    });
                  },
                  value: currentSampleIdx,
                ),
                Divider(),
                Expanded(
                  child: SelectableRegion(
                    selectionControls: MaterialTextSelectionControls(),
                    child: ListView(
                      children: [
                        ExpansionTile(
                          title: Text("Definitions found"),
                          children: [
                            Align(
                              alignment: AlignmentGeometry.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(definitions),
                              )
                            ),
                          ],
                        ),
                        
                        Divider(),
                        DefinitionsWidget(
                          definitions: allSamples[currentSampleIdx],
                          imageAssetBasePath: imageBasePath,
                        ),
                      ],
                    ),
                  ),
                )
              ]
            );
          }
        },
      ),
    );
  }

  void getAllSamples() {
    final dir = Directory(yomitanSampleDictionaryPath);
    final files = dir.listSync()
      .whereType<File>()
      .where((f) => p.basename(f.absolute.path).startsWith('term_bank'))
      .toList();

    allSamples = [];
    for (var file in files) {
      final jsonString = file.readAsStringSync();
      final List<dynamic> termBank = jsonDecode(jsonString);

      if (termBank.isNotEmpty) {
        allSamples.addAll(
          termBank.map((e) => e[5])
        );
      }
    }
  }
}


