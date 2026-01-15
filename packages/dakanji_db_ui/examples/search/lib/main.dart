import 'dart:async';

import 'package:async/async.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_params.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';
import 'package:dakanji_db_core/util/dakanji_db_search_settings.dart';
import 'package:dakanji_db_ui/dakanji_db_ui.dart';
import 'package:dakanji_db_ui/search_results/dictionary_search_result_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'globals.dart';
import 'init.dart';
import 'search_settings_dialog.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Color.fromARGB(255, 26, 93, 71)
        ),
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

  CancelableOperation<DictionarySearchResult?>? dbSearch;

  int debounceMilliseconds = 100;

  Timer? searchDebounceTimer;

  DictionarySearchResult? lastSearchResult;

  TextEditingController searchController = TextEditingController();

  DaKanjiDbSearchSettings _searchSettings = DaKanjiDbSearchSettings(
    groupingRule: [const SequenceGroupingRule(
      sourceDictId: 3,
      targetDictIds: {3, 4}
    )],
  );



  @override
  void initState() {
    super.initState();
    printAssetList();
    copyDb = copyDbFromAssetsToFS().then((path) async {
      localDbPath = path;
      daKanjiDB = DaKanjiDB(dbPath: localDbPath, inMemory: false);

      final List<IndexTableData> enabledIndexes = await daKanjiDB.indexDao.getAllEnabledIndexes();
      for (final index in enabledIndexes) {
        debugPrint("Enabled index: ${index.title} (ID: ${index.id})");
      }

      await initDaKanjiDbUi();

      return true;
    });
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
              final result = await showGeneralDialog<DaKanjiDbSearchSettings>(
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
                        child: SearchSettingsDialog(initialSettings: _searchSettings),
                      ),
                    ),
                  );
                },
              );

              // If we received data back, update the state and run the search
              if (result != null) {
                setState(() {
                  _searchSettings = result;
                });
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter a search term',
                          ),
                          onChanged: (value) async {
                            if(searchDebounceTimer != null) {
                              searchDebounceTimer!.cancel();
                              searchDebounceTimer = null;
                            }
                            if(dbSearch != null) {
                              await dbSearch!.cancel();
                              dbSearch = null;
                            }
                            setState(() {
                              lastSearchResult = null;
                            });
                            searchDebounceTimer = Timer(
                              Duration(milliseconds: debounceMilliseconds),
                              () {
                                dbSearch = CancelableOperation.fromFuture(searchDb(value));
                                dbSearch!.then((result) {
                                  lastSearchResult = result;
                                  searchDebounceTimer = null;
                                  setState(() {});
                                });
                              }
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 4.0),
                      if(!kReleaseMode)
                        DropdownButton<String>(
                          value: "",
                          items: List.generate(exampleDictionaryTerms.length, (i) => DropdownMenuItem<String>(
                            value: exampleDictionaryTerms[i],
                            child: Text(exampleDictionaryTerms[i])
                          )),
                          onChanged: (value) async {
                            setState(() {
                              searchController.text = "";
                              lastSearchResult = null;
                            });
                            searchController.text = value ?? "";
                            lastSearchResult = await searchDb(searchController.text);
                            setState(() {});
                          },
                        )
                    ],
                  ),
                ),
                
                //search
                if(lastSearchResult != null)
                  Expanded(
                    child: 
                      DictionarySearchResultWidget(
                        result: lastSearchResult!,
                        db: daKanjiDB,
                        settings: _searchSettings,
                      ),
                  ),
              ],
            );
          }
        ),
      ),
    );
  }

  Future<DictionarySearchResult?> searchDb(String term) async {
    DictionarySearchResult? result;
    if(term.isEmpty) {
      result = null;
    }
    else {
      debugPrint("Searching for: $term");
      Stopwatch stopwatch = Stopwatch()..start();
      result = await daKanjiDB.dBQueriesDao.dictionarySearch(
        DictionarySearchParams(
          query: term,
          normalizedSearch: _searchSettings.normalizedSearch,
          normalizedSearchConvertsRomajiToHiragana: _searchSettings.normalizeSearchConvertsRomajiToHiragana,
          deconjugationSearch: _searchSettings.deconjugationSearch,
          spellfixSearch: _searchSettings.spellfixSearch,
          groupingRules: _searchSettings.groupingRule,
        ),
        printDebugInfo: !kReleaseMode,
      );
      debugPrint("Search completed in ${stopwatch.elapsedMilliseconds}ms.");
    }
    return result;
  }
  
}
