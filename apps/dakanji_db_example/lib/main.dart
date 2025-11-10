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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 26, 93, 71)),
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
                            searchDb(value);
                          },
                        ),
                      ),
                      SizedBox(width: 4.0),
                      DropdownButton<String>(
                        value: "",
                        items: List.generate(exampleDictionaryTerms.length, (i) => DropdownMenuItem<String>(
                          value: exampleDictionaryTerms[i],
                          child: Text(exampleDictionaryTerms[i])
                        )),
                        onChanged: (value) {
                          searchController.text = value ?? "";
                          searchDb(searchController.text);
                        },
                      )
                    ],
                  ),
                ),
                
                //search
                Expanded(
                  child: ListView(
                    children: [
                      if(lastSearchResult != null)
                        DictionarySearchResultWidget(
                          lastSearchResult!
                        )
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  Future searchDb(String term) async {
    if(term.isEmpty) {
      lastSearchResult = null;
    }
    else {
      print("Searching for: $term");
      Stopwatch stopwatch = Stopwatch()..start();
      lastSearchResult = await daKanjiDB.dBQueriesDao.dictionarySearch(
        term,
        normalizedSearch: false,
        normalizedSearchConvertsRomajiToHiragana: false,
        deconjugationSearch: false,
        spellfixSearch: false,
        groupByTermAndReading: true
      );
      print("Search completed in ${stopwatch.elapsedMilliseconds}ms.");
    }
    setState(() {});
  }
}
