import 'dart:async';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_params.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';
import 'package:dakanji_db_core/util/dakanji_db_search_manager.dart';
import 'package:dakanji_db_ui/dakanji_db_ui.dart';
import 'package:dakanji_db_ui/model/dakanji_db_settings.dart';
import 'package:dakanji_db_ui/widgets/search_results/dictionary_search_result_widget.dart';
import 'package:dakanji_db_ui/widgets/settings/search_settings_dialog.dart';
import 'package:dakanji_db_ui_search_example/search_results_localizations.dart';
import 'package:dakanji_db_ui_search_example/settings_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'globals.dart';
import 'init.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: const Color.fromARGB(255, 26, 93, 71)),
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<bool> copyDb;
  late DaKanjiDB daKanjiDB;
  
  // The new isolate controller
  DaKanjiDbSearchManager? _searchIsolate;

  DictionarySearchResult? lastSearchResult;
  TextEditingController searchController = TextEditingController();

  DaKanjiDbSettings _searchSettings = DaKanjiDbSettings(
    groupingRule: [
      const SequenceGroupingRule(sourceDictId: 3, targetDictIds: {3, 4})
    ],
  );

  @override
  void initState() {
    super.initState();
    printAssetList();
    copyDb = copyDbFromAssetsToFS().then((path) async {
      localDbPath = path;
      daKanjiDB = DaKanjiDB(dbPath: localDbPath, inMemory: false);

      // --- Initialize the Search Isolate ---
      _searchIsolate = DaKanjiDbSearchManager(
        daKanjiDB: daKanjiDB,
        debug: !kReleaseMode,
      );

      final List<IndexTableData> enabledIndexes =
          await daKanjiDB.indexDao.getAllEnabledIndexes();
      for (final index in enabledIndexes) {
        debugPrint("Enabled index: ${index.title} (ID: ${index.id})");
      }

      await initDaKanjiDbUi();
      return true;
    });
  }

  @override
  void dispose() {
    // Clean up the isolate when the widget is destroyed
    _searchIsolate?.dispose();
    searchController.dispose();
    super.dispose();
  }

  /// Helper to map UI settings + term to DB Search Params
  DictionarySearchParams _buildSearchParams(String term) {
    return DictionarySearchParams(
      query: term,
      normalizedSearch: _searchSettings.normalizedSearch,
      normalizedSearchConvertsRomajiToHiragana:
          _searchSettings.normalizeSearchConvertsRomajiToHiragana,
      deconjugationSearch: _searchSettings.deconjugationSearch,
      spellfixSearch: _searchSettings.spellfixSearch,
      groupingRules: _searchSettings.groupingRule,
      //limit: 100
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              final result = await showGeneralDialog<DaKanjiDbSettings>(
                context: context,
                barrierDismissible: true,
                barrierLabel: "Settings",
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return ScaleTransition(
                    scale: animation,
                    child: Center(
                      child: Material(
                        color: Colors.transparent,
                        child: DaKanjiDbSettingsDialog(
                          db: daKanjiDB,
                          settings: _searchSettings,
                          localization: dakanjiDbSettingsLocalization,
                        ),
                      ),
                    ),
                  );
                },
              );

              if (result != null) {
                setState(() {
                  _searchSettings = result;
                });
                
                // Re-run search with new settings if there is text
                if (searchController.text.isNotEmpty && _searchIsolate != null) {
                  // We treat this as an "immediate" update since the user just closed the dialog
                  _searchIsolate!.searchImmediate(
                    _buildSearchParams(searchController.text),
                    onResult: (result) {
                       if(mounted) setState(() => lastSearchResult = result);
                    }
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: copyDb,
            builder: (context, asyncSnapshot) {
              if (!asyncSnapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Setting up the database...'),
                  ],
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter a search term',
                            ),
                            onChanged: (value) {
                              if (_searchIsolate == null) return;

                              // Clear results immediately for a cleaner feel (optional)
                              if (value.isEmpty) {
                                setState(() => lastSearchResult = null);
                              }

                              // Delegate to Isolate
                              _searchIsolate!.search(
                                _buildSearchParams(value),
                                onResult: (result) {
                                  if (!mounted) return;
                                  setState(() {
                                    lastSearchResult = result;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        if (!kReleaseMode)
                          DropdownButton<String>(
                            value: "",
                            items: List.generate(
                                exampleDictionaryTerms.length,
                                (i) => DropdownMenuItem<String>(
                                    value: exampleDictionaryTerms[i],
                                    child: Text(exampleDictionaryTerms[i]))),
                            onChanged: (value) async {
                              if (_searchIsolate == null) return;
                              
                              final term = value ?? "";
                              searchController.text = term;
                              
                              setState(() {
                                lastSearchResult = null;
                              });

                              // Use immediate search for dropdowns
                              _searchIsolate!.searchImmediate(
                                _buildSearchParams(term),
                                onResult: (result) {
                                  if (!mounted) return;
                                  setState(() {
                                    lastSearchResult = result;
                                  });
                                }
                              );
                            },
                          )
                      ],
                    ),
                  ),

                  // Search Results
                  if (lastSearchResult != null)
                    Expanded(
                      child: DictionarySearchResultWidget(
                        result: lastSearchResult!,
                        db: daKanjiDB,
                        settings: _searchSettings,
                        localization: dakanjiDbLocalization,
                      ),
                    ),
                ],
              );
            }),
      ),
    );
  }
}