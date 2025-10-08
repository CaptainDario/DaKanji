import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:path/path.dart' as p;

import 'package:disjoint_set/disjoint_set.dart'; 



/// Converts the Tatoeba files from the input directory to the DaKanji DB
/// example sentence format by parsing the `sentences.csv` and `links.csv` files
/// in the `input_directory`
Future<void> convertTatoebaDataSource(
  File inputLinks, File inputSentences, Directory outputDirectory) async {

  outputDirectory.createSync();

  final List<Set<int>> linkedSentences = await Isolate.run(() async
    => await loadLinks(inputLinks));
  final Map<int, (String, String)> sentences = await Isolate.run(() async
    => await loadSentences(inputSentences));

  int i = 0;
  for (var linkedSentence in linkedSentences) {

    // get all examples from this group
    List<(String, String)> sentenceGroup = linkedSentence.map((id) =>
      sentences[id])
      .nonNulls.toList();

    // filter out groups that do not contain Japanese examples
    if (sentenceGroup.every((sentence) => sentence.$1 != 'jpn')) continue;
    i++;

    File sentenceFile = File(p.join(outputDirectory.path, '$i.json'));
    sentenceFile.createSync();
    sentenceFile.writeAsStringSync(jsonEncode(
      { for (var record in sentenceGroup) record.$1 : record.$2 }
    ));

    //if(i >= 10) return;

  }

}


/// Creates a DisjointSet from tatoeba's `links.csv` and returns all sentence groups.
Future<List<Set<int>>> loadLinks(File linksArchiveFile) async {

  final linksStream = getStringStreamFromTarBz2File(linksArchiveFile);

  DisjointSet<int> links = DisjointSet();

  await for (var line in linksStream) {
    var columns = line.split('\t');
    if (columns.length == 2) {
      var id1 = int.tryParse(columns[0])!;
      var id2 = int.tryParse(columns[1])!;

      links.makeSet(id1);
      links.makeSet(id2);
      links.union(id1, id2);
    }
  }

  return links.getAllSets();

}

/// Loads all example sentences from tatoeba's `sentences.csv`
Future<Map<int, (String, String)>> loadSentences(File sentencesArchiveFile) async {

  final sentencesLineStream = getStringStreamFromTarBz2File(sentencesArchiveFile);

  Map<int, (String, String)> sentences = {};

  await for (var line in sentencesLineStream) {
    var columns = line.split('\t');
    if (columns.length == 3) {
      var id = int.tryParse(columns[0]) ?? 0;
      var lang = columns[1];
      var text = columns[2];
      sentences[id] = (lang, text);
    }
  }

  return sentences;

}