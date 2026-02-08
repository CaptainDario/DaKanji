import 'dart:async';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:dakanji_db_core/database/search_profiles/search_profiles_entry.dart';
import 'package:dakanji_db_core/util/dakanji_db_search_manager.dart';
import 'package:dakanji_db_ui/dakanji_db_ui.dart';
import 'package:dakanji_db_ui/model/dakanji_db_localization.dart';
import 'package:dakanji_db_ui/widgets/search_results/dictionary_search_result_widget.dart';
import 'package:dakanji_db_ui/widgets/settings/search_profile_selector.dart';
import 'package:dakanji_db_ui/widgets/settings/search_profile_settings_dialog.dart';
import 'package:dakanji_db_ui_search_example/settings_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:language_processing/language_processing.dart';
import 'package:provider/provider.dart';

import 'globals.dart';
import 'init.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = _initializeDependencies();
  }

  Future<void> _initializeDependencies() async {
    printAssetList();
    final path = await copyDbFromAssetsToFS();
    
    localDbPath = path;
    final daKanjiDB = DaKanjiDB(
      dbPath: localDbPath,
      inMemory: false,
      languageProcessor: JapaneseProcessor()
    );
    GetIt.I.registerSingleton<DaKanjiDB>(daKanjiDB);

    // --- Initialize the Search Isolate ---
    final searchManager = DaKanjiDbSearchManager(
      daKanjiDB: daKanjiDB,
      debug: !kReleaseMode,
    );
    GetIt.I.registerSingleton<DaKanjiDbSearchManager>(searchManager);
    GetIt.I.registerSingleton<DakanjiDbLocalization>(dakanjiDbLocalization);

    final List<IndexEntry> enabledIndexes =
        await daKanjiDB.indexDao.getAllEnabledIndexes();
    for (final index in enabledIndexes) {
      debugPrint("Enabled index: ${index.title} (ID: ${index.id})");
    }

    await initDaKanjiDbUi();
  }

  @override
  void dispose() {
    // Clean up the isolate when the app is destroyed
    if (GetIt.I.isRegistered<DaKanjiDbSearchManager>()) {
      GetIt.I<DaKanjiDbSearchManager>().dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFuture,
      builder: (context, snapshot) {
        // Show loading screen while initializing
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            title: title,
            themeMode: ThemeMode.dark,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: const Color.fromARGB(255, 26, 93, 71)),
            ),
            home: const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Setting up the database...'),
                  ],
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
           return MaterialApp(
             home: Scaffold(
               body: Center(
                 child: Text("Error initializing: ${snapshot.error}"),
               ),
             ),
           );
        }

        // Dependencies are ready, wrap the app in the StreamProvider
        return StreamProvider<SearchProfilesEntry>(
          create: (_) => GetIt.I<DaKanjiDB>().searchProfilesDao.watchActiveProfile(),
          initialData: SearchProfilesEntry(),
          child: MaterialApp(
            title: title,
            themeMode: ThemeMode.dark,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: const Color.fromARGB(255, 26, 93, 71)),
            ),
            home: MyHomePage(title: title),
          ),
        );
      },
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
  DictionarySearchResult? lastSearchResult;
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch settings from the global provider
    final searchManager = GetIt.I<DaKanjiDbSearchManager>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          SearchProfileSelector(),

          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              // This works now because Provider is above MaterialApp
              await showGeneralDialog<SearchProfilesEntry>(
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
                        child: SearchProfileSettingsDialog(),
                      ),
                    ),
                  );
                },
              );
    
              // Re-run search with new settings if there is text
              if (searchController.text.isNotEmpty) {
                searchManager.searchImmediate(
                  (await GetIt.I<DaKanjiDB>().searchProfilesDao.getActiveProfile())
                    .toDictionarySearchParams(searchInput: searchController.text),
                  onResult: (result) {
                      if(mounted) setState(() => lastSearchResult = result);
                  }
                );
              }
            }
          ),
        ],
      ),
      body: Center(
        child: Column(
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
                      onChanged: (value) async {
                        // Clear results immediately for a cleaner feel (optional)
                        if (value.isEmpty) {
                          setState(() => lastSearchResult = null);
                        }

                        // Delegate to Isolate
                        searchManager.search(
                          (await GetIt.I<DaKanjiDB>().searchProfilesDao.getActiveProfile())
                            .toDictionarySearchParams(searchInput: value,),
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
                        final term = value ?? "";
                        searchController.text = term;
                        
                        setState(() {
                          lastSearchResult = null;
                        });

                        // Use immediate search for dropdowns
                        searchManager.searchImmediate(
                          (await GetIt.I<DaKanjiDB>().searchProfilesDao.getActiveProfile())
                            .toDictionarySearchParams(searchInput: term),
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
                  // Localization is registered in GetIt now
                  localization: GetIt.I<DakanjiDbLocalization>(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}