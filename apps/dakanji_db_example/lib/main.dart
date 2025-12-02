import 'dart:async';

import 'package:async/async.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_example/init.dart';
import 'package:dakanji_db_example/search_results/dictionary_search_result_widget.dart';
import 'package:flutter/material.dart';

import 'globals.dart';


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

  @override
  void initState() {
    super.initState();
    printAssetList();
    copyDb = copyDbFromAssetsToFS().then((path) {
      localDbPath = path;
      daKanjiDB = DaKanjiDB(dbPath: localDbPath, inMemory: false);
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
                      DictionarySearchResultWidget(lastSearchResult!, daKanjiDB),
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
      print("Searching for: $term");
      Stopwatch stopwatch = Stopwatch()..start();
      result = await daKanjiDB.dBQueriesDao.dictionarySearch(
        term,
        normalizedSearch: false,
        normalizedSearchConvertsRomajiToHiragana: false,
        deconjugationSearch: false,
        spellfixSearch: false,
        groupByTermAndReading: true
      );
      print("Search completed in ${stopwatch.elapsedMilliseconds}ms.");
    }
    return result;
  }
  
}
