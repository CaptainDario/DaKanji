import 'dart:async';
import 'dart:isolate';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';

import 'package:get_it/get_it.dart';
import 'package:kagome_dart/kagome_dart.dart';
import 'package:isar/isar.dart';
import 'package:tuple/tuple.dart';
import 'package:database_builder/src/jm_enam_and_dict_to_Isar/data_classes.dart' as isar_jm;
import 'package:database_builder/src/kanjiVG_to_Isar/data_classes.dart' as isar_kanji;
import 'package:database_builder/src/kanjidic2_to_Isar/data_classes.dart' as isar_kanjidic;
import 'package:kana_kit/kana_kit.dart';



class SearchIsolate {

  /// In which languages meanings should be searched
  List<String> languages;

  /// The receive port of the main isolate
  ReceivePort? receivePort;
  /// The send port of the main isolate
  SendPort? sendPort;
  /// the send port of the spawned isolate
  SendPort? isolateSendPort;
  /// The spawned isolate
  Isolate? isolate;
  /// The queue for the results of the search isolate
  StreamQueue? events;
  /// A name fot this isolate 
  String? debugName;

  /// Has the isolate been initialized
  bool _initialized = false;


  SearchIsolate(
    this.languages,
    {
      this.debugName,
      int no_processes = 2
    }
  );

  /// Initializes the isolate.
  /// 
  /// Warning: this needs to be called before any other function
  /// Note: `noIsolates` needs to be larger than 0
  void init(int isolateNo, int noIsolates) async {

    if(noIsolates < 1){
      throw Exception("`noIsolates` needs to be larger than 0");
    }

    receivePort = ReceivePort();
    sendPort = receivePort!.sendPort;

    isolate = await Isolate.spawn(
      _searchInIsar, 
      receivePort!.sendPort,
      debugName: debugName
    );

    // Convert the ReceivePort into a StreamQueue to receive messages from the
    // spawned isolate using a pull-based interface. Events are stored in this
    // queue until they are accessed by `events.next`.
    events = StreamQueue<dynamic>(receivePort!);

    // The first message from the spawned isolate is a SendPort. This port is
    // used to communicate with the spawned isolate.
    isolateSendPort = await events!.next;

    // init isolate
    isolateSendPort!.send(languages);
    isolateSendPort!.send(isolateNo);
    isolateSendPort!.send(noIsolates);

    _initialized = true;
  }

  /// Kills the isolate, this should be called before discarding this object.
  void kill() {
    _checkInitialized();

    receivePort!.sendPort.send(null);

    _initialized = false;
  }

  /// convenience function to check if `init()` was called.
  /// Throws an Exxception if it was not initialized.
  void _checkInitialized() {
    if(!_initialized) throw Exception("The isolate needs to be ");
  }

  // Spawns an isolate and asynchronously sends a list of filenames for it to
  // read and decode. Waits for the response containing the decoded JSON
  // before sending the next.
  //
  // Returns a stream that emits the JSON-decoded contents of each file.
  Future<List<isar_jm.Entry>> query(String query) async {
    _checkInitialized();

    List<isar_jm.Entry> result = [];

    if(query != ""){
      String queryHira = query, queryKata = query;
      
      //query = deconjugate(query);

      isolateSendPort!.send(query);
      result = await events!.next;
    }
    else{
      result = [];
    }


    return result;
  }
}



// The entrypoint that runs on the spawned isolate. Receives queries from
// the main isolate, searches in ISAR, and sends the result back to the main isolate.
Future<void> _searchInIsar(SendPort p) async {

  // Send a SendPort to the main isolate so that it can send messages
  final commandPort = ReceivePort();
  p.send(commandPort.sendPort);

  // convert the receive port to a queue to get the init arguments
  var events = StreamQueue<dynamic>(commandPort);
  List<String> langs = await events.next;
  int isolateNo  = await events.next;
  int noIsolates = await events.next;

  // open isar
  Isar isar = Isar.openSync(
    [isar_kanji.KanjiSVGSchema, isar_jm.EntrySchema, isar_kanjidic.Kanjidic2EntrySchema],
  );

  int noEntries = isar.entrys.countSync();
  int idRangeStart = isolateNo * (noEntries/noIsolates).floor();
  int idRangeEnd   = (isolateNo+1) * (noEntries/noIsolates).floor();

  KanaKit kanaKit = KanaKit();

  debugPrint('Spawned isolate started, args: langs - ${langs}; isolateNo - ${isolateNo}; idRangeStart - ${idRangeStart}; idRangeEnd - ${idRangeEnd}');


  // Wait for messages from the main isolate.
  await for (final message in events.rest) {
    if (message is String) {
      Stopwatch s = Stopwatch()..start();
      debugPrint("message = " + message);

      String messageKata = kanaKit.toKatakana(message);
      String messageHira = kanaKit.toHiragana(message);

      bool kataOnly  = kanaKit.isKatakana(messageKata);
      bool hiraOnly  = kanaKit.isHiragana(messageHira);

      QueryBuilder<isar_jm.Entry, isar_jm.Entry, QAfterFilterCondition> q;
      
      q = isar.entrys.where().

      // limit this process to one chunk of size (entries.length / num_processes)
        idBetween(idRangeStart, idRangeEnd)

      .filter()

      // search over kanji
        .optional(message.length == 1, (t) => 
          t.kanjisElementStartsWith(message)
        ).or()
        .optional(message.length > 1, (t) => 
          t.kanjisElementContains(message)
        )

      .or()

      // search over readings
      .optional(kataOnly, (q) => 
        q.optional(messageKata.length == 1, (t) => 
          t.readingsElementStartsWith(messageKata)
        ).or()
        .optional(messageKata.length > 1, (t) => 
          t.readingsElementContains(messageKata)
        )
      )
      .or()
      .optional(hiraOnly, (q) => 
        q.optional(messageHira.length == 1, (t) => 
          t.readingsElementStartsWith(messageHira)
        ).or()
        .optional(messageHira.length > 1, (t) => 
          t.readingsElementContains(messageHira)
        )
      )
      .or()
      .readingsElementContains(message)

      .or()
      
      // search over meanings
      .meaningsElement((meaning) => 
        meaning.anyOf(langs, (m, lang) => m
          .languageEqualTo(lang)
          .optional(message.length < 3, (m) => m
            .meaningsElementStartsWith(message)
          )
          .optional(message.length >= 3, (m) => m
            .meaningsElementContains(message)
          )
        )
      );
      

      List<isar_jm.Entry> results = q.limit(1000).findAllSync();
      results = sortJmdictList(results, message, langs);

      // Send the result to the main isolate.
      p.send(results);
      print("len ${results.length} time: ${s.elapsed}");
    }
    else if (message == null) {
      // Exit if the main isolate sends a null message, indicating there are no
      // more files to read and parse.
      break;
    }
  }

  print('Spawned isolate finished.');
  Isolate.exit();
}

/// Sorts a list of Jmdict entries given a query text. The order is determined
/// by those sorting criteria:
/// 
/// 1. Full Match > Match at the beginning > Match somwhere in the word
///    Those three categories are sorted individually and merged in the end
///   2.  sort inside each category based on <br/>
List<isar_jm.Entry> sortJmdictList(
  List<isar_jm.Entry> entries, 
  String queryText,
  List<String> languages)
  {

  /// lists with three sub lists
  /// 0 - full matchs 
  /// 1 - matchs starting at the word beginning 
  /// 2 - other matches
  List<List<isar_jm.Entry>> matches = [[], [], []];
  List<List<int>> matchIndices = [[], [], []];
  String queryTextHira = KanaKit().toHiragana(queryText);

  // iterate over the entries and create a ranking for each 
  for (isar_jm.Entry entry in entries) {
    // KANJI
    Tuple3 result = rankMatches(entry.kanjis, queryText);
    
    // KANA
    if(result.item1 == -1)
      result = rankMatches(entry.readings, queryTextHira);
    
    // MEANING
    // filter all langauges that are selected in the settings and join them to 
    // a list
    if(result.item1 == -1){
      List<String> k = entry.meanings.where((isar_jm.LanguageMeanings e) =>
          languages.contains(e.language)
        ).map((isar_jm.LanguageMeanings e) => 
          e.meanings!
        ).expand((e) => e).toList();
      result = rankMatches(k, queryText);
    }

    if(result.item1 != -1){
      matches[result.item1].add(entry);
      matchIndices[result.item1].add(result.item3);
    }
  }

  matches[0] = sortEntriesByInts(matches[0], matchIndices[0]);
  matches[1] = sortEntriesByInts(matches[1], matchIndices[1]);
  matches[2] = sortEntriesByInts(matches[2], matchIndices[2]);
  return matches.expand((element) => element).toList();
}

/// Sorts a string list based on `queryText`. The sorting criteria are
/// explained by `sortJmdictList`.
///
/// Returns a Tuple with the structure: <br/>
///   1 - if it was a full (0), start(1) or other(2) match <br/>
///   2 - how many characters are in the match but not in `queryText` <br/>
///   3 - the index where the search matched <br/>
Tuple3<int, int, int> rankMatches(List<String> matches, String queryText) {   

  int result = -1, lenDiff = -1;

  // check if the word contains the query
  int matchIndex = matches.indexWhere((element) => element.contains(queryText));
  if(matchIndex != -1){
    // check kanji for full match
    if(matches[matchIndex] == queryText){
      result = 0;
    }
    // does the found dict entry start with the search term
    else if(matches[matchIndex].startsWith(queryText)){
      result = 1;
    }
    // how many additional characters does this entry include
    else {
      result = 2;
    }
    /// calculatt the difference in length between the query and the result
    lenDiff = matches[matchIndex].length - queryText.length;
  }

  return Tuple3(result, lenDiff, matchIndex);
}

/// Sorts list `a` based on the values in `b` and returns it.
/// 
/// Throws an exception if the lists do not have the same length.
List<isar_jm.Entry> sortEntriesByInts(List<isar_jm.Entry> a, List<int> b){

  assert (a.length == b.length);

  List<Tuple2<isar_jm.Entry, int>> combined = List.generate(b.length,
    (i) => Tuple2(a[i], b[i])
  );
  combined.sort(
    (_a, _b) => _a.item2 - _b.item2
  );

  return  combined.map((e) => e.item1).toList();
}


/// Deconjugates the given `text` if it is a conjugate verb / adj / nouns
String deconjugate(String text){

  String ret = "";

  if(GetIt.I<KanaKit>().isJapanese(text)){
    var t = GetIt.I<Kagome>().runAnalyzer(text, AnalyzeModes.normal);
    
    for (int i = 0; i < t.item2.length; i++) {
      // deflect verbs / adjectives / nouns if they are conjugated
      if((t.item2[i][0] == "動詞" || t.item2[i][0] == "形容詞" ||
        t.item2[i][0] == "形状詞" || t.item2[i][0] == "名詞") 
        && t.item2[i][7] != t.item1[i]){
        t.item1[i] = t.item2[i][7];
        // ... and remove the conjugated ending
        if(t.item1.length > i+1 && t.item2[i+1][0] == "助動詞"){
          t.item1[i+1] = "";
        }
      }
    }

    ret = t.item1.join() ;
  }

  return ret;
}