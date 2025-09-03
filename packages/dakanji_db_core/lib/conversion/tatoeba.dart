import 'dart:io';

import 'package:dakanji_db_core/iso/iso_table.dart';
import 'package:path/path.dart' as p;

import 'package:disjoint_set/disjoint_set.dart'; 




/// Converts the Tatoeba archive file (tatoeba.tar.bz2) to the DaKanji DB example
/// sentence format.
/// See also [convertTatoebaFiles]
Future<void> convertTatoebaArchive() async {
  
  // TODO

}

/// Converts the Tatoeba files from the input directory to the DaKanji DB
/// example sentence format by parsing the `sentences.csv` and `links.csv` files
/// in the `input_directory`
Future<void> convertTatoebaFiles(Directory inputDirectory, Directory outputDirectory) async {

  outputDirectory.createSync();
  
  final List<Set<int>> linkedSentences = loadLinks(inputDirectory);
  final Map<int, (String, String)> sentences = loadSentences(inputDirectory);

  int i = 0;
  for (var linkedSentence in linkedSentences) {

    // get all examples from this group
    List<(String, String)> sentenceGroup = linkedSentence.map((id) =>
      sentences[id]!)
    .toList();

    // filter out groups that do not contain Japanese examples
    if (sentenceGroup.every((sentence) => sentence.$1 != 'jpn')) continue;
    i++;

    Directory groupDir = Directory(p.join(outputDirectory.path, '$i'));
    groupDir.createSync();

    for (var sentence in sentenceGroup) {
      try {
        File sentenceFile = File(p.join(groupDir.path, isoToIso639_1[sentence.$1]!.name));
        sentenceFile.createSync();
        sentenceFile.writeAsStringSync(sentence.$2);
      } catch (e) {
        print('Error writing sentence file for language ${sentence.$1}');
      }
    }

    if(i >= 10) return;

  }

}


/// Creates a DisjointSet from tatoeba's `links.csv` and returns all sentence groups.
List<Set<int>> loadLinks(Directory inputDirectory) {

  final linksFile = File(p.join(inputDirectory.path, 'links.csv'));

  final linksContent = linksFile.readAsStringSync();
  final linkLinkes = linksContent.split('\n')
    .where((line) => line.isNotEmpty).toList();

  DisjointSet<int> links = DisjointSet();

  for (var line in linkLinkes) {
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
Map<int, (String, String)> loadSentences(Directory inputDirectory) {

  final sentencesFile = File(p.join(inputDirectory.path, 'sentences.csv'));

  final sentencesContent = sentencesFile.readAsStringSync();
  final sentencesLines = sentencesContent.split('\n')
    .where((line) => line.isNotEmpty).toList();

  Map<int, (String, String)> sentences = {};

  for (var line in sentencesLines) {
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